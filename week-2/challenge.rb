require_relative 'aes/cbc'
require_relative 'aes/ctr'

# In this project you will implement two encryption/decryption systems, one using AES in CBC 
# mode and another using AES in counter mode (CTR). In both cases the 16-byte encryption IV is 
# chosen at random and is prepended to the ciphertext. For CBC encryption we use the PKCS5 
# padding scheme. 

# ============================================================================================
# CBC Mode
# ============================================================================================

cbc_key = '140b41b22a29beb4061bda66b6747e14'

cbc_c1 =  
"4ca00ff4c898d61e1edbf1800618fb2828a226d160dad07883d04e008a7897ee" +
"2e4b7465d5290d0c0e6c6822236e1daafb94ffe0c5da05d9476be028ad7c1d81"

cbc_c2 = 
"5b68629feb8606f9a6667670b75b38a5b4832d0f26e1ab7da33249de7d4afc48" +
"e713ac646ace36e872ad5fb8a512428a6e21364b0c374df45503473c5242a253"

cbc_p1 = AES::CBC.decrypt(cbc_c1, cbc_key)
cbc_p2 = AES::CBC.decrypt(cbc_c2, cbc_key)

puts "[+] CBC Mode\n[+] Decryption:"
puts " [1] #{cbc_p1}"
puts " [2] #{cbc_p2}"

check =  AES::CBC.encrypt(cbc_p1, cbc_key, cbc_c1[0,32]) == cbc_c1 &&
            AES::CBC.encrypt(cbc_p2, cbc_key, cbc_c2[0,32])  == cbc_c2

puts "[+] Encryption: #{check ? 'OK' : 'Error'}"


# ============================================================================================
# CTR Mode
# ============================================================================================

ctr_key = '36f18357be4dbd77f050515c73fcf9f2'

ctr_c1 = 
"69dda8455c7dd4254bf353b773304eec0ec7702330098ce7f7520d1cbbb20fc3" +
"88d1b0adb5054dbd7370849dbf0b88d393f252e764f1f5f7ad97ef79d59ce29f5f51eeca32eabedd9afa9329"

ctr_c2 = 
"770b80259ec33beb2561358a9f2dc617e46218c0a53cbeca695ae45faa8952aa" +
"0e311bde9d4e01726d3184c34451"

ctr_p1 = AES::CTR.decrypt(ctr_c1, ctr_key)
ctr_p2 = AES::CTR.decrypt(ctr_c2, ctr_key)

puts "[+] CTR Mode\n[+] Decryption:"
puts " [1] #{ctr_p1}"
puts " [2] #{ctr_p2}"

check =  AES::CTR.encrypt(ctr_p1, ctr_key, ctr_c1[0,32]) == ctr_c1 &&
            AES::CTR.encrypt(ctr_p2, ctr_key, ctr_c2[0,32])  == ctr_c2

puts "[+] Encryption: #{check ? 'OK' : 'Error'}"
