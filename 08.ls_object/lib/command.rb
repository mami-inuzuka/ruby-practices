# frozen_string_literal: true

require 'io/console'
require 'optparse'

module LS
  class Command
    attr_reader :params, :pathname, :window_width

    def initialize(argv)
      @params = self.options
    end

    def pathname
      ARGV[0] || '.'
    end

    def window_width
      IO.console.winsize[1]
    end

    private

    def options
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
