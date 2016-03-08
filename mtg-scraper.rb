require 'nokogiri'
require 'open-uri'

class Scraper
  def self.name_set_and_price card_name
    url_params = card_name.gsub(/\s/,'+')
    doc = Nokogiri::HTML(open('http://www.cardkingdom.com/catalog/view?search=basic&filter%5Bname%5D=underground+sea'))
    values = []
    doc.xpath('//div[2]//div//div//div[1]//div//div//table[3]//tr').each do |table_row|
      if table_row.css('td').first.text == "#{card_name}"
        ary = []
        table_row.css('td')[0..9].each_with_index do |cell, index|
          if index < 2 || index == 8
            value = cell.text
            values << value.gsub(/\n/, "")
          end
        end
        values << ary
      end
    end
    values
  end
end

