require 'sinatra'
require 'json'
require './models.rb'

get '/contents/:key' do
  newsList = NewsList.new
  newsList.load
  x = newsList.data[params['key']]
  p x
  x.to_json
end

get '/news-list.json' do
  newsList = NewsList.new
  newsList.load
  items = newsList.search
		.map{|x| {key:x["key"], title:x["value"].title, words_counts:x["value"].contents.split(" ").size} }
		.reverse

  JSON.generate(items)
end
