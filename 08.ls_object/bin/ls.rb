#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/command'

puts LS::Command.new.execute
