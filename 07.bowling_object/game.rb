require './frame'

class Game
  def initialize(argv)
    @frames = Frame.new(argv).frames
  end

  def calculate_score
    point = 0
    (0..9).each do |n|
      frame, next_frame, after_next_frame = @frames.slice(n, 3)
      next_frame ||= []
      after_next_frame ||= []
      left_shots = next_frame + after_next_frame

      if frame[0] == 10 # strike
        point += frame.sum + left_shots.slice(0, 2).sum
      elsif frame.sum == 10 # spare
        point += frame.sum + left_shots.fetch(0)
      else
        point += frame.sum
      end
    end
    point
  end
end

game = Game.new(ARGV[0])
puts game.calculate_score
