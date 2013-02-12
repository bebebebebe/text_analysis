
file = 'anna_k_p1c1.txt'

text = File.readlines(file)


string = text.join("").downcase.gsub(/-/, "X")	# puts text into a lowercase string, but - replaced by X
string = string.gsub(/[[:punct:]]/, "")			# removes punctuation
list = string.split(/\s+|X+/)					# puts into array, splitting on whitespace or X

hash = Hash.new(0)
list.each do |word|
	hash[word] += 1
end
	
distinct_words = hash.length

total_words = 0
hash.each do |d,v|
	total_words +=v
end



puts "There are #{distinct_words} distinct words in the text, and #{total_words} words in total."