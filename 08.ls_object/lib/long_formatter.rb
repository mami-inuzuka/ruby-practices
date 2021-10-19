# frozen_string_literal: true

require_relative 'file_collector'

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
      max_sizes = %i[nlink user group size].map { |key| @collected_files.max_length_list[key] }
      @collected_files.files.map { |file| format_row(file.info, *max_sizes) }.join("\n")
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
  end
end
