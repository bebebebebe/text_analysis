require './process_header'

class Writer

	def initialize
	
		if ARGV.first
			@file = ARGV.first
			else @file = "anna_k.txt"
		end
		
		@suffixes = {}		
	end

	def words
		@words ||= File.read(@file).gsub(/\n\n/," *P* ").split
	end


	def suffixes(n)		# hash: prefix of length n => array of suffixes with repetition
		if @suffixes[n]
			return @suffixes[n]
		end		
		hash = Hash.new { |hash,key| hash[key] = [] }

		for i in (0..(words.length - n))
			hash[words[i...(i+n)]] << words[i+n]
		end
		@suffixes[n] = hash
		hash
	end
	

# assume prefix.length >= order
	def chain(prefix, order) # array, number -> string that comes after array, based on order
		successors = suffixes(order)[prefix[(0-order)..-1]]	# array of successors to prefix		
		successors[rand(successors.length)]
	end


	def start(n) # first n words of a randomly chosen paragraph
		$/ = "\n\n"
		paragraph_array = File.readlines(@file)		
		paragraph = paragraph_array[rand(paragraph_array.length)]
		start = paragraph.split[0...n]
	end


	def paragraph(order)	# generate paragraph, with order-gram markov chain
		array = []
		start = start(order)		
		while start.length < order		# check that start is long enough
			start = start(order)
		end
		for i in (0...order)
			array[i] = start[i]
		end
		array
		while array.length < 500			# use chain to determine next word. stop when get to end of a paragraph marker, or
 			prefix = array[(0-order)..-1]	# 	have more than 500 words.
 			next_word = chain(prefix, order)
 			if next_word == "*P*"
 				break
 			else array << next_word
 			end
 		end 
 		paragraph = ""
 		array.each do |x|
 			paragraph += x + " "
 		end
		paragraph
	end
	
	def output(order=2, number_of_paragraphs=2)
		remove_header(@file)
		number_of_paragraphs.times { puts; puts paragraph(order); puts }
		give_source_info
	end
	
	def give_source_info	# defined in process_header.rb
		if source_info
			puts
			20.times {print " "}
			puts "(based on #{source_info[1]} by #{source_info[0]})"
		end
	end
end



Writer.new.output(2,3)


