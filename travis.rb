require './pusher'
require 'travis'
require 'json'

repository = Travis::Repository.find('trosborn/pagliacci')

hash = {item: [{}]}
href = "https://travis-ci.org/trosborn/pagliacci/builds/#{repository.last_build_id}"
number = "#{repository.last_build_number}"
state = "#{repository.last_build_state}"
text = "<a href='" + "#{href}" + "' target='_blank'>" + "Build #{number} has #{state}" + '</a>'
hash[:item][0][:text] = text
uri = 'https://push.geckoboard.com/v1/send/180957-fa11e8a3-67cd-46b8-b4d8-78aacf26a474'
body = {'api_key' => ENV['GECKO_API_KEY'], 'data' => {}}
body['data'] = hash
puts body.to_json

Pusher.create_agent uri, body.to_json
