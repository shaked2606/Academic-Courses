import java.util.concurrent.ConcurrentHashMap;

public class sharedResources {

    private ConcurrentHashMap<String,LocalData> locals;
    private volatile int numOfWorkers;
    private boolean terminate;
    private Object lock;
    private Object terminateLock;

    private static class SingeltonsharedResources {
        private static sharedResources instance = new sharedResources();
    }

    private sharedResources() {
        this.locals = new ConcurrentHashMap<>();
        this.numOfWorkers = 0;
        this.lock = new Object();
        this.terminateLock = new Object();
        this.terminate = false;
    }

    public static sharedResources getInstance() {
        return SingeltonsharedResources.instance;
    }

    public ConcurrentHashMap<String, LocalData> getLocals() {
        return locals;
    }

    public int getNumOfWorkers() {
        return numOfWorkers;
    }

    public void setNumOfWorkers(int numOfWorkers) {
        this.numOfWorkers = numOfWorkers;
    }

    public Object getLock() {
        return lock;
    }

    public boolean isTerminate() {
        return terminate;
    }

    public void setTerminate(boolean terminate) {
        this.terminate = terminate;
    }

    public Object getTerminateLock() {
        return terminateLock;
    }

}
