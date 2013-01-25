counter = 1
file = File.new("winning.txt", "r")
#while (line = file.gets)
#    puts "#{counter}: #{line}"
#    counter = counter + 1
#end
#str = file.gets
arr = file.gets.split(',')
#arr = %w{a b b c c d e e e}
#p arr
#p arr.uniq.map {|e| [e, (arr.select {|ee| ee == e}).size ]}



#counter = {}
#arr.each {|e| counter[e] += 1 rescue counter[e] = 1 }
#p counter.to_a
#p counter.to_a.sort


counts = arr.group_by{|i| i}.map{|k,v| [k, v.count] }

counts.sort_by{|k|k[1]}.reverse.first(7).each {|x| puts x[0]}

#puts counts.sort_by{|k|k[1]}.reverse.first(7)
#p counts.sort_by{|k|k[1]}.reverse.first(7).each {|x| puts x}

file.close