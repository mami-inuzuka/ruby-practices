# frozen_string_literal: true

require 'etc'
require 'minitest/autorun'
require 'pathname'
require_relative '../lib/file'

class LsFileTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app/README.md'

  def setup
    @file_info = LS::File.new(TARGET_PATHNAME).info
    @stat = ::File::Stat.new(TARGET_PATHNAME)
  end

  def test_basename
    assert_equal "README.md", @file_info[:basename]
  end

  def test_group
    assert_equal "staff", @file_info[:group]
  end

  def test_mtime
    pattern = /^\d{1,2} \d{1,2} [0-9]{2}:[0-9]{2}$/
    assert_match pattern, @file_info[:mtime]
  end

  def test_nlink
    assert_equal "1", @file_info[:nlink]
  end

  def test_size
    assert_equal "2336", @file_info[:size]
  end

  def test_type_and_mode
    assert_equal "-rw-r--r--", @file_info[:type_and_mode]
  end

  def test_user
    assert_equal "mami-inuzuka", @file_info[:user]
  end
end
