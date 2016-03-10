require 'net/http'
require 'net/https'
require 'json'
require './pricer'

class Pusher
  def self.create_agent uri, body
    uri = URI("#{uri}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ssl_version = :TLSv1
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.body = body
    res = http.request(req)
    puts "response #{res.body}"
  rescue => e
    puts "failed #{e}"
  end
end
