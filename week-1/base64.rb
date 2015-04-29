require_relative 'bytes'

module B64
  module_function

  def to_ascii(hex_s)
    [hex_s].pack('H*')
  end

  def to_base64(hex_s)
    [to_ascii(hex_s)].pack('m0')
  end

  def to_bytes(hex_s)
    to_ascii(hex_s).bytes
  end

  def bitwise_xor(hex_s1, hex_s2)
    Bytes.to_hex(
      Bytes.xor(
        to_bytes(hex_s1),
        to_bytes(hex_s2)
      )
    )
  end
end