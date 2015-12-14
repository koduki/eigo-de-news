require 'sinatra'
require './models.rb'

get '/contents.json' do
  newsList = NewsList.new
  newsList.load
  x = newsList.data["http://mashable.com/2015/12/10/google-photos-shared-albums/#rmnTre_AZEqH"]
  p x
  x.to_json
end
