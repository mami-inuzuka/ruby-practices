require 'etc'

module LS
  # ファイルについての情報を持っているクラス
  class File
    attr_reader :max_sizes, :file_path, :basename, :type_and_mode, :nlink, :user, :group, :size, :mtime, :blocks

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
      stat = ::File::Stat.new(file_path)
      @file_path = file_path
      @basename = ::File.basename(file_path)
      @type_and_mode = format_type_and_mode(file_path)
      @nlink = stat.nlink
      @user = Etc.getpwuid(stat.uid).name
      @group = Etc.getgrgid(stat.gid).name
      @size = stat.size
      @mtime = stat.mtime.strftime('%m %e %R')
      @blocks = stat.blocks
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
