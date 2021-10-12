module LS
  class ShortFormat
    def initialize(file_path, width)
      @file_paths = file_path
      @width = width
    end

    def get_basename
      max_file_path_count = @file_paths.map { |f| File.basename(f).size }.max
      col_count = @width / (max_file_path_count + 7)
      row_count = col_count.zero? ? @file_paths.count : (@file_paths.count.to_f / col_count).ceil
      transposed_file_paths = safe_transpose(@file_paths.each_slice(row_count).to_a)
      format_table(transposed_file_paths, max_file_path_count)
    end

    def safe_transpose(nested_file_name)
      nested_file_name[0].zip(*nested_file_name[1..-1])
    end

    def format_table(file_paths, max_file_path_count)
      file_paths.map do |row_files|
        render_short_format_row(row_files, max_file_path_count)
      end.join("\n")
    end

    def render_short_format_row(row_files, max_file_path_count)
      row_files.map do |file_path|
        basename = file_path ? File.basename(file_path) : ''
        basename.ljust(max_file_path_count + 7)
      end.join.rstrip
    end
  end
end
