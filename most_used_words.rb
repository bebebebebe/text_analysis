# prints 20 most used words with number of times used



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
	
	
end

Counter.new('anna_k_p1c1.txt').most_common



