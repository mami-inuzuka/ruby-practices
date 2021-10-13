# frozen_string_literal: true

require 'minitest/autorun'
require 'pathname'
require './lib/file'

class LsFileTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app/README.md'

  def setup
    @file = LS::File.new(TARGET_PATHNAME)
  end

  def test_file_path
    assert_equal "test/fixtures/sample-app/README.md", @file.file_path
  end

  def test_basename
    assert_equal "README.md", @file.basename
  end

  def test_type_and_mode
    assert_equal "-rw-rw-r--", @file.type_and_mode
  end

  def test_nlink
    assert_equal 1, @file.nlink
  end

  def test_user
    assert_equal "mami-inuzuka", @file.user
  end

  def test_group
    assert_equal "staff", @file.group
  end

  def test_size
    assert_equal 2336, @file.size
  end

  def test_mtime
    assert_equal "10 11 17:35", @file.mtime
  end
end
