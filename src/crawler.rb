require './models.rb'

class Crawler
	def initialize
		@newsList = NewsList.new
		@agent = Mechanize.new
		@agent.follow_meta_refresh = true
		@agent.user_agent_alias = 'Windows IE 9'
	end

def crawl
	url = "http://mashable.com/2015/12/10/google-photos-shared-albums/#rmnTre_AZEqH"

	require 'mechanize'



	html = agent.get(url)

	title = html.title
	contents = html.at("section.article-content").search(".//p").map{|x| "<p>#{x.text}</p>" }.join

	@newsList.add url, News.new(title, contents)
	@newsList.store
end
end
