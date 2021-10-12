# frozen_string_literal: true

require 'pathname'
require './lib/short_format'
require './lib/long_format'
require './lib/file'

module LS
  class Ls
    def initialize(pathname, width: 123, long_format: false, reverse: false, dot_match: false)
      @pathname = pathname # "test/fixtures/sample-app"
      @width = width
      @params = { long_format: long_format, reverse: reverse, dot_match: dot_match }
    end

    def run_ls
      @params[:long_format] ? LS::LongFormat.new(@pathname).get_info : LS::ShortFormat.new(@pathname, @width).get_basename
    end
  end
end

