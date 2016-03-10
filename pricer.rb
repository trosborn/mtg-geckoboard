require './pusher'
require './scraper'
require 'CSV'
require 'json'

class Pricer
  def self.name_and_price
    uri = 'https://push.geckoboard.com/v1/send/180957-408ea4f5-a2ba-4e90-9f40-5f2cf7ce17e9'
    cards_array = []
    cards_hash = {'api_key' => ENV['GECKO_API_KEY'], 'data' => {}}
    CSV.foreach(ENV['CARDS_CSV_PATH'], headers: true) do |row|
      card = {}
      name, edition = row['Name'], row['Edition']
      price = Scraper.name_set_and_price name, edition
      card['label'], card['value'] = name, price
      cards_array << card
    end
    cards_hash['data']['items'] = cards_array.sort_by{ |hash| hash['value'] }.reverse
    Pusher.create_agent uri, cards_hash.to_json
  end
end
