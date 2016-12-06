#!/usr/bin/ruby
require 'set'

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

def moveToNextPosition(p, m)
  if m.dir == 'R'
    dir = @dirs[(@dirs.index(p[2]) + 1) % 4]
  else
    dir = @dirs[(@dirs.index(p[2]) + 3) % 4] # adding 3 and modulo 4 => subtracting 1, while avoiding going negative
  end

  steps = m.steps
  if dir == 'S' || dir == 'W'
    steps = -steps
  end

  # E,W => x-axis
  # N,S => y-axis
  if dir == 'E' || dir == 'W'
    [p[0] + steps, p[1], dir]
  else
    [p[0], p[1] + steps, dir]
  end
end

def allPointsBetween(p1, p2)
  minX = [p1[0], p2[0]].min
  maxX = [p1[0], p2[0]].max
  minY = [p1[1], p2[1]].min
  maxY = [p1[1], p2[1]].max
  (minX..maxX).collect { |x| (minY..maxY).collect{ |y| [x,y] } }.flatten(1).to_set
end

# read the input, on format "<direction><steps>(,<direction><steps>)*", where
#   direction = [NESW]
#   steps = int (number of steps)
@moveStrings = $stdin.gets.split(',')

# converts to the Move data structure
@moves = @moveStrings.collect { |m| toMove m}

# traverses the list of moves, starting at (0,0) facing North
# and saving all visited positions, collecting all positions visited at least twice
def findIntersectedPositions(moves)
  moves.inject([[0,0,'N'], [[0,0]].to_set, []]) do |acc, m|
    p = moveToNextPosition acc[0], m
    puts "p = " + p.to_s
    newPosition = [p[0], p[1]]
    visitedPositions = acc[1]
    puts "vp = " + visitedPositions.size.to_s
    crossedPositions = acc[2]
    if (visitedPositions & newPosition).size > 0
      puts "contains: " + newPosition.to_s
      c = crossedPositions + [newPosition]
    else
      c = crossedPositions
    end

    pathPositions = allPointsBetween acc[0], newPosition
    [p, visitedPositions + pathPositions, c]
  end
end

def step1()
  # traverses the list of moves, starting at (0,0) facing North
  finalPosition = @moves.inject([0,0,'N']) {|p, m| moveToNextPosition p, m}

  puts "Step 1"
  puts "Final position: " + finalPosition.join(",")
  puts "Manhattan distance: " + (finalPosition[0].abs + finalPosition[1].abs).to_s
  puts ""
end

def step2()
  intersectedPositions = findIntersectedPositions(@moves)
  crossedPositions = intersectedPositions[2]
  firstCrossedPosition = crossedPositions[0]

  puts "Step 2"
  puts "First crossing: " + firstCrossedPosition[0].to_s + ", " + firstCrossedPosition[1].to_s
  puts "Manhattan distance: " + (firstCrossedPosition[0].abs + firstCrossedPosition[1].abs).to_s
end

#step1()
step2()