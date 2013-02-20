require "open-uri"

url_start = "http://www.gutenberg.org/files"
url_rest = "1656/1656.txt"
url = url_start + "/" + url_rest

remote_data = open(url).read
#my_local_file = open("my-downloaded-page.html", "w") 
my_local_file = open("test_text.txt", "w")

my_local_file.write(remote_data)
my_local_file.close