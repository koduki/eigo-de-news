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

  def get_urls
    html = @agent.get("http://feeds.mashable.com/Mashable")
    html.search('link').map{|x| x.text}[2..4]
  end

  def crawl
    urls = get_urls
    urls.each do |url|
      html = @agent.get(url)
      title = html.title
      contents = html.at("section.article-content").search(".//p").map{|x| "<p>#{x.text}</p>" }.join

      puts Time.new.to_s + "\t" + title

      @newsList.add url, News.new(title, contents)
    end

    @newsList.store
  end
end
