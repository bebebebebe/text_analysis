require './weighted_random_word.rb'


class Counter
	def initialize(file)
		@file = file
	end
	
	def most_common(n = 20)
		for k,v in sorted_hash[0...n]
			print k
			print ' : '
			puts v
		end
	end
					
	def sorted_hash
		text = File.read(@file)
		text = text.downcase.gsub(/-/, " ")
		text = text.gsub(/[[:punct:]]/, "")
		list = text.split(/\s+/)
		
		hash = Hash.new(0)
		list.each do |word|
			hash[word] += 1
		end

		hash.sort_by{|k,v| -v}
	end
	
	
	def common_words_list
		words_list = File.read('100_most_used_in_Gutenberg.txt')
		words_list = words_list.gsub(/[[:punct:]]/, "")	
		words_list = words_list.split("  ")		# array of 100 words
	end
	
	def remove_list			#return sorted hash minus common_words_list
		deleted_hash = {}
		sorted_hash.each do |k,v|
			not_in_list = true
			common_words_list.each do |w|
				if k == w
					not_in_list = false
					break
				end
			end
			deleted_hash[k] = v if not_in_list
		end
		deleted_hash.sort_by{|k,v| -v}
	end
	
	def most_common_unusual(n = 20)	# words most used that aren't in common words list
		for k,v in remove_list[0...n]
			print k
			print ' : '
			puts v
		end
	end
	
	def choose_word
		puts choose_from_hist sorted_hash
	end
	
end

#Counter.new('anna_k_p1c1.txt').most_common(5)
#puts "**** unusual *****"
Counter.new('anna_k_p1c1.txt').most_common_unusual(20)
#Counter.new('anna_k.txt').sorted_hash
