print "Type the character to be modified: "
character = gets.chomp

print "Type the shift factor: "
shift_factor = (gets.chomp).to_i

def shift_lowercase_character(character, shift_factor)
  range = ("a".."z").to_a
  character_at_index = range.index(character)
  range[(character_at_index + shift_factor) % 26]
end

puts "Caesar Cipher: #{shift_lowercase_character(character, shift_factor)}"