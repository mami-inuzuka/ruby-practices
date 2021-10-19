# frozen_string_literal: true

require 'io/console'
require 'optparse'
require_relative 'long_formatter'
require_relative 'short_formatter'

module LS
  #
  # オプションやパスを受け取りLSコマンドを実行するクラス
  #
  class Command
    attr_reader :params

    def initialize
      @params = set_params
    end

    def execute
      if @params[:long_format]
        LS::LongFormatter.new(pathname: pathname, reverse: @params[:reverse], dot_match: @params[:dot_match]).list
      else
        LS::ShortFormatter.new(pathname: pathname, width: window_width, reverse: @params[:reverse],
                               dot_match: @params[:dot_match]).list
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
