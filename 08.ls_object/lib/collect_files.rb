# frozen_string_literal: true

require 'pathname'
require './lib/file'

module LS
  # ファイルを集めてくるクラス
  class CollectFiles
    attr_reader :file_paths, :collect_file_paths, :max_file_path_count

    def initialize(pathname, reverse=false, dot_match=false)
      @pathname = pathname
      @files = build_files(pathname, dot_match, reverse)
      @file_paths = collect_file_paths(pathname, dot_match, reverse)
    end

    def max_file_path_count
      @files.map { |file| file.basename.size }.max
    end

    def collect_file_paths(pathname, dot_match, reverse)
      pattern = Pathname(pathname).join('*')
      params = dot_match ? [pattern, File::FNM_DOTMATCH] : [pattern]
      file_paths = Dir.glob(*params).sort
      reverse ? file_paths.reverse : file_paths
    end

    private

    def build_files(pathname, dot_match, reverse)
      file_paths = collect_file_paths(pathname, dot_match, reverse)
      file_paths.map do |file_path|
        LS::File.new(file_path)
      end
    end


  end
end
