#!/usr/bin/env ruby 

require 'net/http'
require 'uri'

require_relative '../utils/aes'
require_relative '../utils/hex'
require_relative '../utils/ascii'

def guesses
  (0..255).to_a
end

class PaddingOracle
  HOST  = 'crypto-class.appspot.com'
  PATH  = '/po'
  PARAM = 'er'
  
  def initialize(cipher_text)
    @cipher_text = cipher_text
  end

  def query?
    uri = 
      URI::HTTP.build({ 
        host:   HOST, 
        path:   PATH,
        query:  "#{PARAM}=#{@cipher_text}"
      })

    res = Net::HTTP.get_response(uri)
    puts '[+] Success Code!!' if res.code == '200'
    res.code == '404'
  end
end

cipher_text = 
"f20bdba6ff29eed7b046d1df9fb7000058b1ffb4210a580f748b4ac714c001bd4a61044426" + 
"fb515dad3f21f18aa577c0bdf302936266926ff37dbf7035d5eeb4"

# Padding Oracle

# c[0]

# guess last byte
# chop message down to first block + IV
# last byte of IV => xor g xor 0x01 (guess g)
# good pad? => g correct
# now guess second to last byte
# chop message down to first block + IV
# last byte of IV = known value
# 2nd last byte of IV => xor g xor 0x2 (guess g)
# good pad? => g correct
# etc
# etc
# submit IV’ c[0]

blocks = AES.blocks(cipher_text)
iv     = blocks.first

#
# Guess last byte of first block
#
# Drop the current padding block
blocks.pop

# Convert to bytes
bytes_blocks = blocks.map{ |b| Hex.to_bytes(b) }
bytes_iv     = Hex.to_bytes(iv)

require 'pry'; binding.pry

# Try all possible values of last byte
original_value = bytes_blocks[-2][-1]

guesses.each do |g|
  bytes_blocks[-2][-1] = original_value ^ g ^ 1

  # created modified 2 block ciphertext
  ct = Bytes.to_hex(bytes_blocks.flatten)
  #query oracle
  puts 'Found: ' + g.to_s if  PaddingOracle.new(ct).query?
end
