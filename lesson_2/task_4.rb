ALPHABET = ('a'..'z')
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
result = {}
i = 1

ALPHABET.each do |letter|
  vowels.each do|vowel_letter|
    if letter == vowel_letter
      result[letter] = i
    end
  end
i += 1
end

puts result
