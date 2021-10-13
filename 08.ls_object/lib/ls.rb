# frozen_string_literal: true

require './lib/command'
require './lib/long_format'
require './lib/short_format'

module LS
  class Ls
    def initialize(argv)
      command = LS::Command.new(ARGV)
      @pathname = command.pathname
      @params = command.params
      @width = command.window_width
    end

    def execute
      @params[:long_format] ? LS::LongFormat.new(pathname: @pathname, reverse: @params[:reverse], dot_match: @params[:dot_match]).list : LS::ShortFormat.new(pathname: @pathname, width: @width,  reverse: @params[:reverse], dot_match: @params[:dot_match]).list
    end
  end
end

