require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?

require_relative "./models.rb"

get '/contents/:key' do
  newsList = NewsList.new
  newsList.load
  news = newsList.data[params['key']]
  news.to_json
end

get '/news-list.json' do
  newsList = NewsList.new
  newsList.load
  items = newsList.search
		.map{|x| {key:x["key"], title:x["value"].title, words_counts:x["value"].contents.split(" ").size} }
		.reverse

  JSON.generate(items)
end

get '/post_histories/:key/:time' do
  history = History.new
  history.load

  news = params['key']
  history.add(params['time'], news)
  history.store

  JSON.generate({status:"success"})
end

get '/histories' do
  histories = History.new
  histories.load

  newsList = NewsList.new
  newsList.load

  items = histories.data.map{|x|
    news = newsList.get(x[:news_id])
    unless news == nil
      x[:time] = x[:time].to_i
      x[:news_title] = news.title
      x[:new_words] = news.contents.split(" ").size
    end
    x
  }.find_all{|x| x[:news_title] != nil}

  JSON.generate(items)
end
