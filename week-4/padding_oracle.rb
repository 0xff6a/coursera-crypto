require 'net/http'
require 'uri'

module PaddingOracle
  extend self
  
  HOST  = 'crypto-class.appspot.com'
  PATH  = '/po'
  PARAM = 'er'

  def query?(cipher_text)
    uri = 
      URI::HTTP.build({ 
        host:   HOST, 
        path:   PATH,
        query:  "#{PARAM}=#{cipher_text}"
      })

    res = Net::HTTP.get_response(uri)
    puts '[+] Success Code!!' if res.code == '200'
    
    res.code == '404' || res.code == '200'
  end
end