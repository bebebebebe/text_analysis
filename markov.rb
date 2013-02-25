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


# assume prefix.length >= order
	def chain(prefix, order) # array, number -> string that comes after array, based on order
		successors = suffixes[order][prefix.last order]	# array of successors to prefix		
    select_random successors
	end


	def start(n) # first n words of a randomly chosen paragraph
		$/ = "\n\n"
    paragraph_array = File.readlines @file # Don't read the file more than once.
    start_arrays = paragraph_array.map {|p| p.split.take n}.select {|s| s.size == n}
    select_random start_arrays
	end


	def paragraph(order)	# generate paragraph, with order-gram markov chain
		array = start order
		while array.length < 500		# use chain to determine next word. stop when get to end of a paragraph marker, or
 			prefix = array.last order # have more than 500 words.
 			next_word = chain(prefix, order)

      break if next_word == "*P*"
      array << next_word
 		end 
    array.join " "
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

  private
  def select_random(a)
    a[rand a.length]
  end

  def generate_suffixes(n)
		hash = Hash.new { |hash,key| hash[key] = [] }

    words.each_cons(n+1).each_with_object(hash) do |ws, hash|
      hash[ws.first n] << ws.last
    end
  end
	
end



Writer.new.output(2,3)


