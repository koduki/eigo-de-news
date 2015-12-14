require 'mechanize'

@agent = Mechanize.new
@agent.follow_meta_refresh = true
@agent.user_agent_alias = 'Windows IE 9'  
	
html = @agent.get("http://mashable.com/2015/12/10/google-photos-shared-albums/#rmnTre_AZEqH")
puts html.at("section.article-content").search(".//p").map{|x|x.text}.join("\n")

title = html.title
contents = html.at("section.article-content").search(".//p").map{|x| "<p>#{x.text}</p>" }.join
data = {title:title, contents:contents}
puts JSON.generate(data)
