require 'spec_helper'

describe Day9 do
  it "decompress_1" do
    expect(decompress("A(1x5)BC", decompressMarkerV1)).to eq "ABBBBBC"
  end

  it "decompress_2" do
    expect(decompress("(3x3)XYZ", decompressMarkerV1)).to eq "XYZXYZXYZ"
  end

  it "decompress_3" do
    expect(decompress("A(2x2)BCD(2x2)EFG", decompressMarkerV1)).to eq "ABCBCDEFEFG"
  end

  it "decompress_4" do
    expect(decompress("(6x1)(1x3)A", decompressMarkerV1)).to eq "(1x3)A"
  end

  it "decompress_5" do
    expect(decompress("X(8x2)(3x3)ABCY", decompressMarkerV1)).to eq "X(3x3)ABC(3x3)ABCY"
  end

  it "getMarker" do
    expect(getMarker("123(1x2)ABC", 3)).to eq "(1x2)"
  end

  it "decompressMarkerV1" do
    expect(decompressMarkerV1.call("123(1x2)ABC", "(1x2)", 3, 1, 2)).to eq "AA"
  end

  it "decompressMarkerV2_1" do
    expect(decompressMarkerV2.call("X(8x2)(3x3)ABCY", "(8x2)", 1, 8, 2)).to eq "ABCABCABCABCABCABC"
  end

  it "decompressMarkerV2_2" do
    expect(decompressMarkerV2.call("(27x12)(20x12)(13x14)(7x10)(1x12)A", "(27x12)", 0, 27, 12)).to eq (["A"]*241920).join("")
  end
end
