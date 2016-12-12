
def parseRect(string)
  m = string.match('rect (\d+)x(\d+)')
  [m[1].to_i, m[2].to_i]
end

def parseColumn(string)
  match = string.match('rotate column x=(\d+) by (\d+)')
  [match[1].to_i, match[2].to_i]
end

def parseRow(string)
  match = string.match('rotate row y=(\d+) by (\d+)')
  [match[1].to_i, match[2].to_i]
end

def createDisplay(x, y)
  (1..y).map { |z| Array.new(x, ".")}
end

def putRect(display, x, y)
  (0...y).each { |a| (0...x).each { |b| display[a][b] = "#" } }
  display
end

def rotateColumn(display, x, y)
  a = display.transpose
  a = rotateRow(a, x, y)
  a.transpose
end

def rotateRow(display, x, y)
  sz = display[x].length - y
  display[x] = display[x].drop(sz) + display[x].take(sz)
  display
end

def processLines(lines, display)
  lines.reduce(display) { |acc, l|
    line = l.chomp
    if line.start_with? ("rect") then
      a = parseRect(line)
      putRect(acc, a[0], a[1])
    elsif line.start_with? ("rotate row") then
      a = parseRow(line)
      rotateRow(acc, a[0], a[1])
    elsif line.start_with? ("rotate column") then
      a = parseColumn(line)
      rotateColumn(acc, a[0], a[1])
    end
  }
end