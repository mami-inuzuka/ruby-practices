# frozen_string_literal: true

require 'pathname'
require './lib/short_format'

module LS
  class Ls
    def initialize(pathname, width: 123, long_format: false, reverse: false, dot_match: false)
      @pathname = pathname
      @width = width
      @params = { long_format: long_format, reverse: reverse, dot_match: dot_match }
      @file_paths = collect_file_paths(dot_match, pathname, reverse)
    end

    def collect_file_paths(dot_match, pathname, reverse)
      pattern = Pathname(pathname).join('*')
      params = dot_match ? [pattern, File::FNM_DOTMATCH] : [pattern]
      file_paths = Dir.glob(*params).sort
      reverse ? file_paths.reverse : file_paths
    end

    def run_ls
      @params[:long_format] ? LS::LongFormat(@file_paths) : LS::ShortFormat.new(@file_paths, @width).get_basename
    end
  end
end

