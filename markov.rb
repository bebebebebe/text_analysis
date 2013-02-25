require './process_header'

class Writer
  attr_reader :suffixes

	def initialize
	
		if ARGV.first
			@file = ARGV.first
			else @file = "anna_k.txt"
		end
		
		@suffixes = Hash.new {|suffs,n| suffs[n] = generate_suffixes(n)}
	end

	def words
		@words ||= File.read(@file).gsub(/\n\n/," *P* ").split
	end

  def generate_suffixes(n)
		hash = Hash.new { |hash,key| hash[key] = [] }

    words.each_cons(n+1).each_with_object(hash) do |ws, hash|
      hash[ws.first n] << ws.last
    end
  end
	

# assume prefix.length >= order
	def chain(prefix, order) # array, number -> string that comes after array, based on order
		successors = suffixes[order][prefix[(0-order)..-1]]	# array of successors to prefix		
		successors[rand(successors.length)]
	end


	def start(n) # first n words of a randomly chosen paragraph
		$/ = "\n\n"
    paragraph_array = File.readlines @file
    loop do
      paragraph = paragraph_array[rand(paragraph_array.length)]
      start = paragraph.split.first n
      return start unless start.length < n
    end
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


