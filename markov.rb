class Writer

	def initialize(file)
		@file = file
	end

	def words	
		File.read(@file).split(/\s+/)		
	end


	def suffixes(n)		# hash: prefix of length n => array of suffixes with repetition
		hash = Hash.new { |hash,key| hash[key] = [] }
		puts Time.now
		for i in (0..(words.length - n))
			hash[words[i...(i+n)]] << words[i+n]
		end
		puts Time.now
		hash
	end
	

# assume prefix.length >= order
	def chain(prefix, order) # array, number -> string that comes after array, based on order
		successors = suffixes(order)[prefix[(0-order)..-1]]	# array of successors to prefix		
		successors[rand(successors.length)]
	end

# assume start.length >= order
	def paragraph(start, order, length)
		array = []
		for i in (0...order)
			array[i] = start[i]
		end
 		while array.length < length	
 			prefix = array[(0-order)..-1]
 			array << chain(prefix,order)
 		end
		array
	end


	def print_test
		suffixes(1)
		#puts chain(["Happy", "families"], 2)
		#puts paragraph(["Happy", "families"], 2, 3)
	end

end



Writer.new('anna_k_p1c1.txt').print_test
#Writer.new('test_text.txt').print_test