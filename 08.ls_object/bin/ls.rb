#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/ls'

puts LS::Command.new(ARGV).execute
