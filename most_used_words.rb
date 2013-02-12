# prints 20 most used words with number of times used

file = 'anna_k_p1c1.txt'

text = File.readlines(file)


string = text.join("").downcase.gsub(/-/, "X")	# puts text into a lowercase string, but - replaced by X
string = string.gsub(/[[:punct:]]/, "")			# removes punctuation
list = string.split(/\s+|X+/)					# puts into array, splitting on whitespace or X

hash = Hash.new(0)
list.each do |word|
	hash[word] += 1
end

sorted_hash = hash.sort_by{|k,v| -v}



for k,v in sorted_hash[0..19]
	print k
	print ' : '
	puts v
end


