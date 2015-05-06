#!/usr/bin/env ruby 

require 'digest'

require_relative '../utils/ascii'

BLOCK_SIZE = 1024

unless ARGV.size.between?(1, 2) 
  puts '[+] File Stream SHA256 Authenticator 1.0'
  puts "[+] Usage #{__FILE__} <file> <optional: hash to verify>"
  exit 1
else
  filepath     = ARGV[0]
  check_string = ARGV[1]
end

# Read binary file
# Break file into blocks of 1024 bytes
blocks = []

File.open(filepath, 'rb') do |io| 
  data = io.read(BLOCK_SIZE)
  
  while data do
    blocks << data
    data = io.read(BLOCK_SIZE)
  end
end

# Hash the last block
h = Digest::SHA256.digest(blocks.pop)

# Starting from the next to last block
# -> calculate the hash of block
# -> append to previous block
blocks.reverse.each do |block|
  h = Digest::SHA256.digest(block + h)
end

# Hex encode the final hash as out output
h0 = Ascii.to_hex(h)

if check_string
  # We are in check-mode return true or false
  puts "[+] String match? #{h0 == check_string}"
else
  # Return the last hash value (hex-encoded)
  puts "[+] h0: #{h0}"
end
