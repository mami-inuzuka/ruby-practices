# frozen_string_literal: true

require 'pathname'
require './lib/file'

module LS
  # ファイルを集めてくるクラス
  class CollectFiles
    def initialize(pathname, reverse=false, dot_match=false)
      @pathname = pathname
      @files = build_files(pathname, dot_match, reverse)
    end

    private

    def build_files(pathname, dot_match, reverse)
      file_paths = collect_file_paths(pathname, dot_match, reverse)
      file_paths.map do |file_path|
        LS::File.new(file_path)
      end
    end

    def collect_file_paths(pathname, dot_match, reverse)
      pattern = Pathname(pathname).join('*')
      params = dot_match ? [pattern, File::FNM_DOTMATCH] : [pattern]
      file_paths = Dir.glob(*params).sort
      reverse ? file_paths.reverse : file_paths
    end
  end
end
