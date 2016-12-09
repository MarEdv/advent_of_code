require 'spec_helper'

describe Day6 do
  occurrencesMap = [
    {"a"=>3, "b"=>2, "c"=>1, "d"=>2},
    {"a"=>2, "b"=>3, "c"=>2, "d"=>1},
    {"a"=>2, "b"=>1, "c"=>3, "d"=>2},
    {"a"=>1, "b"=>2, "c"=>2, "d"=>3}
  ]

  it "linesToOccurencesMap" do
    lines = ["aaaa", "bbbb", "cccc", "dddd", "abcd"]
    reducedLines = linesToOccurencesMap(lines)
    expected = [
      {"a"=>2, "b"=>1, "c"=>1, "d"=>1},
      {"a"=>1, "b"=>2, "c"=>1, "d"=>1},
      {"a"=>1, "b"=>1, "c"=>2, "d"=>1},
      {"a"=>1, "b"=>1, "c"=>1, "d"=>2}
    ]
    expect(reducedLines).to eq expected.map { |x| x.to_a }
  end
  it "stringFrom_DESC" do
    expect(stringFrom(occurrencesMap, "DESC")).to eq "abcd"
  end
  it "stringFrom_ASC" do
    expect(stringFrom(occurrencesMap, "ASC")).to eq "cdba"
  end
end
