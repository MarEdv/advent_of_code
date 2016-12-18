require 'spec_helper'

describe Day12 do
  it "" do
    res = process(["cpy 41 a",
                  "inc a",
                  "inc a",
                  "dec a",
                  "jnz a 2",
                  "dec a"], {'a' => 0})
    expect(res).to eq ({'a' => 42})
  end
end