# frozen_string_literal: true

require 'minitest/autorun'
require './lib/ls'
require 'pathname'

class LsCommandTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app'
  def test_run_ls_long_format
    # Output example
    # total 816
    # -rw-rw-r--  1 mami-inuzuka  staff    2049 10  8 14:52 Gemfile
    # -rw-rw-r--  1 mami-inuzuka  staff   13714 10  8 14:52 Gemfile.lock
    # -rw-rw-r--  1 mami-inuzuka  staff     111 10  8 14:52 Procfile
    # -rw-rw-r--  1 mami-inuzuka  staff    2201 10  8 14:52 README.md
    # -rwxr-xr-x  1 mami-inuzuka  staff     300 10  8 14:52 Rakefile
    # drwxrwxr-x 12 mami-inuzuka  staff     384 10  8 14:52 app
    # -rw-rw-r--  1 mami-inuzuka  staff     559 10  8 14:52 app.json
    # -rw-rw-r--  1 mami-inuzuka  staff    1722 10  8 14:52 babel.config.js
    # drwxrwxr-x 14 mami-inuzuka  staff     448 10  8 14:52 bin
    # drwxrwxr-x 19 mami-inuzuka  staff     608 10  8 14:52 config
    # -rw-rw-r--  1 mami-inuzuka  staff     160 10  8 14:52 config.ru
    # drwxrwxr-x  8 mami-inuzuka  staff     256 10  8 14:52 db
    # drwxrwxr-x  6 mami-inuzuka  staff     192 10  8 14:52 lib
    # drwxrwxr-x  3 mami-inuzuka  staff      96 10  8 14:52 log
    # -rw-rw-r--  1 mami-inuzuka  staff    1651 10  8 14:52 package.json
    # -rw-rw-r--  1 mami-inuzuka  staff     224 10  8 14:52 postcss.config.js
    # drwxrwxr-x 25 mami-inuzuka  staff     800 10  8 14:52 public
    # drwxrwxr-x 13 mami-inuzuka  staff     416 10  8 14:52 test
    # drwxrwxr-x  4 mami-inuzuka  staff     128 10  8 14:52 vendor
    # -rw-rw-r--  1 mami-inuzuka  staff  364177 10  8 14:52 yarn.lock
    expected = `ls -l #{TARGET_PATHNAME}`.chomp
    assert_equal expected, LS::LongFormat.new(pathname: TARGET_PATHNAME).list
  end
end
