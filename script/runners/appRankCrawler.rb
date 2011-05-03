require 'open-uri'
require 'nokogiri'

NAVER_ORDER_TYPE=%w{INSTALL POPULARITY}
# NATE_ORDER_TYPE=%w{1 2} #1:last 7days, 2:cumulate
NATE_ORDER_TYPE=%w{1 2} #1:업데이트순(앱이 업데이트 된 순으로), 2:인기순(오늘 play를 시작한 회원이 많은순으로

NAVER_APP_LIST_ACCESS_CSS_SELECTOR = "div.app_list ol li"
# NATE_APP_LIST_ACCESS_CSS_SELECTOR = "div.apps-ranklist dl.apps-item"
NATE_APP_LIST_ACCESS_CSS_SELECTOR = "div.popularBox div.list dl"

def naverRankPageURL(page = 1, orderType = NAVER_ORDER_TYPE[0])
  return "http://apps.naver.com/apps?serviceType=all&viewType=default&page=#{page}&orderType=#{orderType}"
end

def nateRankPageURL(page = 1, orderType = NATE_ORDER_TYPE[1])
  return "http://appstore.cyworld.com/Main/PopularList?startpos=#{page}&ordertype=#{orderType}&cate_cd=#list_focus"
end

def naverCrawlRank(orderType = NAVER_ORDER_TYPE[0])
  doc = Nokogiri::HTML(open(naverRankPageURL(1, orderType)))

  pageCount = 0
  doc.css('div.paginate_v1 a', 'div.paginate_v1 strong').each do |e|
    pageCount+=1
  end

  rank = 1

  pageCount.times do |p|
    p += 1 #because first page index is 0 not 1

    unless p == 1 #first page fetched already for fetch page info
      doc = Nokogiri::HTML(open(naverRankPageURL(p, orderType)))
    end

    doc.css(NAVER_APP_LIST_ACCESS_CSS_SELECTOR).each do |app|
      name = app.css('strong a').text
      appId = app.css('strong a').attr("href").value.delete('/app/')
      author = app.css('span.author').text.gsub(/\t|\r|\n|by\s/,'')
      description = app.css('p.desc').text
      category = app.css('dl.app_info dd.category').text
      birthday = app.css('dl.app_info dd.date').text

      rating = app.css('dl.app_info dd em').text
      downloadCount = app.css('dl.app_info dd.total span').text.delete(",").to_i

      a = App.find(:first, :conditions=>["platform=? and appId=?", "naver", appId])

      if a.nil?
        a = App.create(:name=>name,
        :appId=>appId,
        :author=>author,
        :description=>description,
        :category=>category,
        :birthday=>Date.parse(birthday),
        :platform=>"naver")
      end

      a.ranks.create(:rank=>rank,
      :orderType=>orderType,
      :rating=>rating,
      :downloadCount=>downloadCount,
      )

      rank += 1
    end
  end
end

def nateCrawlRank(orderType = NATE_ORDER_TYPE[0])
  doc = Nokogiri::HTML(open(nateRankPageURL(1, orderType)))

  # pageCount = doc.css('div.paging-wrap a.p-end').attr("href").value[27..28].to_i
  appCount = doc.css('ul.category li').first.css('i').text.gsub(/\[|\]/,'').to_i
  pageCount = appCount/10
  if appCount%10 > 0 
    pageCount += 1
  end
  
  rank = 1

  pageCount.times do |p|
    p += 1 #because first page index is 0 not 1
    
    unless p == 1 #first page fetched already for fetch page info
      doc = Nokogiri::HTML(open(nateRankPageURL(p, orderType)))
    end
    
    doc.css(NATE_APP_LIST_ACCESS_CSS_SELECTOR).each do |app|
      name = app.css('dt a').text
      # appId = app.css('dt a').attr('onclick').content.split('(')[1].split(',')[0].split('=')[1]
      appId = app.css('dt a').attr('onclick').content.split('(')[1].split(',')[0].split('=')[1].gsub(/'|[a-z]|\s|;|\)/,'')
      # author = app.css('dd.info span.developer em').text
      author = app.css('dd.detail ul li.dev').text.split(" | ")[0]
      # description = app.css('dd.desc').text.strip
      description = app.css('dd.desc a').text
      # category = app.css('dd.info span.sec').text
      category = app.css('dd.detail ul li.cate').text.gsub(/\t|\s/,'')
      # birthday = app.css('dd.date').text.strip
      birthday = app.css('dd.detail ul li span.date').text
      
      # rating = app.css('dd.star em.star-value i').text[0..2]
      rating = app.css('dd.detail ul li.apinfo span.star').text
      # downloadCount = app.css('dd.thumb p.people strong em').text
      downloadCount = app.css('dd.detail ul li.apinfo span.mem').text.gsub(',','')
            
      a = App.find(:first, :conditions=>["platform=? and appId=?", "nate", appId])
    
      if a.nil?
        a = App.create(:name=>name, 
        :appId=>appId, 
        :author=>author, 
        :description=>description, 
        :category=>category, 
        :birthday=>Date.parse(birthday),
        :platform=>"nate")
      else
        # will remove after migration
        a.category = category
        a.updated_at = Date.parse(birthday)
        a.save
      end
      
      a.ranks.create(:rank=>rank,
      :orderType=>orderType,
      :rating=>rating,
      :downloadCount=>downloadCount,
      )

      rank += 1
    end  
  end
end

NAVER_ORDER_TYPE.each do |ot|
  naverCrawlRank(ot)
end

NATE_ORDER_TYPE.each do |ot|
  nateCrawlRank(ot)
end

# for naver apps test in rails console
# require 'open-uri'
# require 'nokogiri'
# app = Nokogiri::HTML(open("http://apps.naver.com/apps?serviceType=all&viewType=default&page=1&orderType=INSTALL")).css("div.app_list ol li").first

# for nate apps test in rails console
require 'open-uri'
require 'nokogiri'
app = Nokogiri::HTML(open("http://appstore.nate.com/Main/PopularList?ordertype=2&cate_cd=#list_focus")).css("div.apps-ranklist dl.apps-item").first


