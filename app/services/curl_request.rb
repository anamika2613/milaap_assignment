require 'net/http'
require 'uri'

class CurlRequest

  def initialize url:, email:    
  	@url = url 
  	@email = email
  end


  def get
    uri = URI(@url<<"?email="<<"#{@email}")
    req = Net::HTTP::Get.new(uri)
    req["X-FullContact-APIKey"] = ENV['full_contact_api_key']
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }

    JSON.parse(res.body) 	
  end


end