require 'spec_helper'

describe Day7 do
  it "splitIP" do
    ip = "abba[mnop]qrst"
    expect(splitIP(ip)).to eq ["abba", "mnop", "qrst"]
  end

  it "toABBAs" do
    ipSplits = ["abba", "mnop", "qrst"]
    expect(toABBAs(ipSplits)).to eq [["abba"], [], []]
  end

  it "toABBAs_longString" do
    ipSplits = ["egabbatr", "mnop", "qrst"]
    expect(toABBAs(ipSplits)).to eq [["abba"], [], []]
  end

  it "isValidTLS_true_first" do
    abbas = [["abba"], [], []]
    expect(isValidTLS(abbas)).to eq true
  end

  it "isValidTLS_true_notFirst" do
    abbas = [[], [], ["abba"]]
    expect(isValidTLS(abbas)).to eq true
  end

  it "isValidTLS_false" do
    abbas = [["abba"], ["feef"], []]
    expect(isValidTLS(abbas)).to eq false
  end

  it "toABAs_longString" do
    ipSplits = ["egabatr", "mnonp", "qrst"]
    expect(toABAs(ipSplits)).to eq [["aba"], ["non"], []]
  end

  it "isValidSSL_true_notFirst" do
    abas = [[], ["bab"], ["aba"]]
    expect(isValidSSL(abas)).to eq true
  end

  it "existsBABInList_true" do
    abas = [[], ["bab"], ["aba"]]
    expect(existsBABInList([["aba"]], abas)).to eq true
  end

  it "existsBAB_true" do
    abas = [[], ["bab"], ["aba"]]
    expect(existsBAB(abas, "bab")).to eq true
  end

  it "isValidSSL_1" do
    ips = splitIP("aba[bab]xyz")
    abas = toABAs(ips)
    expect(isValidSSL(abas)).to eq true
  end

  it "isValidSSL_2" do
    ips = splitIP("xyx[xyx]xyx")
    abas = toABAs(ips)
    expect(isValidSSL(abas)).to eq false
  end

  it "isValidSSL_3" do
    ips = splitIP("aaa[kek]eke")
    abas = toABAs(ips)
    expect(isValidSSL(abas)).to eq true
  end

  it "isValidSSL_4" do
    ips = splitIP("zazbz[bzb]cdb")
    abas = toABAs(ips)
    expect(isValidSSL(abas)).to eq true
  end
end
