require 'nokogiri'
require 'open-uri'

class Scraper
  def self.name_set_and_price name, edition
    url_params = name.gsub(/\s/,'+')
    price = 0
    doc = Nokogiri::HTML(open("http://www.cardkingdom.com/catalog/view?search=basic&filter%5Bname%5D=#{name.downcase.tr(' ', '+')}"))
    doc.xpath('//div[2]//div//div//div[1]//div//div//table[3]//tr').each do |table_row|
      if table_row.css('td').first.text == "#{name}"
        if table_row.css('td')[1].text == "#{edition}"
          price = table_row.css('td')[8].text.strip.to_i
        end
      end
    end
    price
  end
end

