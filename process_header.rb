# helper file for markov.rb

# txt file from project Gutenberg -> file with header removed, title
# header: info up to ***START OF THIS PROJECT GUTENBERG EBOOK [TITLE]***, 
#	plus following paragraph (variable spacing surrounds it)




# file from initialize, next line to be deleted
#file = "anna_k.txt"


def remove_header(file)	# removes header and footer if @file is a project gutenberg file
						# puts result in new_file.txt
	
	new_file = "new_file.txt"
	old_file = File.open(file)

	input = old_file.readlines
	output = File.open(new_file, 'w')

	line_number = 0
	
	if input[0][0...27] == "The Project Gutenberg EBook"		
		title_line = 0
		author_line = 0
		
		line_number += 1 until (input[line_number][0...3] == "***" or line_number > 100)		
		while (input[line_number][0...3] == "***" or input[line_number] == "\n")
			line_number += 1
		end
				
  		title_line += 1 until (input[title_line][0...6] == "Title:" or title_line > 100)
  		author_line += 1 until (input[author_line][0...7] == "Author:" or author_line > 100)
				
		@title = input[title_line][7..-1].chomp if input[title_line][0...6] == "Title:"
		@author = input[author_line][8..-1].chomp if input[author_line][0...7] == "Author:"
		
		end_line = 0
		end_line += 1 until (input[end_line][0...34] == "End of the Project Gutenberg EBook" or end_line == (input.length - 1))
										
	end

	input[(line_number +5)...end_line].each do |line|
		output.write(line)
	end

	output.close()
	old_file.close()
	
	return new_file
	
end

def source_info
	if (@author and @title) 
		return [@author, @title]
	end
end
