# frozen_string_literal: true

require 'etc'

module LS
  #
  # ファイルについての情報を取得するクラス
  #
  class File
    attr_reader :info

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

    def initialize(file_path)
      @stat = ::File::Stat.new(file_path)
      @info = file_info_table(file_path)
    end

    def file_info_table(file_path)
      {
        basename: ::File.basename(file_path),
        blocks: @stat.blocks,
        group: Etc.getgrgid(@stat.gid).name,
        mtime: @stat.mtime.strftime('%m %e %R'),
        nlink: @stat.nlink.to_s,
        size: @stat.size.to_s,
        type_and_mode: format_type_and_mode(file_path),
        user: Etc.getpwuid(@stat.uid).name
      }
    end

    private

    def format_type_and_mode(file_path)
      pathname = Pathname(file_path)
      type = pathname.directory? ? 'd' : '-'
      mode = format_mode(pathname.stat.mode)
      "#{type}#{mode}"
    end

    def format_mode(mode)
      digits = mode.to_s(8)[-3..-1]
      digits.each_char.map do |c|
        MODE_TABLE[c]
      end.join
    end
  end
end
