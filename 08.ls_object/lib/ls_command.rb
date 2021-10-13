# frozen_string_literal: true

require 'pathname'
require './lib/short_format'
require './lib/long_format'
require './lib/file'
require './lib/command'

module LS
  class Ls
    def initialize(argv)
      command = Command.new(ARGV)
      @pathname = command.pathname # "test/fixtures/sample-app"
      @width = command.window_width
      @params = command.options
    end

    def run_ls
      @params[:long_format] ? LS::LongFormat.new(@pathname, @params[:reverse], @params[:dot_match]).list : LS::ShortFormat.new(@pathname, @width,  @params[:reverse], @params[:dot_match]).list
    end
  end
end

