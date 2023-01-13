print "Type the character to be modified: "
character = gets.chomp

print "Type the shift factor: "
shift_factor = (gets.chomp).to_i

def shift_character(character, shift_factor)
  (character.ord + shift_factor).chr
end

puts "Caesar Cipher: #{shift_character(character, shift_factor)}"