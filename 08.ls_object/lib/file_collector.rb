# frozen_string_literal: true

require 'pathname'
require './lib/file'

module LS
  class FileCollector
    attr_reader :files, :paths, :max_length_list, :total_blocks

    def initialize(pathname:, reverse: false, dot_match: false)
      @files = collect_files(pathname: pathname, dot_match: dot_match, reverse: reverse)
      @paths = collect_file_paths(pathname: pathname, dot_match: dot_match, reverse: reverse)
    end

    def max_length_list
      {
        basename: find_max_size(:basename),
        nlink: find_max_size(:nlink),
        user: find_max_size(:user),
        group: find_max_size(:group),
        size: find_max_size(:size),
      }
    end

    def total_blocks
      @files.map { |file| file.blocks }.sum
    end

    private

    def find_max_size(key)
      @files.map { |file| file.send(key).to_s.size }.max
    end

    def collect_file_paths(pathname:, dot_match: flase, reverse: false)
      pattern = Pathname(pathname).join('*')
      params = dot_match ? [pattern, ::File::FNM_DOTMATCH] : [pattern]
      file_paths = Dir.glob(*params).sort
      reverse ? file_paths.reverse : file_paths
    end

    def collect_files(pathname:, dot_match: false, reverse: false)
      file_paths = collect_file_paths(pathname: pathname, dot_match: dot_match, reverse: reverse)
      file_paths.map do |file_path|
        LS::File.new(file_path)
      end
    end
  end
end
