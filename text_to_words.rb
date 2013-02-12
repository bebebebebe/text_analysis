# takes text file and turns it into an array of lower case words without punctuation

file = 'anna_k_p1c1.txt'

text = File.readlines(file)

string = text.join("").downcase.gsub(/-/, "X")	# puts text into a lowercase string, but - replaced by X
string = string.gsub(/[[:punct:]]/, "")			# removes punctuation
list = string.split(/\s+|X+/)					# puts into array, splitting on whitespace or X


puts list

