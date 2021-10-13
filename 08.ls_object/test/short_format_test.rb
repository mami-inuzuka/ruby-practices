# frozen_string_literal: true

require 'minitest/autorun'
require './lib/short_formatter'

class ShortFormatTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app'

  def test_run_ls_width_150
    expected = <<~TEXT.chomp
      01.fizzbuzz             03.rake                 05.ls                   07.bowling_object       09.wc_object
      02.calendar             04.bowling              06.wc                   08.ls_object            README.md
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 150).list
  end

  def test_run_ls_width_100
    expected = <<~TEXT.chomp
      01.fizzbuzz             04.bowling              07.bowling_object       README.md
      02.calendar             05.ls                   08.ls_object
      03.rake                 06.wc                   09.wc_object
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 100).list
  end

  def test_run_ls_width_80
    expected = <<~TEXT.chomp
      01.fizzbuzz             05.ls                   09.wc_object
      02.calendar             06.wc                   README.md
      03.rake                 07.bowling_object
      04.bowling              08.ls_object
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 80).list
  end

  def test_run_ls_width_50
    expected = <<~TEXT.chomp
      01.fizzbuzz             06.wc
      02.calendar             07.bowling_object
      03.rake                 08.ls_object
      04.bowling              09.wc_object
      05.ls                   README.md
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 50).list
  end

  def test_run_ls_width_40
    expected = <<~TEXT.chomp
      01.fizzbuzz
      02.calendar
      03.rake
      04.bowling
      05.ls
      06.wc
      07.bowling_object
      08.ls_object
      09.wc_object
      README.md
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 40).list
  end

  def test_run_ls_width_1
    expected = <<~TEXT.chomp
      01.fizzbuzz
      02.calendar
      03.rake
      04.bowling
      05.ls
      06.wc
      07.bowling_object
      08.ls_object
      09.wc_object
      README.md
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 1).list
  end

  def test_run_ls_reverse
    expected = <<~TEXT.chomp
      README.md               08.ls_object            06.wc                   04.bowling              02.calendar
      09.wc_object            07.bowling_object       05.ls                   03.rake                 01.fizzbuzz
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 150, reverse: true).list
  end

  def test_run_ls_dot_match
    expected = <<~TEXT.chomp
      .                       01.fizzbuzz             03.rake                 05.ls                   07.bowling_object       09.wc_object
      ..                      02.calendar             04.bowling              06.wc                   08.ls_object            README.md
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 150, dot_match: true).list
  end

  def test_run_ls_reverse_and_dot_match
    expected = <<~TEXT.chomp
      README.md               08.ls_object            06.wc                   04.bowling              02.calendar             ..
      09.wc_object            07.bowling_object       05.ls                   03.rake                 01.fizzbuzz             .
    TEXT
    assert_equal expected, LS::ShortFormatter.new(pathname: TARGET_PATHNAME, width: 150, dot_match: true, reverse: true).list
  end
end
