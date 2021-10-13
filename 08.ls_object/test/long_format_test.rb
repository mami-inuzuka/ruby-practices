# frozen_string_literal: true

require 'minitest/autorun'
require './lib/long_format'

class LsCommandTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app'

  def test_run_ls_long_format
    # Output example
    # total 8
    # drwxrwxr-x   4 mami-inuzuka  staff   128 10 11 17:35 01.fizzbuzz
    # drwxrwxr-x   4 mami-inuzuka  staff   128 10 11 17:35 02.calendar
    # drwxrwxr-x   3 mami-inuzuka  staff    96 10 11 17:35 03.rake
    # drwxrwxr-x   4 mami-inuzuka  staff   128 10 11 17:35 04.bowling
    # drwxrwxr-x   4 mami-inuzuka  staff   128 10 11 17:35 05.ls
    # drwxrwxr-x   4 mami-inuzuka  staff   128 10 11 17:35 06.wc
    # drwxrwxr-x  10 mami-inuzuka  staff   320 10 11 17:35 07.bowling_object
    # drwxrwxr-x   3 mami-inuzuka  staff    96 10 11 17:35 08.ls_object
    # drwxrwxr-x   3 mami-inuzuka  staff    96 10 11 17:35 09.wc_object
    # -rw-rw-r--   1 mami-inuzuka  staff  2336 10 11 17:35 README.md
    expected = `ls -l #{TARGET_PATHNAME}`.chomp
    assert_equal expected, LS::LongFormat.new(pathname: TARGET_PATHNAME).list
  end

  def test_run_ls_long_format_reverse
    expected = `ls -lr #{TARGET_PATHNAME}`.chomp
    assert_equal expected, LS::LongFormat.new(pathname: TARGET_PATHNAME, reverse: true).list
  end

  def test_run_ls_long_format_dot_match
    expected = `ls -la #{TARGET_PATHNAME}`.chomp
    assert_equal expected, LS::LongFormat.new(pathname: TARGET_PATHNAME, dot_match: true).list
  end

  def test_run_ls_long_format_all
    expected = `ls -lar #{TARGET_PATHNAME}`.chomp
    assert_equal expected, LS::LongFormat.new(pathname: TARGET_PATHNAME, reverse: true, dot_match: true).list
  end
end
