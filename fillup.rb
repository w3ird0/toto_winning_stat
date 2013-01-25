require 'hpricot'
require 'open-uri'


ARGV.each do|a|
  puts "Argument: #{a}"
end

doc = Hpricot(open("http://www.singaporepools.com.sg/Lottery?page=wc10_toto_past&drawNo=2817"))

max_id = (doc / "select.black_text_12n option")[1].attributes['value'].split("=").last
#puts max_id

dates = (doc / "select.black_text_12n/option").text.split(", ")
dates = dates.map{|x| x[x.length-7, 7].to_s}
dates = dates.map{|x| x.split("/")[2].to_s + x.split("/")[1].to_s + x.split("/")[0].to_s}
#puts dates

hash = Hash[dates.map.with_index{|*ki| ki}]
date_count = hash["201301"].to_i

#puts date_count

str_nums = ''
for n in 0..date_count do  
  doc = Hpricot(open("http://www.singaporepools.com.sg/Lottery?page=wc10_toto_past&drawNo=" + (max_id.to_i - n).to_s))  
  nums = (doc / "table/tr/td/table/tr/td.winning_numbers_toto_b").text.gsub(/[^\d]+/, ",").to_s#.split(",")
  
  puts "URL = http://www.singaporepools.com.sg/Lottery?page=wc10_toto_past&drawNo=" + (max_id.to_i - n).to_s
  puts "RESULT = " + nums
  
  str_nums += nums + ","
  #puts str_nums.split(',')
end

arr = str_nums.split(',')

counts = arr.group_by{|i| i}.map{|k,v| [k, v.count] }
puts "WINNING NUMBERS:"
counts.sort_by{|k|k[1]}.reverse.first(7).each {|x| puts x[0]}


#p reputation