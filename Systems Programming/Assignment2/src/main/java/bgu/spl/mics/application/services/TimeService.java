package bgu.spl.mics.application.services;

import bgu.spl.mics.MicroService;
import bgu.spl.mics.application.messages.TerminateBroadcast;
import bgu.spl.mics.application.messages.TickBroadcast;
import bgu.spl.mics.application.passiveObjects.Inventory;

import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.CountDownLatch;

/**
 * TimeService is the global system timer There is only one instance of this micro-service.
 * It keeps track of the amount of ticks passed since initialization and notifies
 * all other micro-services about the current time tick using {@link Tick Broadcast}.
 * This class may not hold references for objects which it is not responsible for:
 * {@link ResourcesHolder}, {@link MoneyRegister}, {@link Inventory}.
 * 
 * You can add private fields and public methods to this class.
 * You MAY change constructor signatures and even add new public constructors.
 */
public class TimeService extends MicroService{

	private int speed;
	private int duration;
	private Timer timer;
	private int currTick;
	private boolean isFinished;
	private CountDownLatch terminateCount; 
	
	
	public TimeService(int speed, int duration, CountDownLatch terminateCount) {
		super("TimeService");
		this.speed = speed;
		this.duration = duration;
		this.timer = new Timer();
		this.currTick=1;
		this.isFinished = false;
		this.terminateCount = terminateCount;
	}

	
	@Override
	protected void initialize() {
		TimerTask task=new TimerTask() {
			@Override
			public void run() {
				if(currTick<duration) {
					sendBroadcast(new TickBroadcast(currTick));
					currTick++;
				}
				else {       // last tick
					sendBroadcast(new TerminateBroadcast());  
					this.cancel();
					isFinished =true;
				}
			}
		};
		
		timer.scheduleAtFixedRate(task, 0, speed);   // start timer
		
		// wait timer will finish
		try {
			Thread.sleep(speed*duration);
		} catch (InterruptedException e1) {
		}
		
		while (!isFinished) {
			try {
				Thread.sleep(speed);
			} catch (InterruptedException e) {
			}
		}
		
		terminate();
		terminateCount.countDown();		
	}
}
