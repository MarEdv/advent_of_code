# split the IPs into a list where words
# - outside brackets have odd indices
# - inside barckets have even indices
def splitIP(string)
  string.split("[")
    .map { |word| word.split("]") }
    .flatten
end

# identifies all ABBAs in each word in the list of a split IP
def toABBAs(list)
  list.map { |x|
    l = x.split("")
    l.zip(l.drop(1), l.drop(2), l.drop(3))
      .select { |tuple| tuple[0] == tuple[3] && tuple[1] == tuple[2] && tuple[0] != tuple[1] }
      .map { |array| array.join("") }
  }
end

# identifies all ABAs in each word in the list of a split IP
def toABAs(list)
  list.map { |x|
    l = x.split("")
    l.zip(l.drop(1), l.drop(2))
      .select { |tuple| tuple[0] == tuple[2] && tuple[0] != tuple[1] }
      .map { |array| array.join("") }
  }
end

# checks so that all words outside brackets are found inside brackets
def isValidTLS(abbas)
  abbas.zip((1..abbas.length))
    .select { |x| x[1].to_i.odd? } # outside brackets
    .any? { |x| x[0].size > 0 } &&
    abbas.zip((1..abbas.length))
      .select { |x| x[1].to_i.even? } # inside brackets
      .all? { |x| x[0].size == 0 }
end

# checks if an IP supports SSL
def isValidSSL(abas)
  list = abas.zip((1..abas.length))
    .select { |x| x[1].odd? }
    .select { |x| x[0].size > 0 }
    .map { |x| x[0] }
  existsBABInList(list, abas)
end

# for each list of ABAs outside brackets there should at
# least be one corresponding BAB inside brackets
def existsBABInList(outsideList, abas)
  outsideList.flatten.any? { |x|
    s = x.split("")
    bab = [s[1], s[0], s[1]].join("")
    existsBAB(abas, bab)
  }
end

# locates a bab in the list of abas inside brackets
def existsBAB(abas, bab)
  abas.zip((1..abas.length))
    .select { |x| x[1].even? } # inside brackets
    .any? { |x| x[0].index(bab) != nil}
end
