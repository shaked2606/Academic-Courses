import com.amazonaws.services.ec2.model.*;
import com.amazonaws.services.sqs.model.Message;
import org.apache.commons.codec.binary.Base64;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;


public class MiniTask implements Runnable{
    private LocalData local;
    private S3 s3;
    private SQS sqs;
    private EC2 ec2;
    private String manToWorkersQueueUrl;
    private sharedResources resources;

    public MiniTask(Message message, String manToWorkersQueueUrl) {
        this.manToWorkersQueueUrl = manToWorkersQueueUrl;
        this.s3 = new S3();
        this.sqs = new SQS();
        this.ec2 = new EC2();
        this.resources = sharedResources.getInstance();
        this.local = processMessageFromLocal(message);
        this.resources.getLocals().put(this.local.getQueueUrlToLocal(), this.local);
    }


    @Override
    public void run() {
        List<Review> list = null;
        /*  deserialize to list of reviews  */
        try {
            list = s3.downloadingListofReviews(this.local.getBucketName(), "reviews");
        } catch (IOException e) {}

        listOfReviewsToMessagesInQueue(list, this.sqs, this.manToWorkersQueueUrl);

        try {
            createWorkers();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        while(this.resources.getLocals().containsKey(this.local.getQueueUrlToLocal())){
            /*  checks if all reviews were proceeded   */
            if(this.local.isFinish()){

                File file = createSummeryFile(this.local);

                s3.uploadingObject(this.local.getBucketName(), file, "summery");

                while(!s3.getS3().doesObjectExist(this.local.getBucketName(), "summery")){}

                sqs.sendMessageToSQS(this.local.getQueueUrlToLocal(),"summery" );

                this.resources.getLocals().remove(this.local.getQueueUrlToLocal());
            }
        }
    }

    private File createSummeryFile(LocalData currLocal) {
        File file = new File("summery");
        FileWriter fw = null;
        try {
            fw = new FileWriter(file);
            String summeryToSend = join(currLocal.getSummery(),"\n");
            fw.write(summeryToSend);
            fw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return file;
    }

    private void createWorkers() throws InterruptedException {
        synchronized (this.resources.getLock()) {
            /*  calculate number of workers */
            int workerToAdd = this.local.getReviewsCount() / this.local.getN() - this.resources.getNumOfWorkers();

            /*  creates ec2 for workers, if needed   */
            if (workerToAdd > 0) {
                String script = scriptForWorker();
                ec2.create(new Tag("Job", "worker"), "ami-02a057483ce3b0fa0", workerToAdd, workerToAdd, InstanceType.T2Large.toString(), script);
                this.resources.setNumOfWorkers(this.resources.getNumOfWorkers() + workerToAdd);
            }
        }
    }

    private String scriptForWorker(){
        ArrayList<String> script = new ArrayList<String>();

        //beginning of bash script
        script.add("#! /bin/bash");
        script.add("sudo yum update -y");
        script.add("cd ..");
        script.add("cd ..");
        script.add("cd home/ec2-user");

        //make config file with cred
        script.add("aws configure set aws_access_key_id AKIA3LDIIYAN36NR44LV");
        script.add("aws configure set aws_secret_access_key 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");
        script.add("aws configure set default.region us-east-1");

        //download files to manager storage
        script.add("aws s3 cp s3://jars-manager-workers/ /home/ec2-user --recursive");

        script.add("java -Xmx30g -cp .:Worker.jar:ejml-0.23.jar:jollyday-0.5.2.jar:stanford-corenlp-3.9.2.jar:stanford-corenlp-3.9.2-models.jar Worker");

        String str = new String(Base64.encodeBase64(join(script, "\n").getBytes()));
        return str;
    }

    private LocalData processMessageFromLocal(Message message){
        String messageBody = message.getBody();

        String[] lines = messageBody.split(System.getProperty("line.separator"));
        LocalData local = new LocalData(lines[0],lines[1],Integer.parseInt(lines[2]),Integer.parseInt(lines[3]));

        return local;
    }

    private void listOfReviewsToMessagesInQueue(List<Review> list, SQS sqs, String manToWorkersQueueUrl) {
        for (Review review : list) {
            ArrayList<String> messageBody = new ArrayList<String>();
            messageBody.add(this.local.getQueueUrlToLocal());
            messageBody.add(review.getLink());
            messageBody.add(review.getText());
            messageBody.add(String.valueOf(review.getRating()));
            sqs.sendMessageToSQS(manToWorkersQueueUrl, join(messageBody, "\n"));
        }
    }

    private String join(Collection<String> s, String delimiter) {
        StringBuilder builder = new StringBuilder();
        Iterator<String> iter = s.iterator();
        while (iter.hasNext()) {
            builder.append(iter.next());
            if (!iter.hasNext()) {
                break;
            }
            builder.append(delimiter);
        }
        return builder.toString();
    }
}
