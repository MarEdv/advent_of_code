require 'spec_helper'

describe Day4 do
  it "toName" do
    expect(toName(["a", "b", "c"])).to eq "abc"
  end

  it "sortIt" do
    expect(sortIt((["a"=>["a", "a", "a"], "b"=>["b", "b", "b"], "c"=>["c", "c", "c"], "d"=>["d", "d", "d", "d"]])[0])).to eq (["d", "a", "b", "c"])
  end

  it "groupParts" do
    expect(groupParts(["aaa", "bbb", "ccc", "dddd", "eee"])).to eq (["a"=>["a", "a", "a"], "b"=>["b", "b", "b"], "c"=>["c", "c", "c"], "d"=>["d", "d", "d", "d"]])[0]
  end

  it "a correct encryption 1" do
    expect(parse("aaaaa-bbb-z-y-x-123[abxyz]")).to eq ["abxyz", 123, "abxyz", "aaaaa-bbb-z-y-x-123[abxyz]"]
  end

  it "a correct encryption 2" do
    expect(parse("a-b-c-d-e-f-g-h-987[abcde]")).to eq ["abcde", 987, "abcde", "a-b-c-d-e-f-g-h-987[abcde]"]
  end

  it "a correct encryption 3" do
    expect(parse("gvaaz-kfmmzcfbo-qvsdibtjoh-103[ankyj]")).to eq ["abfmo", 103, "ankyj", "gvaaz-kfmmzcfbo-qvsdibtjoh-103[ankyj]"]
  end

  it "an incorrect encryption" do
    expect(parse("totally-real-room-200[decoy]")).to eq ["loart", 200, "decoy", "totally-real-room-200[decoy]"]
  end

  it "decrypt" do
    expect(decrypt("abcde-dgdh", 2)).to eq "cdefg fifj"
  end
end