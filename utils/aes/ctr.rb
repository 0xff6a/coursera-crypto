require 'openssl'

require_relative '../aes'

module AES
  module CTR
    module_function
    extend AES

    def decrypt(hex_ciphertext, hex_key)
      # Convert to ASCII
      ct, k = Hex.to_ascii(hex_ciphertext), Hex.to_ascii(hex_key)
      
      # Split ciphertext into blocks
      blocks = chunk(ct, BLOCK_SIZE_BYTES)
     
      # Extract initial IV
      iv = blocks.shift

      # Create AES Function - Always encrypt!
      encrypter = build_encrypter(k)
      
      # Decrypt block by block
      # -> m[0] = F(k, IV) ⨁ c[0]
      # -> m[1] = F(k, IV + 1) ⨁ c[1]
      # -> .....
      decrypted_blocks = blocks.map do |b|
        f_k_iv = encrypter.update(iv) + encrypter.final
        iv     = increment(iv)
       
        Ascii.bitwise_xor(f_k_iv[0, b.size], b)
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
      # -> c[0] = F(k, IV) ⨁ m[0]
      # -> c[1] = F(k, IV + 1) ⨁ m[1]
      # -> .....
      encrypted_blocks = blocks.map do |b|
        f_k_iv = encrypter.update(iv) + encrypter.final
        m      = Ascii.bitwise_xor(f_k_iv[0, b.size], b)
        iv     = increment(iv)
        m
      end

      # Prepend IV
      hex_iv + Ascii.to_hex(encrypted_blocks.join(''))
    end

    private_class_method

    def increment(ascii_iv)
      hex_iv = Ascii.to_hex(ascii_iv)
      hex_iv = hex_iv.hex + 1
      hex_iv = hex_iv.to_s(16)

      Hex.to_ascii(hex_iv)
    end
  end
end
