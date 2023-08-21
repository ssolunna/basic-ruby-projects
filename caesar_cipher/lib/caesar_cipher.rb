print "Type the string to be modified: "
string = gets.chomp

print "Type the shift factor (number): "
shift_factor = gets.chomp

def caesar_cipher(string, shift_factor)
  string_modified = Array.new
  
  string.each_char do |character|
    if character.match?(/[a-zA-Z]/)
      string_modified.push(shift_character(character, shift_factor))
    else
      string_modified.push(character)
    end
  end

  string_modified.join
end

def shift_character(character, shift_factor)
  if character == character.downcase
    range = ("a".."z").to_a
  else
    range = ("A".."Z").to_a
  end

  character_at_index = range.index(character)
  range[(character_at_index + shift_factor) % 26]
end

if shift_factor.match?(/^[0-9]+$/)
  shift_factor = shift_factor.to_i
  puts "Caesar Cipher: #{caesar_cipher(string, shift_factor)}"
else
  puts "Invalid shift factor: Only numbers allowed."
end