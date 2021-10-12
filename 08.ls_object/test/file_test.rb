# frozen_string_literal: true

require 'minitest/autorun'
require 'pathname'
require './lib/file'

class LsFileTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app/Gemfile'
  # => <Pathname:test/fixtures/sample-app/Gemfile>
  def test_file_path
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal "test/fixtures/sample-app/Gemfile", ls.file_path
  end

  def test_basename
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal "Gemfile", ls.basename
  end

  def test_type_and_mode
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal "-rw-rw-r--", ls.type_and_mode
  end

  def test_nlink
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal 1, ls.nlink
  end

  def test_user
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal "mami-inuzuka", ls.user
  end

  def test_group
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal "staff", ls.group
  end

  def test_size
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal 2049, ls.size
  end

  def test_mtime
    ls = LS::File.new(TARGET_PATHNAME)
    assert_equal "10  8 14:52", ls.mtime
  end
end
