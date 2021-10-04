import com.amazonaws.services.ec2.model.TerminateInstancesRequest;
import com.amazonaws.util.EC2MetadataUtils;
import com.sun.xml.internal.ws.util.MetadataUtil;

import java.util.ArrayList;
import java.util.List;

public class Manager {
    public static void main(String[] args) {
        sharedResources resources = sharedResources.getInstance();
        String instanceManagerId = EC2MetadataUtils.getInstanceId();
        SQS sqs = new SQS();
        EC2 ec2 = new EC2();

        Thread MainThread = new Thread(new MainTask());
        MainThread.start();

        Thread workerToLocalThread = new Thread(new WorkerToLocalTask());
        workerToLocalThread.start();

        synchronized (resources.getTerminateLock()) {
            try {
                resources.getTerminateLock().wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        /*  delete queues FROM and TO workers  and locals-to-manager queue */

        while(sqs.getQueueUrl("manager-to-workers").equals("")) {}
        while(sqs.getQueueUrl("workers-to-manager").equals("")) {}
        while(sqs.getQueueUrl("locals-to-manager").equals("")) {}

        String manToWorkersQueueUrl = sqs.getQueueUrl("manager-to-workers");
        String workersToManQueueUrl = sqs.getQueueUrl("workers-to-manager");
        String LocalsToManagerQueueUrl = sqs.getQueueUrl("locals-to-manager");

        sqs.deleteQueue(manToWorkersQueueUrl);
        sqs.deleteQueue(workersToManQueueUrl);
        sqs.deleteQueue(LocalsToManagerQueueUrl);

        /*  terminate manager at last   */
        List<String> terminateList = new ArrayList<>();
        terminateList.add(instanceManagerId);
        TerminateInstancesRequest terminateRequestForManager = new TerminateInstancesRequest(terminateList);
        ec2.getEc2().terminateInstances(terminateRequestForManager);
    }
}