require 'open-uri'
require 'nokogiri'

@ranks = []

def rankPage(page = 1)
  return "http://apps.naver.com/apps?serviceType=all&viewType=default&page=#{page}&orderType=POPULARITY&appCateCode=LIFE"
end



# Perform a google search
doc = Nokogiri::HTML(open(rankPage))

pageCount = 0
doc.css('div.paginate_v1 a', 'div.paginate_v1 strong').each do |e|
  pageCount+=1
end
puts pageCount

rank = 1

pageCount.times do |p|
  p += 1 #because first page index is 0 not 1
  doc = Nokogiri::HTML(open(rankPage(p)))
  # Print out each link using a CSS selector
  doc.css('div.app_list strong a').each do |link|
    @ranks << rank.to_s + " : " + link.content + ": "+ link.attr('href').delete("/app/")
    rank += 1
  end  
end

puts "---------"
puts @ranks