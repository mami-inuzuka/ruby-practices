# frozen_string_literal: true

require 'io/console'
require 'optparse'
require './lib/long_format'
require './lib/short_format'

module LS
  class Command
    attr_reader :params

    def initialize(argv)
      @params = set_params
    end

    def execute
      if @params[:long_format]
        LS::LongFormat.new(pathname: pathname, reverse: @params[:reverse], dot_match: @params[:dot_match]).list
      else
        LS::ShortFormat.new(pathname: pathname, width: window_width,  reverse: @params[:reverse], dot_match: @params[:dot_match]).list
      end
    end

    private

    def pathname
      ARGV[0] || '.'
    end

    def window_width
      IO.console.winsize[1]
    end

    def set_params
      params = { long_format: false, reverse: false, dot_match: false }
      opt = OptionParser.new
      opt.on('-a') { |v| params[:dot_match] = v }
      opt.on('-l') { |v| params[:long_format] = v }
      opt.on('-r') { |v| params[:reverse] = v }
      opt.parse!(ARGV)
      params
    end
  end
end
