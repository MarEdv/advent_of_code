
def decompress(line, decompressMarkerFunc)
  result = ""
  i = 0
  while (i < line.size) do
    if line[i] == "("
      marker = getMarker(line, i)
      m = marker.match('(\d+)x(\d+)')
      length = m[1].to_i
      nr = m[2].to_i
      result += decompressMarkerFunc.call(line, marker, i, length, nr)
      i += marker.length + length
    else
      result += line[i]
      i += 1
    end
  end
  result
end

def decompressMarkerV1
  -> (line, marker, i, l, n) {
    string = line.slice(i+marker.length, l)
    ([string] * n).join("")
  }
end

def decompressMarkerV2
  ->(line, marker, i, l, n) {
    string = line.slice(i+marker.length, l)
    string = decompress(string, decompressMarkerV2)
    ([string] * n).join("")
  }
end

def getMarker(line, i)
  line.slice(i, line.index(")", i)-i+1)
end