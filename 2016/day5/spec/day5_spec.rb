require 'spec_helper'

describe Day5 do

  it "lazy_room_digester" do
    expect(lazy_room_digester('abc', 0).take(2).to_a).to eq(["577571be4de9dcce85a041ba0410f29f", "23734cd52ad4a4fb877d8a1e26e5df5f"])
  end

  it "find_password" do
    passwords = find_password("abc", 1, part1AccumulatorFunction, [], 3231927)
    expect(passwords).to eq ["00000155f8105dff7f56ee10fa9b9abd"]
  end

  it "part2AccumulatorFunction" do
    f = part2AccumulatorFunction(5)
    map = {}
    map = f.call(map, "000001A")
    map = f.call(map, "000003C")
    map = f.call(map, "000002B")
    expect(map).to eq (["1" => "A", "2" => "B", "3" => "C"])[0]
  end
end