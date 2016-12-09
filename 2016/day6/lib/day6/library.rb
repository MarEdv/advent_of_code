# 
def linesToOccurencesMap(lines)
  lines.map { |line| line.chomp.split("") }
    .transpose
    .map { |line|
      line.group_by { |x| x }
        .to_a
        .map { |x| [x[0], x[1].size] }
  }
end

#
def decodeMessage(lines, sortOrder)
  occurrencesMap = linesToOccurencesMap(lines)
  stringFrom(occurrencesMap, sortOrder)
end

def stringFrom(occurrencesMap, sortOrder)
  occurrencesMap.map {|keyValue| keyValue.sort_by do |x| # sort by value in keyValue
            if sortOrder == "ASC"
              [x[1]]
            else
              [-x[1]]
            end
          end
    }
    .map {|keyValue| keyValue[0][0]} # key of the first tuple, i.e., the one sorted first according to the sort order
    .join("")
end
