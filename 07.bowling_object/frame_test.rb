# frozen_string_literal: true
# rubocop:disable all

require 'minitest/autorun'
require_relative 'frame'

class FrameTest < Minitest::Unit::TestCase
  def test_3と2が入ったフレームの合計スコアは5
    frame = Frame.new('3', '2')
    refute frame.strike?
    refute frame.spare?
    assert_equal 5, frame.score
  end

  def test_Xが渡されたらストライク
    frame = Frame.new('X')
    assert frame.strike?
    refute frame.spare?
  end

  def test_2投していてフレームの合計が10だったらスペア
    frame = Frame.new('5', '5')
    assert frame.spare?
    refute frame.strike?
  end
end
