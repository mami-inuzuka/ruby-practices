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

    def initialize(pathname:, reverse: false, dot_match: false)
      @pathname = pathname
      @all_files = LS::AllFiles.new(pathname: pathname, reverse: reverse, dot_match: dot_match)
    end

    def list
      total = "total #{@all_files.total_blocks}"
      body = @all_files.collected_files.map do |file|
        [
          file.type_and_mode,
          "  #{file.nlink.to_s.rjust(@all_files.max_nlink_size)}",
          " #{file.user.ljust(@all_files.max_user_size)}",
          "  #{file.group.ljust(@all_files.max_group_size)}",
          "  #{file.size.to_s.rjust(@all_files.max_size_size)}",
          " #{file.mtime}",
          " #{file.basename}"
        ].join
      end.join("\n")
      [total, body].join("\n")
    end
  end
end
