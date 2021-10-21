# frozen_string_literal: true

require 'minitest/autorun'
require 'pathname'
require_relative '../lib/file_collector'

class LsFileCollectorTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app'

  def setup
    @collected_files = LS::FileCollector.new(pathname: TARGET_PATHNAME)
    @hash = @collected_files.max_length_list
  end

  def test_max_basename_size
    assert_equal 17, @hash[:basename]
  end

  def test_max_group_size
    assert_equal 5, @hash[:group]
  end

  def test_max_nlink_size
    assert_equal 2, @hash[:nlink]
  end

  def test_max_size_size
    assert_equal 4, @hash[:size]
  end

  def test_max_user_size
    assert_equal 12, @hash[:user]
  end

  def test_total_blocks
    assert_equal 8, @collected_files.total_blocks
  end
end
