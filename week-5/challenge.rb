require 'gmp'

include GMP

# Your goal this week is to write a program to compute discrete log modulo a prime p. 
# Let g be some element in ℤ∗p and suppose you are given h in ℤ∗p such that h = g**x where 1 ≤ x ≤ 2**40. 
# Your goal is to find x. More precisely, the input to your program is p,g,h and the output is x. 

# In this project you will implement an algorithm that runs in time roughly 2*20 using a meet in the middle attack. 
# Let B = 2**20. Since x is less than B**2 we can write the unknown x base B as x = x_0 * B + x_1 
# where x_0, x_1 are in the range [0,B−1]. Then:

# --------------------- Equation ---------------------
#
#              h / g**x_1 = g**(B*x_0)      in ℤp
#
# ----------------------------------------------------

def divmod(a, b, m)
  #
  # b**-1 * a % m
  #
  (b.invert(m) * a) % m
end

p       = Z(13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084171)
g       = Z(11717829880366207009516117596335367088558084999998952205599979459063929499736583746670572176471460312928594829675428279466566527115212748467589894601965568)
h       = Z(3239475104050450443565264378728065788649097520952449527834792452971981976143292558073856937958553180532878928001494706097394108577585732452307673444020333)
B       = Z(2**20)
x_range = (0..B)

# First build a hash table of all possible values of the left hand side h / g**x_1 for x_1 = 0,1,…,2**20.
puts '[+] Building hash table'

hash_table = {}

x_range.each do |x_1| 
  lhs             = divmod(h, g.powmod(x_1, p), p)
  hash_table[lhs] = x_1
end

# Then for each value x_0 = 0,1,2,…,2**20 check if the right hand side g**(B*x_0) is in this hash table. 
# If so, then you have found a solution (x0, x1) from which you can compute the required x as x = x_0*B + x_1.
puts '[+] Checking hash values'

x_range.each do |x_0|
  rhs = g.powmod(x_0 * B, p)

  if hash_table.key?(rhs)

    x_1 = hash_table[rhs]

    puts '[+] Solution found:'
    puts "-> x_0 = #{x_0}"
    puts "-> x_1 = #{x_1}"
    puts "-> x   = #{(x_0 * B) + x_1}"
    break
  end

  puts "#{sprintf('%.2f%%', 100 * x_0 / B)}% complete..." if (x_0 % 10000 == 0)
end

