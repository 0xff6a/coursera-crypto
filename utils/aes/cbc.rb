require 'openssl'

require_relative '../aes'

module AES
  module CBC
    module_function
    extend AES

    def decrypt(hex_ciphertext, hex_key)
      # Convert to ASCII
      ct, k = Hex.to_ascii(hex_ciphertext), Hex.to_ascii(hex_key)
      
      # Split ciphertext into blocks
      blocks = chunk(ct, BLOCK_SIZE_BYTES)
     
      # Extract IV
      iv = blocks.shift

      # Create AES Function
      decrypter = build_decrypter(k)
      
      # Decrypt block by block
      # -> m[0] = D(k, c[0]) ⨁ IV 
      # -> m[1] = D(k, c[1]) ⨁ c[0]
      # -> .....
      decrypted_blocks = blocks.map do |b|
        m  = decrypter.update(b) + decrypter.final
        m  = Ascii.bitwise_xor(m, iv)
        iv = b
        m
      end

      decrypted_blocks.join('')
    end

    def encrypt(ascii_plaintext, hex_key, hex_iv)
      # Convert to ASCII
      pt = ascii_plaintext
      k  = Hex.to_ascii(hex_key)
      iv = Hex.to_ascii(hex_iv)
      
      # Split plaintext into blocks
      blocks = chunk(pt, BLOCK_SIZE_BYTES)

      # Create AES Function
      encrypter = build_encrypter(k)
      
      # Encrypt block by block
      # -> c[0] = E(k, m[0] ⨁ IV)
      # -> c[1] = E(k, m[1] ⨁ c[0])
      # -> .....
      encrypted_blocks = blocks.map do |b|
        b  = Ascii.bitwise_xor(b, iv)
        c  = encrypter.update(b) + encrypter.final
        iv = c
      end

      # Prepend IV
      hex_iv + Ascii.to_hex(encrypted_blocks.join(''))
    end
  end
end
