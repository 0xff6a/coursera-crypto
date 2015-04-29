module Bytes
  module_function

  def xor(buffer_1, buffer_2)
    buffer_1
      .map
      .with_index { |byte, i| byte ^ buffer_2[i] }
  end

  def to_hex(buffer)
    to_ascii(buffer)
      .unpack('H*')[0]
  end

  def to_bin(buffer)
    buffer
      .map { |b| b.to_s(2) } 
      .join
  end

  def to_ascii(buffer)
    buffer
      .map(&:chr)
      .join
  end
end