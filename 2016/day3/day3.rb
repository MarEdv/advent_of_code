def readLines(stream)
  result = []
  line = stream.gets
  while (line != nil)
    result = result + [line.chomp]
    line = stream.gets
  end
  result
end

def isValid(points)
  points[0].to_i + points[1].to_i > points[2].to_i &&
  points[1].to_i + points[2].to_i > points[0].to_i &&
  points[0].to_i + points[2].to_i > points[1].to_i
end

