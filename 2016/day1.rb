#!/usr/bin/ruby
class Move
  def initialize(d, s)
    @dir = d
    @steps = s
  end

  def dir
    @dir
  end
  def steps
    @steps
  end
end

def toMove(string)
  str = string.strip
  Move.new(str[0], Integer(str[1..-1]))
end

@dirs = ['N', 'E', 'S', 'W']

def reducer(p, m)
  if m.dir == 'R'
    dir = @dirs[(@dirs.index(p[2]) + 1) % 4]
  else
    dir = @dirs[(@dirs.index(p[2]) + 3) % 4]
  end
  steps = m.steps
  if dir == 'S' || dir == 'W'
    steps = -steps
  end
  if dir == 'E' || dir == 'W'
    [p[0] + steps, p[1], dir]
  else
    [p[0], p[1] + steps, dir]
  end
end

moveStrings = $stdin.gets.split(',')
moves = moveStrings.collect { |m| toMove m}
finalPosition = moves.inject([0,0,'N']) {|p, m| reducer p, m}

puts "Final position: " + finalPosition.join(",")
puts "Steps from start: " + (finalPosition[0].abs + finalPosition[1].abs).to_s
