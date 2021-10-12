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

    def initialize(file_paths)
      @file_paths = file_paths
    end

    def get_info
      row_data = @file_paths.map do |file_path|
        stat = File::Stat.new(file_path)
        build_data(file_path, stat)
      end
      block_total = row_data.sum { |data| data[:blocks] }
      total = "total #{block_total}"
      body = render_long_format_body(row_data)
      [total, *body].join("\n")
    end

    private

    def build_data(file_path, stat)
      {
        type_and_mode: format_type_and_mode(file_path),
        nlink: stat.nlink.to_s,
        user: Etc.getpwuid(stat.uid).name,
        group: Etc.getgrgid(stat.gid).name,
        size: stat.size.to_s,
        mtime: stat.mtime.strftime('%m %e %R'),
        basename: File.basename(file_path),
        blocks: stat.blocks
      }
    end

    def render_long_format_body(row_data)
      max_sizes = %i[nlink user group size].map do |key|
        find_max_size(row_data, key)
      end
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
