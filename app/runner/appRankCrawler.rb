require 'open-uri'
require 'nokogiri'

NAVER_ORDER_TYPE=%w{INSTALL POPULARITY}

NAVER_APP_LIST_ACCESS_CSS_SELECTOR = "div.app_list ol li"
# NAVER_APP_LIST_ACCESS_CSS_SELECTOR = "div.app_list strong a"

def rankPageURL(page = 1, orderType = NAVER_ORDER_TYPE[0])
  return "http://apps.naver.com/apps?serviceType=all&viewType=default&page=#{page}&orderType=#{orderType}"
end

def crawlRank(orderType = NAVER_ORDER_TYPE[0])
  doc = Nokogiri::HTML(open(rankPageURL(1, orderType)))

  pageCount = 0
  doc.css('div.paginate_v1 a', 'div.paginate_v1 strong').each do |e|
    pageCount+=1
  end

  rank = 1

  pageCount.times do |p|
    p += 1 #because first page index is 0 not 1
    
    unless p == 1 #first page fetched already for fetch page info
      doc = Nokogiri::HTML(open(rankPageURL(p, orderType)))
    end
    
    doc.css(NAVER_APP_LIST_ACCESS_CSS_SELECTOR).each do |app|
      name = app.css('strong a').text
      appId = app.css('strong a').attr("href").value.delete('/app/')
      author = app.css('span.author').text.gsub(/\t|\r|\n|by\s/,'')
      description = app.css('p.desc').text
      category = app.css('dl.app_info dd.category').text
      birthday = app.css('dl.app_info dd.date').text
      
      rating = app.css('dl.app_info dd em').text
      downloadCount = app.css('dl.app_info dd.total span').text
            
      app = App.find(:first, :conditions=>["name=? and appId=?", name, appId])
    
      if app.nil?
        app = App.create(:name=>name, 
        :appId=>appId, 
        :author=>author, 
        :description=>description, 
        :category=>category, 
        :birthday=>Date.parse(birthday),
        :platform=>"naver")
      end
      
      app.ranks.create(:rank=>rank,
      :orderType=>orderType,
      :rating=>rating,
      :downloadCount=>downloadCount,
      )

      rank += 1
    end  
  end
end


NAVER_ORDER_TYPE.each do |ot|
  crawlRank(ot)
end

# for test in rails console
# app = Nokogiri::HTML(open("http://apps.naver.com/apps?serviceType=all&viewType=default&page=1&orderType=INSTALL")).css("div.app_list ol li").first