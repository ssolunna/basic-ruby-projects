dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string, array)
  matches = Hash.new(0)
  string = string.split

  array.each do |element|
    for substring in string do
      matches[element] += 1 if substring.match?(/#{element}/i)
    end
  end

  matches
end

puts substrings("Below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)