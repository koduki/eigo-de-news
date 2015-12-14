require 'mechanize'
require './models.rb'

class Crawler
  def initialize
    @newsList = NewsList.new
    @agent = Mechanize.new
    @agent.follow_meta_refresh = true
    @agent.user_agent_alias = 'Windows IE 9'
  end

  def crawl
    urls = [
      "http://mashable.com/2015/12/10/google-photos-shared-albums/#rmnTre_AZEqH",
      "http://mashable.com/2015/12/12/coolest-battery-chargers/#CLI2CVZSf8qS",
      "http://mashable.com/2015/12/12/apple-watch-walmart/#v6RXvh5gZZqB",
    ]

    urls.each do |url|
      html = @agent.get(url)
      title = html.title
      contents = html.at("section.article-content").search(".//p").map{|x| "<p>#{x.text}</p>" }.join
      @newsList.add url, News.new(title, contents)
    end

    @newsList.store
  end
end
