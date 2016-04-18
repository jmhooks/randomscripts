package test;

import java.util.Random;

public class TestThread implements Runnable {

	private Thread t;
	private int timer;

	public void run() {
		Random rand = new Random();
		for (int i = 0; i <= 5; i++) {
			try {
				int time = rand.nextInt(500) + 500;
				timer += time;
				System.out.println(i + " - " + t.getName() + " - " + timer + "ms");
				Thread.sleep(time);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

	public void begin() {
		t = new Thread(this);
		t.start();
	}

	public static void main(String[] args) {
		TestThread test1 = new TestThread();
		TestThread test2 = new TestThread();
		TestThread test3 = new TestThread();
		TestThread test4 = new TestThread();
		TestThread test5 = new TestThread();
		test1.begin();
		test2.begin();
		test3.begin();
		test4.begin();
		test5.begin();
	}
}
