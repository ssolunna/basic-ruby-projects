def substrings(string, array)
  matches = Array.new

  array.each do |element|
    if string.match?(/#{element}/i)
      matches.push(element)
    end
  end

  matches
end