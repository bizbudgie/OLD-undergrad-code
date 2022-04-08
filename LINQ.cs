// Abby Alperovich
// COP 4020 Fall 2018

using System;
using System.Collections.Generic;
using System.Linq;

public class Problem1
{
    public static IEnumerable<int> myFilter(IEnumerable<int> input)
    {
        return input.Where(n => !(n > 50 && n % 5 == 0)).Select(n => n * n * n).Where(n => n % 2 == 1);
    }

    static void Main(string[] args)
    {
        Random rnd = new Random(5); // Important to seed with 5 for repeatability.
        var listForProblem =
          Enumerable.Range(1, 100).Select(i => rnd.Next() % 101);
        var answer = Problem1.myFilter(listForProblem);
        foreach (int i in answer)
        {
            Console.WriteLine(i);
        }
        Console.ReadLine();
    }
}