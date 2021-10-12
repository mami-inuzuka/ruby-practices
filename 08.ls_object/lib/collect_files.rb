# frozen_string_literal: true

require 'pathname'
require './lib/file'

module LS
  # ファイルを集めてくるクラス
  class CollectFiles
    attr_reader :files, :file_paths, :collect_file_paths, :max_file_path_count, :max_nlink_size, :max_user_size, :max_group_size, :max_size_size, :total_blocks

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
      params = dot_match ? [pattern, ::File::FNM_DOTMATCH] : [pattern]
      file_paths = Dir.glob(*params).sort
      reverse ? file_paths.reverse : file_paths
    end

    def max_nlink_size
      @files.map { |file| file.nlink.to_s.size }.max
    end

    def max_user_size
      @files.map { |file| file.user.to_s.size }.max
    end

    def max_group_size
      @files.map { |file| file.group.to_s.size }.max
    end

    def max_size_size
      @files.map { |file| file.size.to_s.size }.max
    end

    def total_blocks
      @files.map { |file| file.blocks }.sum
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
