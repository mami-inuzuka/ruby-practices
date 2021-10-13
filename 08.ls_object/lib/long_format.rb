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
      @collected_files = LS::AllFiles.new(pathname: pathname, reverse: reverse, dot_match: dot_match)
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
  end
end
