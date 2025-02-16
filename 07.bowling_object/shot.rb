# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def to_num
    @mark == 'X' ? 10 : @mark.to_i
  end
end
