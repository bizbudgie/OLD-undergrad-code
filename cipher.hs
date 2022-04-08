--Abby Alperovich
--COP 4020 Fall 2018
--9/10/2018

import Data.Char
import Data.List

--Frequency table
table :: [Float]
table = [8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0, 6.1, 7.0,
        0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0,
        6.3, 9.1, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]

--Converts lower-case letter 'a' to 'z' to corresponding natural number 0 to 25
let2nat :: Char -> Int
let2nat n = (ord n) - 97

--Converts natural number 0 to 25 to lower-case letter 'a' to 'z'
nat2let :: Int -> Char
nat2let n = (chr (n + 97)) 

--Applies shift factor in range of 0 to 25 to a lower-case letter
shift :: Int -> Char -> Char
shift x y = if (let2nat y < 0 || let2nat y > 25) then y else nat2let(((let2nat y) + x) `mod` 26)

--Encodes a string using a given shift factor
encode :: Int -> String -> String
encode n st = map (shift n) st

--Inverse function of encode
decode :: Int -> String -> String
decode n st = map (shift (-n)) st

--Calculates number of lower-case letters in a string
lowers :: String -> Int
lowers = length . filter isLower

--Calculates the number of a given character in a string
count :: Char -> String -> Int
count ch st = (length . filter (== ch)) st

--Calculates percentage of one integer wrt another, result is float
-- (library function fromInt :: Int -> Float converts integer into corresponding float)
percent :: Int -> Int -> Float
percent x y =   100 * ( a / b )
  where a = fromIntegral x :: Float
        b = fromIntegral y :: Float

--Using lowers, count, and percent to return list of % frequencies of each lower-case letter in string
freqs :: String -> [Float]
freqs st = [ percent x (lowers st) | x <- a ] --percent count lowers
 where a = [ count y st | y <- ['a'..'z']]

--Rotates a list n places to the left, wrapping around at list start, assuming n is in range 0..list length
rotate :: Int -> [a] -> [a]
rotate n list = drop n (list ++ take n list)

--Calculates the chi square for a list of observed frequencies os wrt list of expected frequencies es (see pdf)
chisqr :: [Float] -> [Float] -> Float
chisqr os es = sum [ (((x - y)^2) / y) | (x, y) <- zip os es]

--Returns the first position, counting from zero, at which a value occurs in a list, assuming it occurs at least once
position :: Eq a => a -> [a] -> Int
position n list = head $ elemIndices n list

--attempts to decode a string by first calculating the letter frequencies in the string, then calculating chi square val of each rotation wrt to table of expected
--and finally using the position of the min val in the list as the shift factor to decode the original string
crack :: String -> String
crack st = decode (factor) st
 where factor = position (minimum chiTable) chiTable
       chiTable = [ chisqr (rotate x stTable) table | x <- [0..25] ]
       stTable = freqs st