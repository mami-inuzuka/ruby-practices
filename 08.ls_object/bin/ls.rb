#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/command'

puts LS::Command.new.execute
