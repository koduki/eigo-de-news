class News
  attr_accessor :title, :contents
  def initialize title, contents
    @title = title
    @contents = contents
  end

  def to_json
    require 'json'
    json = {"title" => @title, "contents" => @contents}
    JSON.generate(json)
  end
end

class NewsList
  attr_accessor :data
  def initialize
    @data = {}
  end

  def add(url, news)
    require 'digest/md5'
    key = Digest::MD5.hexdigest url
    @data[key] = news
  end

  def get(key)
    @data[key]
  end

  def search
    @data.map{|x| {"key" => x.first, "value" => x.last}}
  end

  def store
    require "pstore"
    db = PStore.new("data.db")
    db.transaction do
      db["data"] = @data
    end
  end

  def load
    require "pstore"
    db = PStore.new("data.db")
    db.transaction do
      @data = db["data"]
    end
  end
end
