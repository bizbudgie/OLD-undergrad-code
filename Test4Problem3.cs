// Abby Alperovich
// COP 4020 Fall 2018

using System;
using System.Threading;

public class TestProblem3 {
    delegate void CalcDelegate(int startingIndex, int reps);
    static int[] data = new int[10000000];

    static int numThreads = 4;

    static void calc(int startingIndex, int reps) {
        // assign into the data array from startingIndex to
        // startingIndex + reps the following:
        // Math.Atan(i) * Math.Acos(i) * Math.Cos(i) * Math.Sin(i);
        for (int i = startingIndex; i < startingIndex + reps; i++) {
            data[i] = (int) (Math.Atan(i) * Math.Acos(i) * Math.Cos(i) * Math.Sin(i));
        }
    }

    static void calcThread(object o) {
        job j = (job) o;
        calc(j.startingIndex, j.reps);
    }

    static void Main(string[] args) {
        //start time
        DateTime dt = DateTime.Now;
        calc(0, data.Length);
        //finish time
        TimeSpan ts = DateTime.Now - dt;
        Console.WriteLine("Sequentially, calc takes {0} milliseconds to run.", ts.TotalMilliseconds);

        //keeping track of threads
        Thread[] threads = new Thread[numThreads];
        //keep track of the threads' jobs
        job[] jobs = new job[numThreads];
        for (int i = 0; i < numThreads; i++) {
            Thread thrd = new Thread(calcThread);
            threads[i] = thrd;
            job j = new job() {
                startingIndex = (data.Length / numThreads) * i,
                reps = data.Length / numThreads
            };
            jobs[i] = j;
        }
        //starting the "timer" right before starting the threads
        dt = DateTime.Now;
        for (int i = 0; i < numThreads; i++) {
            threads[i].Start(jobs[i]);
        }
        //ensuring each thread is done
        for (int i = 0; i < numThreads; i++) {
            //waiting for each thread to finish
            while (threads[i].IsAlive) { }
        }
        ts = DateTime.Now - dt;
        Console.WriteLine("Multithreaded, calc takes {0} milliseconds to run.", ts.TotalMilliseconds);
        Console.ReadLine();
    }
}

//simple job class describes what each thread needs to calculate
class job { public int startingIndex, reps; }