#!/usr/bin/ruby

# --- Part Two ---
#
# Now that you've helpfully marked up their design documents, it occurs to you that triangles are specified in groups of three vertically. Each set of three numbers in a column specifies a triangle. Rows are unrelated.
#
# For example, given the following specification, numbers with the same hundreds digit would be part of the same triangle:
#
# 101 301 501
# 102 302 502
# 103 303 503
# 201 401 601
# 202 402 602
# 203 403 603
# In your puzzle input, and instead reading by columns, how many of the listed triangles are possible?
#
# To execute: cat day3.txt | ./day3-2.rb

require './day3'

lines = readLines($stdin)

points = lines.collect {|line| line.split(" ")}

# Lets zip the list of points on itself, once with one element shift, and once with a two element shift and
# last with an index.
# Each three rows now contains a valid combination of points, thus we filter out every third set of points.
# This is when we are ready to group the points vertically and filter out all valid groups of points.
validPoints = points.zip(points.drop(1), points.drop(2), 0..lines.size)
          .select do |p|
            p[3] % 3 == 0
          end
          .collect do |p|
            [[p[0][0],p[1][0],p[2][0]],
             [p[0][1],p[1][1],p[2][1]],
             [p[0][2],p[1][2],p[2][2]]]
            .select { |p| isValid(p) }
          end
          .flatten(1)

puts validPoints.size
