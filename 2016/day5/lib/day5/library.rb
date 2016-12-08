class String
  def numeric?
    Float(self) != nil rescue false
  end
end

# Creates an infinite stream of hashes from roomId concatenated with counter
# where the next hash is roomId concatenated with counter + 1
def lazy_room_digester(roomId, counter)
  hexdigest = Digest::MD5.new.update(roomId + counter.to_s).hexdigest
  lazy_stream(hexdigest) { lazy_room_digester(roomId, counter + 1) }
end

# Finds the list of hexadecimal hashes that start with "00000"
def find_password(string, count, add_function, initial_collection, initial_counter = 0)
  digester = lazy_room_digester(string, initial_counter)
  result = initial_collection
  while result.size < count
    digest = digester.first
    if digest.slice(0,5) == "00000"
      result = add_function.call(result, digest)
    end
    digester = digester.rest
  end
  result
end

# Returns a lambda function that adds the digest to an array.
def part1AccumulatorFunction()
  ->(acc,digest) { acc + [digest] }
end

# Returns a lambda function that maybe stores a value to an index from a digest string.
# Position 5 in the digest is the index and position 6 is the value.
# Do not overwrite an existing value for an index.
def part2AccumulatorFunction(max_index)
  ->(acc,digest) {
    idx = digest.slice(5)
    if (idx.numeric? && idx.to_i < max_index.to_i)
      if acc[idx] == nil
        acc[idx] = digest.slice(6)
      end
    end
    acc
  }
end
