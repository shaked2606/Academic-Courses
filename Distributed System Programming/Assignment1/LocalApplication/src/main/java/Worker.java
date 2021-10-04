import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.sqs.model.Message;
import edu.stanford.nlp.ling.CoreAnnotations;
import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.neural.rnn.RNNCoreAnnotations;
import edu.stanford.nlp.pipeline.Annotation;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;
import edu.stanford.nlp.sentiment.SentimentCoreAnnotations;
import edu.stanford.nlp.trees.Tree;
import edu.stanford.nlp.util.CoreMap;

import java.util.*;

public class Worker {
    public static void main(String[] args) {
        SQS sqs = new SQS();;
        String manToWorkersQueueUrl = "";
        String workersToManQueueUrl = "";


        //  waiting for queues to be on line
        while (sqs.getQueueUrl("manager-to-workers").equals("") | sqs.getQueueUrl("workers-to-manager").equals("")) { }

        manToWorkersQueueUrl = sqs.getQueueUrl("manager-to-workers");
        workersToManQueueUrl = sqs.getQueueUrl("workers-to-manager");

        List<String> output = new ArrayList<>();
        String linkReview = "";
        String textReview = "";
        int ratingReview = -1;
        String manToLocalQueueUrl = "";

        while (true) {
            List<Message> messageFromManager = sqs.receiveMessages(manToWorkersQueueUrl, 1);
            for (Message message : messageFromManager) {
                String receipt = message.getReceiptHandle();
                sqs.getSqs().changeMessageVisibility(manToWorkersQueueUrl, receipt, 1800);

                // parse message
                String messageBody = message.getBody();
                String[] lines = messageBody.split(System.getProperty("line.separator"));
                manToLocalQueueUrl = lines[0];
                linkReview = lines[1];
                textReview = lines[2];
                ratingReview = Integer.parseInt(lines[3]);


                Properties props1 = new Properties();
                props1.put("annotators", "tokenize , ssplit, pos, lemma, ner");
                StanfordCoreNLP NERPipeline = new StanfordCoreNLP(props1);


                Properties props2 = new Properties();
                props2.put("annotators", "tokenize, ssplit, parse, sentiment");
                StanfordCoreNLP sentimentPipeline = new StanfordCoreNLP(props2);

                int sentimentReview = findSentiment(textReview, sentimentPipeline);

                try {
                    // creating output message
                    output.add(manToLocalQueueUrl);
                    output.add(String.valueOf(sentimentReview));
                    output.add(linkReview);
                    output.add("Entities recognition: " + printEntities(textReview, NERPipeline));
                    if (ratingReview != sentimentReview) {
                        output.add("This is a sarcastic review");
                    } else {
                        output.add("Not a sarcastic review");
                    }

                    String outputReviewToSend = join(output, "\n");
                    sqs.sendMessageToSQS(workersToManQueueUrl, outputReviewToSend);

                    sqs.deleteMessageByReceipt(manToWorkersQueueUrl, receipt);

                    output.clear();
                } catch (AmazonServiceException ase) {
                    sqsCatchServiceException(ase);
                } catch (AmazonClientException ace) {
                    sqsCatchClientException(ace);
                }
            }
        }
    }

    private static int findSentiment(String review, StanfordCoreNLP sentimentPipeline) {
        int mainSentiment = 0;
        if (review != null && review.length() > 0) {
            int longest = 0;
            Annotation annotation = sentimentPipeline.process(review);
            for (CoreMap sentence : annotation.get(CoreAnnotations.SentencesAnnotation.class)) {
                Tree tree = sentence.get(SentimentCoreAnnotations.SentimentAnnotatedTree.class);
                int sentiment = RNNCoreAnnotations.getPredictedClass(tree);
                String partText = sentence.toString();
                if (partText.length() > longest) {
                    mainSentiment = sentiment;
                    longest = partText.length();
                }

            }
        }
        return mainSentiment;
    }

    private static ArrayList<String> printEntities(String review, StanfordCoreNLP NERPipeline) {
        ArrayList<String> output = new ArrayList<>();
        // create an empty Annotation just with the given text
        Annotation document = new Annotation(review);

        // run all Annotators on this text
        NERPipeline.annotate(document);

        // these are all the sentences in this document
        // a CoreMap is essentially a Map that uses class objects as keys and has values with custom types
        List<CoreMap> sentences = document.get(CoreAnnotations.SentencesAnnotation.class);

        for (CoreMap sentence : sentences) {
            // traversing the words in the current sentence
            // a CoreLabel is a CoreMap with additional token-specific methods
            for (CoreLabel token : sentence.get(CoreAnnotations.TokensAnnotation.class)) {
                // this is the text of the token
                String word = token.get(CoreAnnotations.TextAnnotation.class);
                // this is the NER label of the token
                String ne = token.get(CoreAnnotations.NamedEntityTagAnnotation.class);
                if(!ne.equals("O")) {
                    System.out.println(word + ":" + ne + ", ");
                    output.add(word + ":" + ne + ", ");
                }
            }
        }
        return output;
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

    private static void sqsCatchServiceException(AmazonServiceException ase) {
        System.out.println("Caught an AmazonServiceException, which means your request made it " +
                "to Amazon SQS, but was rejected with an error response for some reason.");
        System.out.println("Error Message:    " + ase.getMessage());
        System.out.println("HTTP Status Code: " + ase.getStatusCode());
        System.out.println("AWS Error Code:   " + ase.getErrorCode());
        System.out.println("Error Type:       " + ase.getErrorType());
        System.out.println("Request ID:       " + ase.getRequestId());
    }

    private static void sqsCatchClientException(AmazonClientException ace) {
        System.out.println("Caught an AmazonClientException, which means the client encountered " +
                "a serious internal problem while trying to communicate with SQS, such as not " +
                "being able to access the network.");
        System.out.println("Error Message: " + ace.getMessage());
    }
}
