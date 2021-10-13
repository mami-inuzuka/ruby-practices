#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/ls'

puts LS::Ls.new(ARGV).execute
