#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/ls_command'

puts LS::Ls.new(ARGV).run_ls
