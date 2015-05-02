require 'openssl'

require_relative '../../hex'
require_relative '../../ascii'

module AES
  module CBC
    module_function

    BLOCK_SIZE_BYTES = 16

    def decrypt(hex_ciphertext, hex_key)
      # Convert to ASCII
      ct, k = Hex.to_ascii(hex_ciphertext), Hex.to_ascii(hex_key)
      
      # Split ciphertext into blocks
      blocks = chunk(ct, BLOCK_SIZE_BYTES)
     
      # Extract IV
      iv = blocks.shift

      # Create AES Function
      decrypter         =  OpenSSL::Cipher::AES128.new(:ECB)
      decrypter.decrypt
      decrypter.key     = k
      decrypter.padding = 0
      
      # Decrypt block by block
      # m[0] = D(k, c[0]) ⨁ IV 
      # m[1] = D(k, c[1]) ⨁ c[0]
      # .....
      decrypted_blocks = blocks.map do |b|
        m  = decrypter.update(b) + decrypter.final
        m  = Ascii.bitwise_xor(m, iv)
        iv = b
        m
      end

      decrypted_blocks.join('')
      # Remove padding
    end

    def encrypt(hex_plaintext, hex_key, hex_iv)
      # c[0] = E(k, IV⨁m[0])
      # c[1] = E(k, c[0] ⨁ m[0])
    end

    private_class_method

    def chunk(string, size)
      string.scan(/.{1,#{size}}/)
    end

    def AES_block_decrypt(block, key)

    end
  end
end
