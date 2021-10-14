# frozen_string_literal: true

require './lib/file_collector'

module LS
  #
  # lオプションが指定された時のフォーマットに変換するクラス
  #
  class LongFormatter
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
      @collected_files = LS::FileCollector.new(pathname: pathname, reverse: reverse, dot_match: dot_match)
    end

    def list
      total = "total #{@collected_files.total_blocks}"
      body = render_body
      [total, body].join("\n")
    end

    private

    def render_body
      max_sizes = %i[nlink user group size].map do |key|
        @collected_files.max_length_list[key]
      end
      @collected_files.files.map do |file|
        format_row(file, *max_sizes)
      end.join("\n")
    end

    def format_row(file, max_nlink, max_user, max_group, max_size)
      [
        file.info[:type_and_mode],
        "  #{file.info[:nlink].to_s.rjust(max_nlink)}",
        " #{file.info[:user].ljust(max_user)}",
        "  #{file.info[:group].ljust(max_group)}",
        "  #{file.info[:size].to_s.rjust(max_size)}",
        " #{file.info[:mtime]}",
        " #{file.info[:basename]}"
      ].join
    end
  end
end
