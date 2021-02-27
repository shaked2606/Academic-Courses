import com.amazonaws.services.sqs.model.Message;

import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

public class WorkerToLocalTask implements Runnable {

    private sharedResources resources;
    public WorkerToLocalTask() {
        this.resources = sharedResources.getInstance();
    }

    @Override
    public void run() {
        SQS sqs = new SQS();
        S3 s3 = new S3();
        while(sqs.getQueueUrl("workers-to-manager").equals("")){}
        String workersToManQueueUrl = sqs.getQueueUrl("workers-to-manager");

        while(!this.resources.isTerminate()){
            List<Message> messagesFromWorkers = sqs.receiveMessages(workersToManQueueUrl, 1);
            processMessageFromWorkers(this.resources.getLocals(), sqs, s3, workersToManQueueUrl, messagesFromWorkers);
        }
    }

    private void processMessageFromWorkers(ConcurrentHashMap<String, LocalData> locals, SQS sqs, S3 s3, String workersToManQueueUrl, List<Message> messagesFromWorkers) {
        for(Message message:messagesFromWorkers){
                String messageReceipt = message.getReceiptHandle();
                sqs.getSqs().changeMessageVisibility(workersToManQueueUrl, messageReceipt, 30);

                addMessageToSummery(locals, message);

                sqs.deleteMessageByReceipt(workersToManQueueUrl, messageReceipt);
        }
    }

    private LocalData addMessageToSummery(ConcurrentHashMap<String, LocalData> locals, Message message) {
        String messageBody = message.getBody();

        String[] lines = messageBody.split("\n",2);

        LocalData currLocal = locals.get(lines[0]);   //Manager To Local Queue URL

        String output = lines[1];
        currLocal.addOutput(output);
        return currLocal;
    }
}
