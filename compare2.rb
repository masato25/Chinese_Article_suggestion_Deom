require 'distance_measures'
require './istr.rb'

#https://github.com/reddavis/K-Means
#https://github.com/reddavis/Distance-Measures
textres = []
File.open("list_manaully_subreater","r").read.each_line{|l|
    textres = textres.push(l.force_encoding(Encoding::UTF_8).split(/\s/))
}

####################################################################
# p textres
# 0 [["3G", "轉", "4G", "最快", "周四", "可辦"],
# 1 ["遠傳", "4G", "最慢", "徐旭東", "亂扯", "我們", "很", "不錯"], 
# 2 ["遠傳", "攜", "三星", "拚銷量", "市占"],
# 3 ["遠傳", "三星", "攜手", "合作", "推", "中階", "4G", "全頻", "機"], 
# 4 ["4G", "拚", "覆蓋", "遠傳", "先求有", "再求好"], 
# 5 ["跨領域", "設", "網路TV", "台電", "味全", "搶", "曝光"],
# 6 ["授權", "爭議", "嘉澤", "鴻海", "各說各話"],
# 7 ["遠傳", "推", "Google", "Play", "帳單", "支付"]]
####################################################################

#set up target
tindex=ARGV[0].to_i
target_posts = textres[tindex]

print "selected target as : \n"
print "#{textres[tindex].join(" ")}".bg_red
print "\n"

# create hash table. for clusting use.
# ex. ["3G", "轉", "4G", "最快", "周四", "可辦"] ->
#{"3G"=>1, "轉"=>1, "4G"=>1, "最快"=>1, "周四"=>1, "可辦"=>1}
tarhash = Hash.new()
compare_sample = []
target_posts.map do |g|
    tarhash[g] = 1
    compare_sample = compare_sample.push(1)
end

#remove selected target of indexse
textres.delete_at(tindex)
compare_posts = textres


all_sample = []
compare_posts.map do |p|
    res = [] 
    p.map do |g|
      #check is here are the same text of target
      #if yes -> 1 , if no -> 0
      res = res.push(tarhash.has_key?(g) ? 1 : 0)
    end
    #put result into array
    all_sample = all_sample.push([p , res])
end

#p all_sample
#create data struct object
Cgg = Struct.new(:post, :vlaue) do end

new_ar = []
all_sample.map{|p,l|
  #this for solve binary_jaccard_index issue.
  while !(l.size >= target_posts.size)
     #append 0 into the tail
     l = l.push(0)
  end
  new_ar = new_ar.push(
               #binary_jaccard_index
               Cgg.new(p , compare_sample.binary_jaccard_index(l))
           )
}
puts "|----------------------------------------------|".bg_blue
new_ar.sort!{|a,b| a.vlaue <=> b.vlaue}.reverse.map{|l|
   print "  #{l.post.join(" ")} "
   print ", #{l.vlaue.round(2)}\n".brown
}
puts "|----------------------------------------------|".bg_blue
