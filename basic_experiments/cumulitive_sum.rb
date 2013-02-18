list = [1, 2, 3]
cumulitive_sum = []
for i in (0...list.length)
	cumulitive_sum[i] = 0
	for j in (0..i)
		cumulitive_sum[i] += list[j]
	end
end


# recursive version.
# list, index -> cumulative sum at index

def cumul_sum(array, n)
	if n == 0
		return array[0]
	else
		return array[n] + cumul_sum(array, n-1)
	end	
end

def cumul_sum_array array
	new_array = []
	for i in (0...array.length)
		new_array[i] = cumul_sum(array,i)
	end
	return new_array
end

# Return sum of all the numbers in the array
# recursive, without loops or indexes
def sum(array)
	if array == []
		return 0
	else return array[0] + sum(array[1..-1])
	end
end

puts sum(list)