# frozen_string_literal: true

require './lib/file_collector'

module LS
  class ShortFormatter
    MARGIN_BETWEEN_FILE_NAME = 7

    def initialize(pathname:, width:, reverse: false, dot_match: false)
      @collected_files = LS::FileCollector.new(pathname: pathname, reverse: reverse, dot_match: dot_match)
      @width = width
    end

    def list
      format_table(transposed_file_paths, max_file_path_count)
    end

    private

    def format_table(file_paths, max_file_path_count)
      file_paths.map do |row_files|
        render_short_format_row(row_files, max_file_path_count)
      end.join("\n")
    end

    def max_file_path_count
      @collected_files.max_length_list[:basename]
    end

    def render_short_format_row(row_files, max_file_path_count)
      row_files.map do |file_path|
        basename = file_path ? ::File.basename(file_path) : ''
        basename.ljust(max_file_path_count + MARGIN_BETWEEN_FILE_NAME)
      end.join.rstrip
    end

    def safe_transpose(nested_file_name)
      nested_file_name[0].zip(*nested_file_name[1..-1])
    end

    def transposed_file_paths
      file_paths = @collected_files.paths
      col_count = @width / (max_file_path_count + MARGIN_BETWEEN_FILE_NAME)
      row_count = col_count.zero? ? file_paths.count : (file_paths.count.to_f / col_count).ceil
      safe_transpose(file_paths.each_slice(row_count).to_a)
    end
  end
end
