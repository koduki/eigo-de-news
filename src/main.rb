require './models.rb'

@newsList = NewsList.new

def crawl
	url = "http://mashable.com/2015/12/10/google-photos-shared-albums/#rmnTre_AZEqH"

	require 'mechanize'

	agent = Mechanize.new
	agent.follow_meta_refresh = true
	agent.user_agent_alias = 'Windows IE 9'

	html = agent.get(url)

	title = html.title
	contents = html.at("section.article-content").search(".//p").map{|x| "<p>#{x.text}</p>" }.join

	news = News.new(title, contents)
	@newsList.add news
	#data = {title:title, contents:contents}
	#puts JSON.generate(data)
end

crawl
p @newsList
