class News
  attr_accessor :title, :contents
  def initialize title, contents
    @title = title
    @contents = contents
  end
end

class NewList
  def initialize
    @data = {}
  end

  def add(url, news)
    @data[url] = news
  end

  def get(url)
    @data[url]
  end
end
