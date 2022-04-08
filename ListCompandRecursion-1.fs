module ListComprehensions =
    let multipleOf5 n = [ for x in 1..n do if x % 5 = 0 then yield x ]

    let multipleOf7Or11 n = [ for x in 1..n do if x % 7 = 0 || x % 11 = 0 then yield x ]

    let multipleOf3And7 n = [ for x in 1..n do if x % 3 = 0 && x % 7 = 0 then yield x ]

module Recursion = 
    let isPrime n =
        if n = 0 || n = 1 then false else
        let list = [2.. ( n / 2)] in
        let rec ip n list =
            if list = [] then true
            elif n % list.Head = 0 then false 
            else ip n list.Tail
        ip n list
            
    let rec factorial n =
        if n = 0 then 1 else n * factorial (n - 1)

    let rec fibonacci n =
        if n = 0 then 1
        elif n = 1 then 1
        else fibonacci (n - 1) + fibonacci (n - 2)