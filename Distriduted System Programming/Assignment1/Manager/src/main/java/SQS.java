import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public class SQS {
    private AmazonSQS sqs;

    public SQS(){
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
        AmazonSQS sqs = AmazonSQSClientBuilder.standard()
                .withCredentials(credentialsProvider)
                .withRegion(Regions.US_EAST_1)
                .build();
        this.sqs = sqs;
    }

    public String create(String queueName, String ReceiveMessageWaitTimeSeconds, String VisibilityTimeout) {
        // Create a queue
        String myQueueUrl = "";
        try {
            System.out.println("Creating a new SQS queue called "+ queueName);
            CreateQueueRequest createQueueRequest = new CreateQueueRequest(queueName + UUID.randomUUID()).addAttributesEntry(QueueAttributeName.ReceiveMessageWaitTimeSeconds.toString(),ReceiveMessageWaitTimeSeconds).addAttributesEntry(QueueAttributeName.VisibilityTimeout.toString(),VisibilityTimeout);
            CreateQueueResult result_queue = sqs.createQueue(createQueueRequest);
            myQueueUrl = result_queue.getQueueUrl();
            System.out.println("Creating Queue Complete Successfully!");
            return myQueueUrl;
        }
        catch (AmazonServiceException ase) {
            sqsCatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            sqsCatchClientException(ace);
        }
        return myQueueUrl;
    }

    public void sendMessageToSQS(String queueUrl, String messageBody){
        try {
            System.out.println("Sending a message to "+ queueUrl);
            System.out.println("Message Body is: "+messageBody);
            sqs.sendMessage(new SendMessageRequest(queueUrl, messageBody));
            System.out.println("Sending Message Complete Successfully!");
        }
        catch (AmazonServiceException ase) {
            sqsCatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            sqsCatchClientException(ace);
        }
    }

    public String getQueueUrl(String queueName){
        String url = "";
        for (String queueUrl : sqs.listQueues().getQueueUrls()) {
            if(queueUrl.contains(queueName)){
                url = queueUrl;
            }
        }
        return url;
    }

    public void listingQueues() {
        System.out.println("Listing all queues in your account");
        for (String queueUrl : sqs.listQueues().getQueueUrls()) {
            System.out.println("  QueueUrl: " + queueUrl);
        }
        System.out.println("listing all Queues Complete Successfully!");
        System.out.println();
    }

    public List<Message> receiveMessages(String queueUrl, int setWaitTimeSeconds){
        // Receive messages
        List<Message> messages = null;
        System.out.println("Receiving messages from "+ queueUrl);
        ReceiveMessageRequest receiveMessageRequest = new ReceiveMessageRequest(queueUrl);
        receiveMessageRequest.setWaitTimeSeconds(setWaitTimeSeconds);
        ReceiveMessageResult result  = sqs.receiveMessage(receiveMessageRequest);

        if(result != null){
            messages = result.getMessages();
        }

        for (Message message : messages) {
            System.out.println("  Message");
            System.out.println("    MessageId:     " + message.getMessageId());
            System.out.println("    ReceiptHandle: " + message.getReceiptHandle());
            System.out.println("    MD5OfBody:     " + message.getMD5OfBody());
            System.out.println("    Body:          " + message.getBody());
            for (Map.Entry<String, String> entry : message.getAttributes().entrySet()) {
                System.out.println("  Attribute");
                System.out.println("    Name:  " + entry.getKey());
                System.out.println("    Value: " + entry.getValue());
            }
        }
        System.out.println();
        System.out.println("Receiving all Messages Complete Successfully!");
        return messages;
    }

    public void deleteMessages(List<Message> messages, String queueUrl) {
        System.out.println("Deleting a messages from queue: "+ queueUrl);
        for(Message message:messages) {
            String messageReceiptHandle = messages.get(0).getReceiptHandle();
            sqs.deleteMessage(new DeleteMessageRequest(queueUrl, messageReceiptHandle));
            System.out.println("Delete message "+ message.getMessageId() +" Complete Successfully!");
        }
        System.out.println("Delete messages Complete Successfully!");
    }

    public void deleteMessageByReceipt(String queueUrl, String messageReceiptHandle) {
        System.out.println("Deleting a message from queue: "+ queueUrl);
        sqs.deleteMessage(new DeleteMessageRequest(queueUrl, messageReceiptHandle));
        System.out.println("Delete message Complete Successfully!");
    }

    public void deleteQueue(String queueUrl){
        System.out.println("Deleting the queue named: "+ queueUrl);
        sqs.deleteQueue(new DeleteQueueRequest(queueUrl));
        System.out.println("Delete queue Complete Successfully!");
    }

    public AmazonSQS getSqs() {
        return sqs;
    }

    public void sqsCatchServiceException(AmazonServiceException ase) {
        System.out.println("Caught an AmazonServiceException, which means your request made it " +
                "to Amazon SQS, but was rejected with an error response for some reason.");
        System.out.println("Error Message:    " + ase.getMessage());
        System.out.println("HTTP Status Code: " + ase.getStatusCode());
        System.out.println("AWS Error Code:   " + ase.getErrorCode());
        System.out.println("Error Type:       " + ase.getErrorType());
        System.out.println("Request ID:       " + ase.getRequestId());
    }

    public void sqsCatchClientException(AmazonClientException ace) {
        System.out.println("Caught an AmazonClientException, which means the client encountered " +
                "a serious internal problem while trying to communicate with SQS, such as not " +
                "being able to access the network.");
        System.out.println("Error Message: " + ace.getMessage());
    }
}
