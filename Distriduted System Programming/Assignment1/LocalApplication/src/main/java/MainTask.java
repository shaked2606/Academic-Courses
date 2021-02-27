import com.amazonaws.services.ec2.model.*;
import com.amazonaws.services.sqs.model.Message;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MainTask implements Runnable{

    private SQS sqs;
    private EC2 ec2;
    private String LocalsToManagerQueueUrl;
    private String manToWorkersQueueUrl;
    private String workersToManQueueUrl;
    private boolean terminate;
    private sharedResources resources;

    public MainTask(){
        this.terminate = false;
        this.sqs = new SQS();
        this.ec2 = new EC2();
        /*  waiting for Manager queue to be active */
        while(sqs.getQueueUrl("locals-to-manager").equals("")) {}
        LocalsToManagerQueueUrl = this.sqs.getQueueUrl("locals-to-manager");

        /* creates 2 queues - FROM and TO Workers   */
        this.manToWorkersQueueUrl = sqs.create("manager-to-workers", "1", "1800");
        this.workersToManQueueUrl = sqs.create("workers-to-manager", "1", "30");

        this.resources = sharedResources.getInstance();
    }

    @Override
    public void run() {
        ExecutorService pool = Executors.newFixedThreadPool(5);

        while(!this.resources.isTerminate()) {
            List<Message> messagesFromLocals = this.sqs.receiveMessages(LocalsToManagerQueueUrl, 1);
            for(Message message:messagesFromLocals){
                if(message.getBody().equals("Terminate")){
                    while(!this.resources.getLocals().isEmpty()){}

                    List<String> instances = new LinkedList<>();
                    DescribeInstancesRequest request = new DescribeInstancesRequest();
                    DescribeInstancesResult response = this.ec2.getEc2().describeInstances(request);
                    for(Reservation reservation : response.getReservations()) {
                        for (Instance instance : reservation.getInstances()) {
                            if (!instance.getTags().get(0).getValue().equals("manager")) {
                                instances.add(instance.getInstanceId());
                            }
                        }
                    }

                    TerminateInstancesRequest terminateRequest = new TerminateInstancesRequest(instances);
                    this.ec2.getEc2().terminateInstances(terminateRequest);

                    pool.shutdown();

                    this.resources.setTerminate(true);
                    synchronized (resources.getTerminateLock()) {
                        resources.getTerminateLock().notify();
                    }
                }
                else {
                    Runnable miniThread = new MiniTask(message, this.manToWorkersQueueUrl);
                    pool.execute(miniThread);
                    sqs.deleteMessageByReceipt(LocalsToManagerQueueUrl, message.getReceiptHandle());
                }
            }
        }
    }
}
