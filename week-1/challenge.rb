require_relative '../utils/hex'
require_relative '../utils/ascii'
require_relative '../utils/bytes'

ciphertext_1 =
'315c4eeaa8b5f8aaf9174145bf43e1784b8fa00dc71d885a804e5ee9fa40b16349c146fb778cdf2d3aff021d' +
'fff5b403b510d0d0455468aeb98622b137dae857553ccd8883a7bc37520e06e515d22c954eba5025b8cc57ee' +
'59418ce7dc6bc41556bdb36bbca3e8774301fbcaa3b83b220809560987815f65286764703de0f3d524400a19b' +
'159610b11ef3e'

ciphertext_2 = 
'234c02ecbbfbafa3ed18510abd11fa724fcda2018a1a8342cf064bbde548b12b07df44ba7191d9606ef4081f' +
'fde5ad46a5069d9f7f543bedb9c861bf29c7e205132eda9382b0bc2c5c4b45f919cf3a9f1cb74151f6d551f4' +
'480c82b2cb24cc5b028aa76eb7b4ab24171ab3cdadb8356f'

ciphertext_3 = 
'32510ba9a7b2bba9b8005d43a304b5714cc0bb0c8a34884dd91304b8ad40b62b07df44ba6e9d8a2368e51d04' +
'e0e7b207b70b9b8261112bacb6c866a232dfe257527dc29398f5f3251a0d47e503c66e935de81230b59b7afb' +
'5f41afa8d661cb'

ciphertext_4 =
'32510ba9aab2a8a4fd06414fb517b5605cc0aa0dc91a8908c2064ba8ad5ea06a029056f47a8ad3306ef5021e' +
'afe1ac01a81197847a5c68a1b78769a37bc8f4575432c198ccb4ef63590256e305cd3a9544ee4160ead45aef' +
'520489e7da7d835402bca670bda8eb775200b8dabbba246b130f040d8ec6447e2c767f3d30ed81ea2e4c1404' +
'e1315a1010e7229be6636aaa'

ciphertext_5 =
'3f561ba9adb4b6ebec54424ba317b564418fac0dd35f8c08d31a1fe9e24fe56808c213f17c81d9607cee021d' +
'afe1e001b21ade877a5e68bea88d61b93ac5ee0d562e8e9582f5ef375f0a4ae20ed86e935de81230b59b73fb' +
'4302cd95d770c65b40aaa065f2a5e33a5a0bb5dcaba43722130f042f8ec85b7c2070'

ciphertext_6 =
'32510bfbacfbb9befd54415da243e1695ecabd58c519cd4bd2061bbde24eb76a19d84aba34d8de287be84d07' +
'e7e9a30ee714979c7e1123a8bd9822a33ecaf512472e8e8f8db3f9635c1949e640c621854eba0d79eccf52ff' +
'111284b4cc61d11902aebc66f2b2e436434eacc0aba938220b084800c2ca4e693522643573b2c4ce35050b0c' +
'f774201f0fe52ac9f26d71b6cf61a711cc229f77ace7aa88a2f19983122b11be87a59c355d25f8e4'

ciphertext_7 =
'32510bfbacfbb9befd54415da243e1695ecabd58c519cd4bd90f1fa6ea5ba47b01c909ba7696cf606ef40c04' +
'afe1ac0aa8148dd066592ded9f8774b529c7ea125d298e8883f5e9305f4b44f915cb2bd05af51373fd9b4af5' +
'11039fa2d96f83414aaaf261bda2e97b170fb5cce2a53e675c154c0d9681596934777e2275b381ce2e40582a' +
'fe67650b13e72287ff2270abcf73bb028932836fbdecfecee0a3b894473c1bbeb6b4913a536ce4f9b13f1eff' +
'f71ea313c8661dd9a4ce'

ciphertext_8 =
'315c4eeaa8b5f8bffd11155ea506b56041c6a00c8a08854dd21a4bbde54ce56801d943ba708b8a3574f40c00' +
'fff9e00fa1439fd0654327a3bfc860b92f89ee04132ecb9298f5fd2d5e4b45e40ecc3b9d59e9417df7c95bba' +
'410e9aa2ca24c5474da2f276baa3ac325918b2daada43d6712150441c2e04f6565517f317da9d3'

ciphertext_9 =
'271946f9bbb2aeadec111841a81abc300ecaa01bd8069d5cc91005e9fe4aad6e04d513e96d99de2569bc5e50' +
'eeeca709b50a8a987f4264edb6896fb537d0a716132ddc938fb0f836480e06ed0fcd6e9759f40462f9cf57f4' +
'564186a2c1778f1543efa270bda5e933421cbe88a4a52222190f471e9bd15f652b653b7071aec59a2705081f' +
'fe72651d08f822c9ed6d76e48b63ab15d0208573a7eef027'

