

# content = File.read("./news.yml")

site_members = ["Patrick Sommier", "Alphonse Artois", "Benjamin Ben Chedrid", "Cédric Caporal"]

# File.readlines('./news.yml').each do |line|
#   File.open
# end

# return_string = ""
# content.each_with_index do | substring, i |
#   substring << "\n" unless i = content.last
#   substring << "    " + "site_member" + ":" + site_members.sample
#   output = File.open('./news.new.yml', "w")
#   output.puts substring
#   output.close
# end

# p return_string

output = File.open('./news.new.yml', "w")
path = './news.yml'
lines = IO.readlines(path).each do |line|
  # output.puts "    site_member: #{site_members.sample}"
  if line[0] == "-"
    line = line.sub('- ', '- "')
    line = line.sub(':', '":')
  end
  output.puts line
end
File.open(path, 'w') do |file|
  file.puts lines
end
output.close
