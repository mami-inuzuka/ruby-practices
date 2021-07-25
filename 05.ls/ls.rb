# frozen_string_literal: true

require 'etc'
require 'optparse'

def main
  option = ARGV.getopts('alr')
  if option['a'] && option['l'] && option['r']
    ls_l(scope: File::FNM_DOTMATCH, reverse: true)
  elsif option['a'] && option['l']
    ls_l(scope: File::FNM_DOTMATCH)
  elsif option['l'] && option['r']
    ls_l(reverse: true)
  elsif option['a'] && option['r']
    ls(scope: File::FNM_DOTMATCH, reverse: true)
  elsif option['a']
    ls(scope: File::FNM_DOTMATCH)
  elsif option['l']
    ls_l
  elsif option['r']
    ls(reverse: true)
  else
    ls
  end
end

# File.statで受け取ったファイルタイプの表記を変換する
def convert_to_ftype(file)
  {
    'file' => '-',
    'directory' => 'd',
    'link' => 'l',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'socket' => 's',
    'fifo' => 'p'
  }[file.ftype]
end

# File.statで受け取ったファイルモードの表記を変換する
def convert_to_fmode(file, position)
  {
    7 => 'rwx',
    6 => 'rw-',
    5 => 'r-x',
    4 => 'r--',
    3 => '-wx',
    2 => '-w-',
    1 => '--x',
    0 => '---'
  }[file.mode.to_s(8).slice(position).to_i]
end

# 最大幅3列にする場合の1列の要素数を計算する
# 余りが出る場合は商+1が1列の要素数
def count_clumn_item(num)
  quotient, remainder = num.divmod(3)
  remainder.zero? ? quotient : quotient + 1
end

def ls(scope: File::FNM_PATHNAME, reverse: false)
  file_list = []
  adjusted_file_list = []
  max_size = 0

  # 現在のディレクトリのファイルを配列に入れる
  Dir.glob('*', scope).each do |file_item|
    file_list << file_item

    # ファイル名の最大数を取得する
    max_size = file_item.size > max_size ? file_item.size : max_size
  end

  # reverseがtrueかfalseによって並び順を変える
  file_list_sorted = reverse == true ? file_list.sort.reverse : file_list.sort

  # 3列で並べる際の1列の要素数を求める
  slice_num = count_clumn_item(file_list_sorted.size)

  # 1列に入る要素数で配列を区切り、行と列を入れ替える
  file_list_transposed = file_list_sorted.each_slice(slice_num).to_a.map! { |it| it.values_at(0...slice_num) }.transpose

  file_list_transposed.each do |list_line|
    line_item = []

    # ファイル名を最大数の幅に揃える
    list_line.each do |list_line_item|
      line_item << (list_line_item.nil? ? ' '.ljust(max_size) : list_line_item.ljust(max_size))
    end

    # 3列表示にするために並び替えて格納した配列
    adjusted_file_list << line_item
  end

  adjusted_file_list.each do |adjusted_file_list_item|
    puts adjusted_file_list_item.join(' ')
  end
end

def ls_l(scope: File::FNM_PATHNAME, reverse: false)
  file_list = []
  file_blocks = 0
  Dir.glob('*', scope).each do |file_item|
    stat = File.stat(file_item)
    file_type = convert_to_ftype(stat)
    file_mode = convert_to_fmode(stat, -3) + convert_to_fmode(stat, -2) + convert_to_fmode(stat, -1)
    file_type_mode = file_type + file_mode
    hard_link = stat.nlink.to_s.rjust(2)
    owner_name = Etc.getpwuid(stat.uid).name
    group_name = Etc.getgrgid(stat.gid).name
    file_size = stat.size.to_s.rjust(5)
    month = stat.mtime.strftime('%m').rjust(2)
    day = stat.mtime.strftime('%d')
    time = stat.mtime.strftime('%H:%M')
    file_name = file_item
    file_blocks += stat.blocks
    file_list << [file_type_mode, hard_link, owner_name, group_name, file_size, month, day, time, file_name]
  end

  file_list_sorted = reverse == true ? file_list.sort_by { |a| a[-1] }.reverse : file_list.sort_by { |a| a[-1] }

  # 配列の中の配列を,ではなく半角スペースで連結したものを1行ずつ表示する
  puts "total #{file_blocks}"
  puts file_list_sorted.map! { |file_list_sorted_item| file_list_sorted_item.join(' ') }.join("\n")
end

main
