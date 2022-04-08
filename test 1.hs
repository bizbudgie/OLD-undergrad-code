-- Abby Alperovich
-- Test 1 - Haskell
-- 9/13/2018
import Data.List

-- Referenced from Haskell Palooza slides
isqrt :: Integral i => i -> i
isqrt = floor . sqrt . fromIntegral

ip _ [] = True
ip n (x : xs)
 | n `mod` x == 0 = False
 | otherwise      = ip n xs

isPrime n = ip n [2..(isqrt n)]

everyOther m lst = [n | (i,n) <- zip [1..] lst, i `mod` m == 0]

-- list comprehension, output every other prime for given number of primes
test1Problem1 :: Int -> [Integer]
test1Problem1 n = take n (everyOther 2 [ a | a <- [1..], isPrime a])

fibonacci :: Int -> Int
fibonacci 0 = 1
fibonacci 1 = 2
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

-- recursion, given number of fibonacci terms
-- output fibs that end in 3 and are LT or ET n
-- fib starts with 1 and 2
test1Problem2 :: Int -> [Int]
test1Problem2 0 = []
test1Problem2 1 = []
test1Problem2 2 = []
test1Problem2 n =  [1,2] ++ test1Problem2 (n - 1)

-- creates list of prime factors to ensure at least 3 exist
has3Factors :: Int -> Bool
has3Factors n = if length [ y | y <- [1..n], n `mod` y == 0] == 3 || n ==4 then True else False

-- create list 1..n, either mult of 5, or have 3 factors
test1Problem3 :: Int -> [Int]
test1Problem3 n = [ x | x <- [1..n], (x `mod` 5 == 0) || has3Factors x]
