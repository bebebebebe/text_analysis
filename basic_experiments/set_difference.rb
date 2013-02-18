list_a = [1,2,3,4,5,6]
list_b = [1,3,5,7]

hash = {1 => 'a', 2 => 'b', 3 => 'c'}

# using indices of list_b
list_a_minus_b = []
list_a.each do |x|
	count = 0
	while count < list_b.length
		break if x == list_b[count]
		count += 1
	end
	list_a_minus_b << x if count == list_b.length
end

# without using list indices
a_minus_b = []
list_a.each do |x|
	not_in_b = true
	list_b.each do |y|
		if x == y			
			not_in_b = false
			break
		end	
	end	
	a_minus_b << x if not_in_b
end



# hash minus (entries with keys in list_b)

hash_minus_b = {}
hash.each do |k,v|
	not_in_b = true
	list_b.each do |y|
		if k == y
			not_in_b = false
			break
		end
	end
	hash_minus_b[k] = v if not_in_b
end

puts hash_minus_b
