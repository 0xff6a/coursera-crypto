require_relative '../utils/hex'
require_relative '../utils/ascii'

module AES
  extend self

  BLOCK_SIZE_BYTES = 16

  def blocks(hex_s)
    chunk(hex_s, BLOCK_SIZE_BYTES * 2)
  end
  
  private

  def chunk(string, size)
    string.scan(/.{1,#{size}}/)
  end

  def build_decrypter(key)
    build_cipher(:decrypt, key)
  end

  def build_encrypter(key)
    build_cipher(:encrypt, key)
  end

  def build_cipher(type, key)
    cipher         =  OpenSSL::Cipher::AES128.new(:ECB)
    cipher.public_send(type)
    cipher.key     = key
    cipher.padding = 0
    cipher
  end
end