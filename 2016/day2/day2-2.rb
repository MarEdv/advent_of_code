#!/usr/bin/ruby

@keypad = {1 => {'D' => 3},
           2 => {'D' => 6, 'R' => 3},
           3 => {'D' => 7, 'L' => 2, 'U' => 1, 'R' => 4},
           4 => {'D' => 8, 'L' => 3},
           5 => {'R' => 6},
           6 => {'D' => 'A', 'L' => 5, 'U' => 2, 'R' => 7},
           7 => {'D' => 'B', 'L' => 6, 'U' => 3, 'R' => 8},
           8 => {'D' => 'C', 'L' => 7, 'U' => 4, 'R' => 9},
           9 => {'L' => 8},
           'A' => {'U' => 6, 'R' => 'B'},
           'B' => {'D' => 'D', 'L' => 'A', 'U' => 7, 'R' => 'C'},
           'C' => {'L' => 'B', 'U' => 8},
           'D' => {'U' => 'B'}
          }

def readLines(stream)
  result = []
  line = stream.gets
  while (line != nil)
    result = result + [line.chomp]
    line = stream.gets
  end
  result
end

lines = readLines($stdin)

# start reduction with an array of [<current key>, <list of pressed keys>]
result = lines.inject([5, []]) do |a, line|
  n = line.split("").inject(a[0]) do |acc, elem|
    @keypad[acc].fetch(elem, acc) # fetches value for key 'elem' or defaults to 'acc'
  end
  [n, a[1] + [n]]
end

puts result[1]
