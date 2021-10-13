# frozen_string_literal: true

require './lib/file_collector'

module LS
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
      @pathname = pathname
      @collected_files = LS::FileCollector.new(pathname: pathname, reverse: reverse, dot_match: dot_match)
    end

    def list
      total = "total #{@collected_files.total_blocks}"
      body = @collected_files.files.map do |file|
        [
          file.type_and_mode,
          "  #{file.nlink.to_s.rjust(@collected_files.max_length_list[:nlink])}",
          " #{file.user.ljust(@collected_files.max_length_list[:user])}",
          "  #{file.group.ljust(@collected_files.max_length_list[:group])}",
          "  #{file.size.to_s.rjust(@collected_files.max_length_list[:size])}",
          " #{file.mtime}",
          " #{file.basename}"
        ].join
      end.join("\n")
      [total, body].join("\n")
    end
  end
end
