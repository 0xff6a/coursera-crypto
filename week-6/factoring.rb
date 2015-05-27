require 'bigdecimal'
require 'bigdecimal/math'

include BigMath

PRECISION = 350

def factorise(n, a)
  #
  # Given N = pq and A = (p + q)/2 return factors p,q
  #
  # BigDecimal, BigDecimal -> Array[Integer, Integer]
  #
  x = (a**2) - n
  x = x.sqrt(PRECISION)

  p,q = (a - x).to_i, (a + x).to_i
end

def factorise_1(n)
  #
  # Assumes |p − q| < 2N**1/4 thus A − √N < 1
  #
  # BigDecimal -> Array[Integer, Integer]
  #
  a = n.sqrt(PRECISION).ceil
  
  factorise(n, a)
end

def factorise_2(n)
  #
  # Assumes |p − q| < (2**11)*N**1/4 thus A − √N < 2**20
  #
  # BigDecimal -> Array[Integer, Integer]
  #
  range_start = n.sqrt(PRECISION).ceil
  range_end   = range_start + 2**20

  (range_start..range_end).each do |a| 
    p,q = factorise(n, a)

    return [p, q] if (p * q == n)

    puts "#{sprintf('%.2f%%', 100 * (a - range_start)  / (2**20))} complete..." if (a % 10000 == 0)
  end
end

def factorise_3(n)
  #
  # Assumes |3p − 2q| < N**1/4 thus for B = 3p + 2q , B − 2√(6N) < 1 / 8√6)
  # See maths.md for derivations
  #
  # BigDecimal -> Array[Integer, Integer]
  #
  b = ((6*n).sqrt(PRECISION) * 2).ceil

  x = b**2 - 24*n
  x = x.sqrt(PRECISION)

  p = (b - x) / 6
  q = (b + x) / 4

  [ p.to_i, q.to_i ]
end


