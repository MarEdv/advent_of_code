require 'spec_helper'

describe Day8 do
  it "parseRect" do
    expect(parseRect("rect 3x2")).to eq [3,2]
  end

  it "parseColumn" do
    expect(parseColumn("rotate column x=1 by 1")).to eq [1, 1]
  end

  it "parseRow" do
    expect(parseRow("rotate row y=0 by 4")).to eq [0, 4]
  end

  it "createDisplay" do
    display = createDisplay(3,4)
    expect(display).to eq [[".", ".", "."],[".", ".", "."],[".", ".", "."],[".", ".", "."]]
  end

  it "putRect" do
    display = createDisplay(3, 4)
    expect(putRect(display, 2, 3)).to eq [["#", "#", "."],["#", "#", "."],["#", "#", "."],[".", ".", "."]]
  end

  it "rotateColumn" do
    display = createDisplay(3, 4)
    display = putRect(display, 2, 1)
    expect(rotateColumn(display, 0, 1)).to eq [[".", "#", "."],["#", ".", "."],[".", ".", "."],[".", ".", "."]]
  end

  it "rotateRow" do
    display = createDisplay(3, 4)
    display = putRect(display, 2, 1)
    expect(rotateRow(display, 0, 1)).to eq [[".", "#", "#"],[".", ".", "."],[".", ".", "."],[".", ".", "."]]
  end
end
