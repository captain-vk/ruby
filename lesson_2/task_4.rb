ALPHABET = ('a'..'z')
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
result = {}

ALPHABET.each.with_index(1) do |char, index|
  if vowels.include?(char)
    result[char] = index
  end
end

puts result
