module Ascii
  module_function

  def to_hex(ascii_s)
    ascii_s.unpack('H*')[0]
  end

  def to_bin(ascii_s)
    ascii_s.unpack('B*')[0]
  end

  def bitwise_xor(s1, s2)
    Bytes.to_ascii(
      Bytes.xor(
        s1.bytes,
        s2.bytes
      )
    )
  end
end