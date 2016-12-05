#!/usr/bin/ruby
# The algorithm uses a zero indexed, two-dimentional array
# for abstraction of the keypad. The index of the cell is used
# when traversing the instructions.
#
# keypad = [[1,2,3],
#           [4,5,6],
#           [7,8,9]]
#
# indexes = [[0,1,2],
#            [3,4,5],
#            [6,7,8]]

@nr = 5-1
line = $stdin.gets
while (line != nil)
  @nr = line.chomp.split("").inject(@nr) do |acc, elem|
    x = acc % 3
    y = acc / 3
    case elem
    when "U"
      y = [y-1,0].max
    when "D"
      y = [y+1,2].min
    when "L"
      x = [x-1,0].max
    when "R"
      x = [x+1,2].min
    end
    y * 3 + x
  end
  puts (@nr+1).to_s
  line = $stdin.gets
end
