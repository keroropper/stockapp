module ArticlesHelper

  # class Stock
  def stock_value
    agent = Mechanize.new
    page = agent.get('https://kabutan.jp/news/marketnews/')
    text_link = page.search("//table[@class='s_news_list mgbt0']//tr/td/a")[1..-1]
    # text = text_link.inner_text
    html = ''
    text_link.each do |t|
      text = t.inner_text
      html += text
    end
    return "#{raw(html)}\r^[\r\n]+"
  end
# end

end
