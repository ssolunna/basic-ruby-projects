#spec/caesar_cipher_spec.rb

require './lib/caesar_cipher.rb'

describe "#shift_character" do
  it "replaces the letter by a letter some no. of position down the alphabet" do
    expect(shift_character("a", 5)).to eql("f")
  end
  
  it "keeps the same case" do
    expect(shift_character("W", 5)).to eql("B")
  end
end

describe "#caesar_cipher" do
  it "returns a string modified by the shift factor" do
    expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
  end
end
