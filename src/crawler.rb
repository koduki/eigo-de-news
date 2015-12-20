require 'mechanize'
require './models.rb'

class Crawler
  def initialize
    @newsList = NewsList.new
    @newsList.load
    
    @agent = Mechanize.new
    @agent.follow_meta_refresh = true
    @agent.user_agent_alias = 'Windows IE 9'
  end

  def crawl
    crawlers = [
      MashableCrawler.new(@agent),
      AquariumCrawler.new(@agent)
    ]
    
    crawlers.each do |crawler|
      crawler.get_urls.each do |url|
        begin
          contents = crawler.parse url
          puts Time.new.to_s + "\t" + contents[:site] + "\t" + contents[:title]
          @newsList.add url, News.new(contents[:title], contents[:body])
        rescue => ex
          puts ex.message
        end
      end
  
      @newsList.store
    end
  end
end

class MashableCrawler
  def initialize agent
    @agent = agent
    @site = "Mashable"
  end
  
  def get_urls
    html = @agent.get("http://feeds.mashable.com/Mashable")
    html.search('link').map{|x| x.text}[1..5]
  end
  
  def parse url
    html = @agent.get(url)
    title = html.title
    body = html.at("section.article-content").search(".//p").map{|x| "<p>#{x.text}</p>" }.join
    {title:title, body:body, site:@site}
  end
end

class AquariumCrawler
  def initialize agent
    @agent = agent
    @site = "The Aquarium"
  end
  
  def get_urls
    require 'nokogiri'
    html = Nokogiri::HTML.parse(@agent.get("http://blogs.oracle.com/theaquarium/feed/entries/atom").body)
    html.search("//entry/link/@href").map{|x| x.value }[1..5]
  end
  
  def parse url
    html = @agent.get(url)
    title = html.title
    body = html.at(".entry-body").search(".//p").map{|x| "<p>#{x.text}</p>" }.join
    {title:title, body:body, site:@site}
  end
end