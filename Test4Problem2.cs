// Abby Alperovich
// COP 4020 Fall 2018
// Test 4 Problem 1
/*
	Implement a function called merge that does the following:
	*	Takes three sequences of numbers from 1 to 15
	*	Merge the list with members that adhere to the following requirements
		*	Any multiple of 3
		*	Is a member of all three lists

*/

using System;
using System.Collections.Generic;
using System.Linq;

public class TestProblem2 {
	public static IEnumerable<int> merge(IEnumerable<int> input1,
	 IEnumerable<int> input2, IEnumerable<int> input3) {
		return input1.Concat(input2).Concat(input3).Where(n => n % 3 == 0).Where(n => input1.Contains(n) && input2.Contains(n) && input3.Contains(n));
	}

	static void Main(string[] args) {
		Random rnd = new Random(); //try using seed: 2; it should output 15 and 3
		var list1 = Enumerable.Range(1, 10).Select(i => (rnd.Next() % 15) + 1);
		var list2 = Enumerable.Range(1, 10).Select(i => (rnd.Next() % 15) + 1);
		var list3 = Enumerable.Range(1, 10).Select(i => (rnd.Next() % 15) + 1);
		//Console.WriteLine("list 1: " + String.Join(", ", list1));
		//Console.WriteLine("list 2: " + String.Join(", ", list2));
		//Console.WriteLine("list 3: " + String.Join(", ", list3));

		var answer = TestProblem2.merge(list1, list2, list3);
		foreach (int i in answer) {
			Console.WriteLine(i);
		}
		Console.ReadLine();
	}
}
