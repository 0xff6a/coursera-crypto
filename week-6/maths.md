Wish to show that √(6N) is close to (3p+2q)/2. As before let B = (3p+2q)/2 and consider B<sup>2</sup> - 6N:

=> ((3p+2q)/2)<sup>2</sup> - 6N    
=>  (9p<sup>2</sup> + 4q<sup>2</sup> + 12pq) / 4 - 6N    
=> (9p<sup>2</sup> + 4q<sup>2</sup> + 12pq) / 4 - 24pq / 4    
=> (3p - 2q)<sup>2</sup> / 4

Now consider B - √(6N):    
=> (B - √(6N))(B + √(6N) / B + √(6N))     
=> B<sup>2</sup>  - √(6N) / B + √(6N)    
=> ((3p - 2q)<sup>2</sup> / 4) / B + √(6N)    
Now √(6N) < B so LHS:    
< ((3p - 2q)<sup>2</sup> / 4) / 2√(6N)   
From our initial assumption (3p - 2q)<sup>2</sup>  < N<sup>1/2</sup> so:    
< √N / 8√(6N)
< 1 / 8√6

So as in question(1) we can obtain B using ceil(sqrt(6N))!

Previously for A = (p+q)/2 we know there was an x such that p = A-x and q = A+x. Replacing p -> 6p and q -> 4q we obtain:    
(1) 6p = B - x    
(2) 4q = B + x    
(1) - (2) => x = 2q - 3p which must be an Integer    
(1) * (2) => 24pq = B<sup>2</sup> - x<sup>2</sup>   
=> x = √(B<sup>2</sup> - 24N)    
And thus we obtain:    
p = (B - x) / 6     
q = (B + x) / 4
