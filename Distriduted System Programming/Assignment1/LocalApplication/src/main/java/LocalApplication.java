import com.amazonaws.services.ec2.model.*;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.util.StringUtils;
import org.apache.commons.codec.binary.Base64;

import java.io.*;
import java.util.*;

import javax.json.Json;
import javax.json.stream.JsonParser;
import javax.swing.*;


public class LocalApplication {
    private static long startTime = System.currentTimeMillis();
    public static void main(String[] args) {
        boolean terminate = false;
        boolean localFinish = false;

        SQS sqs = new SQS();
        EC2 ec2 = new EC2();
        S3 s3 = new S3(); // build S3 storage using Access and id key per Local Application
        String mainQueueUrl = null;
        int n = 0;
        int k = 0;
        String outputFileName = "";

        /* create queue from Manager to Local */
        String urlManToLocal = sqs.create("manager-to-local", "5", "0");

        /*  create S3 storage   */
        String bucketName = s3.create();    // create s3 storage per local Application

        /* check if Manager EC2 is exist, if not creates it */
        if (!ec2.isManagerExist()) {
            /* create main queue from Locals to Manager */
            mainQueueUrl = sqs.create("locals-to-manager", "1", "0");

            /* create EC2 instance for Manager if not exist */
            String script = scriptForManager();
            ec2.create(new Tag("Job", "manager"), "ami-02a057483ce3b0fa0", 1, 1, InstanceType.T2Large.toString(), script);
        } else {
            while(sqs.getQueueUrl("locals-to-manager").equals("")){}

            /*  search for QueueUrl Of manager  */
            mainQueueUrl = sqs.getQueueUrl("locals-to-manager");
        }

        /*  checks the arguments of Local Application   */
        if (args[args.length - 1].equals("terminate")) {
            n = Integer.parseInt(args[args.length - 2]);
            k = 3;
            terminate = true;
            outputFileName = args[args.length-3];
        } else {
            n = Integer.parseInt(args[args.length - 1]);
            k = 2;
            outputFileName = args[args.length-2];
        }

        /*  parsing JSON files  */
        List<Review> reviews = parseJSON(args, k);

        /*  serialize list of reviews   */
        serialize(reviews, "reviews");

        /*  upload serialized file of reviews to S3 */
        File file = new File("reviews");
        s3.uploadingObject(file, "reviews");

        /*  send message with details of Local Application to S3 bucket */
        ArrayList<String> messageBody = sendMessageWithDetailsOfLocal(bucketName, urlManToLocal, reviews, n);
        sqs.sendMessageToSQS(mainQueueUrl, join(messageBody, "\n"));


        /*  waiting for summery of analysis and convert text file to HTML file output   */
        while (true) {
            List<Message> messageFromLocals = sqs.receiveMessages(urlManToLocal, 5);
            for (Message message : messageFromLocals) {
                if (message.getBody().equals("summery")) {

                    while(!s3.getS3().doesObjectExist(bucketName, "summery")){}

                    String summery = s3.downloadingSummery(bucketName, "summery");

                    String totalHTMLOutput = parseSummeryToHTMLOutput(summery);

                    visualizeToHTMLPage(totalHTMLOutput, urlManToLocal);

                    String output =  convertOutputToHtml(totalHTMLOutput);

                    final String name = outputFileName;
                    try {
                        File htmlFile = new File(name +".html");
                        FileOutputStream fos = new FileOutputStream(htmlFile,false);
                        fos.write(output.getBytes());
                        fos.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                    localFinish = true;
                    break;
                }
            }
            // if LocalApp has terminate argument - after he finish all his input file, he needs to terminate all ec2 instances
            if (terminate & localFinish) {
                /*  update manager to terminate */
                sqs.sendMessageToSQS(mainQueueUrl, "Terminate");
                break;
            } else if (localFinish) {
                break;
            }
        }
        s3.deletingObject("summery");
        s3.deletingObject("reviews");
        s3.deletingBucket(bucketName);
        sqs.deleteQueue(urlManToLocal);

        long endTime = System.currentTimeMillis();
        System.out.println("Run Time of Local: " + ((endTime - startTime)*0.001)/60 + " minutes");
    }

    private static void visualizeToHTMLPage(String totalHTMLOutput, String urlManToLocal) {
        String output =  convertOutputToHtml(totalHTMLOutput);
        JEditorPane edl = new JEditorPane("text/html", output);
        edl.setVisible(true);
        edl.setSize(600, 600);

        JScrollPane scrollPane = new JScrollPane(edl);
        JFrame f = new JFrame("Local Application Output");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.getContentPane().add(scrollPane);
        f.setSize(512, 342);
        f.setVisible(true);
    }

    private static String parseSummeryToHTMLOutput(String summery) {
        String[] lines = summery.split("\n");  //split summery to lines
        String totalHTMLOutput = "";
        int i = 0;
        while(i <= lines.length - 4) {
            int sentiment = Integer.parseInt(lines[i]);
            String link = lines[i+1];
            String entitiesRecognition = lines[i+2];
            String sarcasticOrNot = lines[i+3];
            String HTMLOutput = convertReviewToHTML(sentiment, link, entitiesRecognition, sarcasticOrNot);
            totalHTMLOutput += HTMLOutput;
            i+=4;
        }
        return totalHTMLOutput;
    }

    private static ArrayList<String> sendMessageWithDetailsOfLocal(String bucketName, String urlManToLocal,List<Review> reviews, int n) {
        ArrayList<String> messageBody = new ArrayList<String>();
        messageBody.add(bucketName);
        messageBody.add(urlManToLocal);
        messageBody.add(String.valueOf(reviews.size()));
        messageBody.add(String.valueOf(n));
        return messageBody;
    }


    private static String scriptForManager(){
        ArrayList<String> script = new ArrayList<String>();

        //beginning of bash script
        script.add("#! /bin/bash");
        script.add("sudo yum update -y");
        script.add("cd ..");
        script.add("cd ..");
        script.add("cd home/ec2-user");

        script.add("chmod -R 777 /home/ec2-user");

        //make config file with cred
        script.add("aws configure set aws_access_key_id AKIA3LDIIYAN36NR44LV");
        script.add("aws configure set aws_secret_access_key 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");
        script.add("aws configure set default.region us-east-1");

        //download files to manager storage
        script.add("aws s3 cp s3://jars-manager-workers/ /home/ec2-user --recursive");

        script.add("java -jar Manager.jar");

        String str = new String(Base64.encodeBase64(join(script, "\n").getBytes()));
        return str;
    }

    private static String convertOutputToHtml(String output){
        if(StringUtils.isNullOrEmpty(output))
            return "<html><body></body></html>";

        StringBuffer buf = new StringBuffer("<html><body>");
        buf.append(output);
        buf.append( "</body></html>" );
        output = buf.toString();

        return output;
    }

    private static String convertReviewToHTML(int sentiment, String link, String entitieRecognition, String sarcastifOrNot){
        String color = whichColorBySentiment(sentiment);
        String output = "";
        StringBuffer buf = new StringBuffer();
        buf.append("<p "+ color+">");
        buf.append("<a href= '" + link +"'>"+ link + "</a>");
        buf.append("\n");
        buf.append(entitieRecognition);
        buf.append("\n");
        buf.append(sarcastifOrNot);
        buf.append("\n");
        buf.append("</p>");
        output = buf.toString();

        return output;
    }

    private static String whichColorBySentiment(int sentiment){
        String color = "";
        switch (sentiment){
            case 0:
                color = "style='background-color:#800000;'";
                break;
            case 1:
                color = "style='background-color:#ff3333;'";
                break;
            case 2:
                color = "style='background-color:#000000;color:white;'";
                break;
            case 3:
                color = "style='background-color:#85e085;'";
                break;
            case 4:
                color = "style='background-color:#155115;'";
                break;
        }
        return color;
    }

    private static String join(Collection<String> s, String delimiter) {
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

    private static void serialize(Object obj, String filename) {
        ObjectOutputStream out = null;
        try {
            out = new ObjectOutputStream(new FileOutputStream(filename));
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            out.writeObject(obj);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static List<Review> parseJSON(String[] args, int k){
        List<Review> reviews = new ArrayList<Review>();
        JsonParser parser = null;
        try {
            for(int j=0; j<args.length-k;j++) {
                parser = Json.createParser(new FileReader(args[j]));
                String key;
                String id = null;
                String link = null;
                String title = null;
                String text = null;
                String author = null;
                String date = null;
                long rating = 0;
                while (parser.hasNext()) {
                    JsonParser.Event event = parser.next();
                    switch (event) {
                        case KEY_NAME:
                            key = parser.getString();

                            if (key.equals("reviews")) {
                                event = parser.next();

                                event = parser.next();
                                do {
                                    for (int i = 0; i < 7; i++) {
                                        event = parser.next();
                                        key = parser.getString();
                                        if (key.equals("id")) {
                                            event = parser.next();
                                            key = parser.getString();
                                            id = key;
                                        } else if (key.equals("link")) {
                                            event = parser.next();
                                            key = parser.getString();
                                            link = key;
                                        } else if (key.equals("title")) {
                                            event = parser.next();
                                            key = parser.getString();
                                            title = key;
                                        } else if (key.equals("text")) {
                                            event = parser.next();
                                            key = parser.getString();
                                            text = key;
                                        } else if (key.equals("rating")) {
                                            event = parser.next();
                                            key = parser.getString();
                                            rating = Long.parseLong(key);
                                        } else if (key.equals("author")) {
                                            event = parser.next();
                                            key = parser.getString();
                                            author = key;
                                        } else if (key.equals("date")) {
                                            event = parser.next();
                                            key = parser.getString();
                                            date = key;
                                        }
                                    }
                                    Review review = new Review(id, link, title, text, rating, author, date);
                                    reviews.add(review);
                                    event = parser.next();
                                    event = parser.next();
                                }
                                while (event != JsonParser.Event.END_ARRAY);
                            }
                    }
                }
            }
            parser.close();
            return reviews;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return reviews;
    }
}
