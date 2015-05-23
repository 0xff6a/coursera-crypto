#!/usr/bin/env ruby 
require 'pry'

require_relative '../utils/aes'
require_relative '../utils/hex'
require_relative '../utils/ascii'

require_relative 'padding_oracle'

cipher_text = 
"f20bdba6ff29eed7b046d1df9fb7000058b1ffb4210a580f748b4ac714c001bd4a61044426" + 
"fb515dad3f21f18aa577c0bdf302936266926ff37dbf7035d5eeb4"

possible_byte_values = (2..255).to_a
blocks               = AES.blocks(cipher_text)
result               = []

# For each block
while blocks.size >= 2
  ### TODO
  ### NEED TO DO THIS BLOCK BY BLOCK NOT IN A ONER
  ### DROP A BLOCK ONCE IT IS DECODED
  
  # Convert to bytes
  original_bytes = blocks.map{ |b| Hex.to_bytes(b) }
  bytes_blocks   = blocks.map{ |b| Hex.to_bytes(b) }

  # For each byte in the block
  bytes_known = []

  (1..AES::BLOCK_SIZE_BYTES).each do |n_to_last|
    original_value = original_bytes[-2][-n_to_last..-1]

    # For each possible byte value
    possible_byte_values.each do |v|
      bytes_guess = bytes_known.dup.unshift(v)
      res         = Bytes.xor(original_value, bytes_guess)
      res         = Bytes.xor(res, Bytes.pad(n_to_last))

      bytes_blocks[-2][-n_to_last..-1] = res

      ct = Bytes.to_hex(bytes_blocks.flatten)

      # Consult the oracle to see if guess is valid
      if PaddingOracle.query?(ct)
        puts 'Found: ' + v.to_s
        bytes_known.unshift(v)
        break
      end
    end
  end

  result << bytes_known
  blocks.pop
end

puts Bytes.to_ascii(result.reverse.flatten)



