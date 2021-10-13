# frozen_string_literal: true

require './lib/short_format'
require './lib/long_format'
require './lib/command'

module LS
  class Ls
    def initialize(argv)
      command = LS::Command.new(ARGV)
      @pathname = command.pathname
      @params = command.params
      @width = command.window_width
    end

    def execute
      @params[:long_format] ? LS::LongFormat.new(@pathname, @params[:reverse], @params[:dot_match]).list : LS::ShortFormat.new(@pathname, @width,  @params[:reverse], @params[:dot_match]).list
    end
  end
end

