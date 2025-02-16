# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

# Xのときは2,その他のときは1としてカウントしたときに合計が18になるところが9フレーム目、20 or 21が最終フレームになる
# 最終フレームはXがあっても0を入れずにそのまま10で置き換える
shots = []
num_count = 0
scores.each do |s|
  if num_count == 18
    shots << (s == 'X' ? 10 : s.to_i)
  elsif s == 'X'
    shots << 10
    shots << 0
    num_count += 2
  else
    shots << s.to_i
    num_count += 1
  end
end

# 1フレームにつき2回投げるので1つの配列に数字が2つずつ入るように分割する
frames = shots.each_slice(2).to_a

# 最終フレームを3投しているときは11フレームできるので11フレームを10フレームに結合し、11フレームは削除する
if frames.size > 10
  frames[-2].concat frames[-1]
  frames.delete_at(-1)
end

point = 0
frames.each_with_index do |frame, index|
  point +=
    if index < 8 && frame[0] == 10 && frames[index + 1][0] == 10 # 2回連続strike
      10 + 10 + frames[index + 2][0]
    elsif frame[0] == 10 && frame != frames[-1] # strike
      10 + frames[index + 1][0..1].sum
    elsif frame.sum == 10 && frame != frames[-1] # spare
      10 + frames[index + 1][0]
    else
      frame.sum
    end
end

puts point
