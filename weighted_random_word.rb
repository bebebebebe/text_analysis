def choose_from_hist hist
	list = []
	for k,v in hist
		v.times do
			list << k
		end	
	end
	list[rand(list.length)]
end