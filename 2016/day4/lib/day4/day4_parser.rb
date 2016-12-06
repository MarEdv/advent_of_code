
def groupParts(parts)
  parts.reverse.drop(1).reverse.collect do |x|
    x.split("")
  end
  .flatten
  .group_by do |x|
    x
  end
end

# The group is a mapping from a character to a list. This is sorted by array size descending
# and then alfabetically on the character. Only the character is returned.
def sortIt(group)
  group.sort_by do |x|
    [-x[1].size, x[0]]
  end
  .collect { |x| x[0] }
end

# The id is an array of letters. The five first letters are taken and merged to a string
def toName(id)
  id.take(5).inject("") {|a,x| a + x }
end

def parse(string)
  parts = string.split("-")
  d = parts.last.split("[")
  nr = d[0].to_i
  name = d[1][0..-2]

  group = groupParts(parts)
  id = sortIt(group)

  [toName(id), nr, name, string]
end

ALPHABET_ARRAY = "abcdefghijklmnopqrstuvwxyz".split("")

# shifts a character a number of steps and locates the new character from the alphabet array
def calculateNewId(character, steps)
  newId = (ALPHABET_ARRAY.index(character) + steps) % ALPHABET_ARRAY.length
  ALPHABET_ARRAY[newId]
end

# shift decrypts a word
def decryptWord(word, steps)
  word.split("").collect do |y|
    calculateNewId(y, steps)
  end.join("")
end

# decrypt a string using a shift decrypt algorithm with id as the number of steps to shift
def decrypt(string, steps)
  string.split("-")
    .collect do |x|
      decryptWord(x, steps)
    end
    .join(" ")
end

