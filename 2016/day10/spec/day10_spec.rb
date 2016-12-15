require 'spec_helper'

describe Day10 do
  it "parseBotInstruction" do
    expect(parseBotInstruction("bot 2 gives low to bot 1 and high to bot 0")).to eq ["bot2", {:high => "bot0", :low => "bot1"}]
  end

  it "parseBotInstruction" do
    expect(parseBotInstruction("bot 2 gives low to output 1 and high to bot 0")).to eq ["bot2", {:high => "bot0", :low => "output1"}]
  end

  it "parseValueInstruction" do
    expect(parseValueInstruction("value 5 goes to bot 2")).to eq ["bot2", 5]
  end

  it "processValueInstructions" do
    input = [
      parseValueInstruction("value 5 goes to bot 2"),
      parseValueInstruction("value 6 goes to bot 3"),
      parseValueInstruction("value 3 goes to bot 7"),
      parseValueInstruction("value 1 goes to bot 1"),
    ]
    value = processValueInstructions(input)
    expect(value).to eq ({"bot2"=>["bot2", [5]], "bot3"=>["bot3", [6]], "bot7"=>["bot7", [3]], "bot1"=>["bot1", [1]]})
  end
end
