require 'spec_helper'

describe Day11 do
  it "isFinished_true" do
    state = ({:levels => [[],[],[],[]]})
    expect(isFinished(state)).to eq true
  end

  it "isFinished_false" do
    state = ({:levels => [[{:type => "Generator", :material => "Lithium"}],[],[],[]]})
    expect(isFinished(state)).to eq false
  end

  it "isValidLevel_true" do
    level = [{:type => "Generator", :material => "Lithium"},{:type => "Microchip", :material => "Lithium"}]
    expect(isValidLevel(level)).to eq true
  end

  it "isValidLevel_false" do
    level = [{:type => "Generator", :material => "Lithium"},{:type => "Microchip", :material => "Cobalt"}]
    expect(isValidLevel(level)).to eq false
  end

  it "isValidLevel_false" do
    level = [{:type => "Generator", :material => "Lithium"},{:type => "Microchip", :material => "Cobalt"},{:type => "Microchip", :material => "Lithium"}]
    expect(isValidLevel(level)).to eq false
  end

  it "isValid_false" do
    state = ({:elevator => 1, :levels => [[{:type => "Generator", :material => "Lithium"}],[],[],[]]})
    move = ({:elevator => 0, :items => [{:type => "Microchip", :material => "Cobalt"}]})
    expect(isValid(state, move)).to eq false
  end

  it "isValid_true" do
    state = ({:elevator => 1, :levels => [[{:type => "Generator", :material => "Lithium"}],[],[],[]]})
    move = ({:elevator => 0, :items => [{:type => "Microchip", :material => "Lithium"}]})
    expect(isValid(state, move)).to eq true
  end

  it "nextState" do
    state = ({:steps => 0, :elevator => 1, :levels => [[{:type => "Generator", :material => "Lithium"}],[{:type => "Microchip", :material => "Lithium"}],[],[]]})
    move = ({:elevator => 0, :items => [{:type => "Microchip", :material => "Lithium"}]})
    expect(nextState(state, move)).to eq ({:elevator=>0, :steps=>1, :levels=>[[{:type=>"Generator", :material=>"Lithium"}, {:type=>"Microchip", :material=>"Lithium"}].to_set, [].to_set, [].to_set, [].to_set]})
  end

  it "nextValidStates_1" do
    state = ({:steps => 0, :elevator => 1, :levels => [[{:type => "Generator", :material => "Lithium"}],[{:type => "Microchip", :material => "Cobalt"}].to_set,[].to_set,[].to_set]})
    expect(nextValidStates(state)).to eq [{:elevator=>2, :steps=>1, :levels=>[[{:type=>"Generator", :material=>"Lithium"}].to_set, [].to_set, [{:type=>"Microchip", :material=>"Cobalt"}].to_set, [].to_set]}]
  end

  it "isValidLevel_false_large" do
    level = [{:type=>"Generator", :material=>"Cobalt"},
      {:type=>"Generator", :material=>"Curium"},
      {:type=>"Generator", :material=>"Ruthenium"},
      {:type=>"Generator", :material=>"Promethium"},
      {:type=>"Microchip", :material=>"Promethium"},
      {:type=>"Microchip", :material=>"Cobalt"},
      {:type=>"Microchip", :material=>"Plutonium"}
    ]
    expect(isValidLevel(level)).to eq false
  end
end
