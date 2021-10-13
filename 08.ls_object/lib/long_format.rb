# frozen_string_literal: true

require './lib/all_files'

module LS
  class LongFormat
    MODE_TABLE = {
      '0' => '---',
      '1' => '-x-',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }.freeze

    def initialize(pathname,reverse, dot_match)
      @pathname = pathname
      @collected_files = LS::AllFiles.new(pathname, reverse, dot_match)
    end

    def list
      total = "total #{@collected_files.total_blocks}"
      body = @collected_files.files.map do |file|
        [
          file.type_and_mode,
          "  #{file.nlink.to_s.rjust(@collected_files.max_nlink_size)}",
          " #{file.user.ljust(@collected_files.max_user_size)}",
          "  #{file.group.ljust(@collected_files.max_group_size)}",
          "  #{file.size.to_s.rjust(@collected_files.max_size_size)}",
          " #{file.mtime}",
          " #{file.basename}"
        ].join
      end.join("\n")
      [total, body].join("\n")
    end

    private

    def render_long_format_body(row_data)
      max_sizes = %i[nlink user group size].map do |key|
        find_max_size(row_data, key)
      end
      require 'byebug'; byebug
      row_data.map do |data|
        format_row(data, *max_sizes)
      end
    end

    def find_max_size(row_data, key)
      row_data.map { |data| data[key].size }.max
    end

    def format_type_and_mode(file_path)
      pathname = Pathname(file_path)
      type = pathname.directory? ? 'd' : '-'
      mode = format_mode(pathname.stat.mode)
      "#{type}#{mode}"
    end

    def format_row(data, max_nlink, max_user, max_group, max_size)
      [
        data[:type_and_mode],
        "  #{data[:nlink].rjust(max_nlink)}",
        " #{data[:user].ljust(max_user)}",
        "  #{data[:group].ljust(max_group)}",
        "  #{data[:size].rjust(max_size)}",
        " #{data[:mtime]}",
        " #{data[:basename]}"
      ].join
    end

    def format_mode(mode)
      digits = mode.to_s(8)[-3..-1]
      digits.each_char.map do |c|
        MODE_TABLE[c]
      end.join
    end
  end
end
