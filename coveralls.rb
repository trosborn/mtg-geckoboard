require 'net/http'
require 'json'
require './pusher'

url = 'https://coveralls.io/github/trosborn/pagliacci.json'
uri = URI(url)
response = Net::HTTP.get(uri)
covered_percent = JSON.parse(response)['covered_percent'].to_i
body = {'api_key' => ENV['GECKO_API_KEY'], 'data' => {'min' => {}, 'max' => {}}}
body['data']['item'] = covered_percent
body['data']['min']['value'], body['data']['max']['value'] = 0, 90
post_uri = 'https://push.geckoboard.com/v1/send/180957-207370ce-f63f-4bbe-ab52-6ac9b64aa25e'

Pusher.create_agent post_uri, body.to_json
