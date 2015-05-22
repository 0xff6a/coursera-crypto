#!/usr/bin/env ruby 

require 'net/http'
require 'uri'
require 'pry'

require_relative '../utils/aes'
require_relative '../utils/hex'
require_relative '../utils/ascii'

def guesses
  (32..126).to_a
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
#
# Guess last byte of first block
#
# Drop the current padding block and IV
blocks.pop

# Convert to bytes
bytes_blocks   = blocks.map{ |b| Hex.to_bytes(b) }
original_bytes = blocks.map{ |b| Hex.to_bytes(b) }

bytes_known = []

# For each block
(1..blocks.size).each do |b|
  b += 1
  ### TODO
  ### NEED TO DO THIS BLOCK BY BLOCK NOT IN A ONER
  ### DROP A BLOCK ONCE IT IS DECODED

  # For each byte in the block
  (1..AES::BLOCK_SIZE_BYTES).each do |n_to_last|
    original_value = original_bytes[-b][-n_to_last..-1]

    # For each possible byte value
    guesses.each do |g|
      bytes_guess = bytes_known.dup.unshift(g)
      res         = Bytes.xor(original_value, bytes_guess)
      res         = Bytes.xor(res, Bytes.pad(n_to_last))

      bytes_blocks[-b][-n_to_last..-1] = res

      ct = Bytes.to_hex(bytes_blocks.flatten)

      # Consult the oracle to see if guess is valid
      if PaddingOracle.new(ct).query? 
        bytes_known.unshift(g)
        puts 'Found: ' + g.to_s
        break
      end
    end
  end
end

puts Bytes.to_ascii(bytes_known)
