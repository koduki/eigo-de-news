class News
  attr_accessor :title, :contents
  def initialize title, contents
    @title = title
    @contents = contents
  end
end

class NewsList
  def initialize
    @data = {}
  end

  def add(url, news)
    @data[url] = news
  end

  def get(url)
    @data[url]
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
