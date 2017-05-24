#Заполнить хеш гласными буквами,
#где значением будет являтся порядковый номер буквы в алфавите (a - 1).
# =~ то же самое что .match
letter = ('a'..'z').to_a
vowels = ['a','e','i','o','u']
vowels_hash = {}
vowels.each do |vowel|
	vowels_hash[vowel] = letter.index(vowel) + 1
end
puts vowels_hash