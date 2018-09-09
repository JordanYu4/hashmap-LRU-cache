require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  char_counts = HashMap.new
  string.chars.each do |char| 
    if char_counts.include?(char)
      char_counts[char] += 1
    else
      char_counts[char] = 1
    end
  end
  odd_chars = 0 
  char_counts.each do |char|
    odd_chars += 1 if char[1].odd? 
    return false if odd_chars > 1
  end
  true
end