ciphertext_10 =
'466d06ece998b7a2fb1d464fed2ced7641ddaa3cc31c9941cf110abbf409ed39598005b3399ccfafb61d0315' +
'fca0a314be138a9f32503bedac8067f03adbf3575c3b8edc9ba7f537530541ab0f9f3cd04ff50d66f1d559ba' +
'520e89a2cb2a83'

target =
'32510ba9babebbbefd001547a810e67149caee11d945cd7fc81a05e9f85aac650e9052ba6a8cd8257bf14d13e' +
'6f0a803b54fde9e77472dbff89d71b57bddef121336cb85ccb8f3315f4b52e301d16e9f52f904'

ciphertexts = 
[
  ciphertext_1,
  ciphertext_2,
  ciphertext_3,
  ciphertext_4,
  ciphertext_5,
  ciphertext_6,
  ciphertext_7,
  ciphertext_8,
  ciphertext_9,
  ciphertext_10
]

def upper?(char)
  ('A'..'Z').to_a.include?(char)
end

# XOR target with each of the other cipher texts
rebased_cts   = ciphertexts.map { |ct| ct[0, target.size] }
m_xor_ct      = rebased_cts.map { |ct| Hex.bitwise_xor(target, ct) }
ascii_xor_res = m_xor_ct.map { |ct| Hex.to_ascii(ct) }

# Initialize our guess
guess         = '-' * (target.size / 2)
# Look for uppercase chars (we assume message was entirely lower case)
#
# if we have an uppercase char it means that one character was a lowercase char and the other a space
# as we have multiple texts we can check - if all xors have an uppercase it is a space in the target, \
# else its a space in the given ciphertext
ascii_xor_res.each do |xor_res| 
  xor_res.chars.each_with_index do |char, i|
    if upper?(char)
      # if most have an uppercase at this index that means the target has a space
      if  ascii_xor_res.count { |s| upper?(s[i]) } > (ciphertexts.count / 2)
        guess[i] = ' '
      # else it means the target has the lower case letter 
      else
        guess[i] = char.downcase
      end
    end
  end
end 

# Guess the key
key = Hex.bitwise_xor(Ascii.to_hex(guess), target)

# Try and use the key on all the other ciphertests
puts '[+] Initial Guesses'
puts rebased_cts.map.with_index { |ct, i| "[#{i}] #{Hex.to_ascii(Hex.bitwise_xor(key, ct))}" }
puts '[+] End'
#
# [+] Initial Guesses
# [0] .e(can aactor }he num!  5 wi|h0qc2ntum computer:. We,can also factor the number 1
# [1] <uder whuld prfbably &noh tha| ~oashis theorem b,come a corner stone of crypto - 
# [2] -hm nicb thing)aboutey}oq i{ ~oaswe cryptograp!ers oan drive a lot of fancy cars
# [3] -hm cipoertext)produc&dZbh a wma{ s=cryption algo;ithm,looks as good as ciphertext 
# [4]  o} don t want)to buycaZstt of(cqr68eys from a gu0 who,specializes in stealing cars
# [5] -hmre aue two }ypes o% rhptogza`hos- that which >ill geep secrets safe from your l
# [6] -hmre aue two }ypes o% yatogripxy,sone that allo>s thi Government to use brute for
# [7] .e(can tee the)point 4hrt the(cxifsis unhappy ifia wrcng bit is sent and consumes 
# [8] 8  privfte-key   encr:pi~n sc`e}e6 tates 3 algor thms  namely a procedure for gene
# [9] YT`e Coicise OqfordDi toary  2 0 z deﬁnes cry9to a the art of  writing o r sol

#
# Crib dragging
#
loop do
  puts '[+] Choose a ciphertext id to guess:'
  id = gets.chomp

  puts '[+] Input your guess:'
  guess = gets.chomp

  puts '[+] All ciphers based off your guess:'
  key_guess = Hex.bitwise_xor(Ascii.to_hex(guess), ciphertexts[id.to_i])
  puts rebased_cts.map.with_index { |ct, i| " [#{i}] #{Hex.to_ascii(Hex.bitwise_xor(key_guess, ct))}" }

  puts '[+] Choose characters keep e.g 5:15 or x to exit'
  input = gets.chomp

  if input == 'x'
    key = key_guess

    puts '[+] Secret Message'
    puts '[+] ' + Hex.to_ascii(Hex.bitwise_xor(key, target))

    break
  else
    first, last      = input.split(':').map{ |n| n.to_i * 2 }
    key[first, last] = key_guess[first, last]
    
    puts rebased_cts.map.with_index { |ct, i| " [#{i}] #{Hex.to_ascii(Hex.bitwise_xor(key, ct))}" }
  end
end



