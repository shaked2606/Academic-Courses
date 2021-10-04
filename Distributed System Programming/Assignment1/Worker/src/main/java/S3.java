import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class S3 {
    private AmazonS3 s3;
    private String uniqueId;

    public S3(){
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
        AmazonS3 s3 = AmazonS3ClientBuilder.standard()
                .withCredentials(credentialsProvider)
                .withRegion(Regions.US_EAST_1)
                .build();
        this.s3 = s3;
        this.uniqueId = UUID.randomUUID().toString().toLowerCase();
    }

    public String create(){
        try {
            AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
            String bucketName = (this.uniqueId + credentialsProvider.getCredentials().getAWSAccessKeyId()).toLowerCase();
            System.out.println("Creating bucket " + bucketName);
            String nameBucket =  s3.createBucket(bucketName).getName();
            System.out.println("Creating S3 bucket named: " + nameBucket + " Complete Successfully!");
            return nameBucket;
        }     catch (AmazonServiceException ase) {
            s3CatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            s3CatchClientException(ace);
        }
        return null;
    }

    public void listingBucket(){
        try {
            System.out.println("Listing buckets");
            for (Bucket bucket : s3.listBuckets()) {
                System.out.println(" - " + bucket.getName());
            }
            System.out.println("Listing buckets Complete Successfully!");
        } catch (AmazonServiceException ase) {
            s3CatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            s3CatchClientException(ace);
        }
    }

    public void listingObjects(){
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
        String bucketName = (this.uniqueId + credentialsProvider.getCredentials().getAWSAccessKeyId()).toLowerCase();

        try {
            System.out.println("Listing objects");
            ObjectListing objectListing = s3.listObjects(new ListObjectsRequest()
                    .withBucketName(bucketName));
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                System.out.println(" - " + objectSummary.getKey() + "  " +
                        "(size = " + objectSummary.getSize() + ")");
            }
            System.out.println("Listing Objects from bucket: "+ bucketName + " Complete Successfully!");
        } catch (AmazonServiceException ase) {
            s3CatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            s3CatchClientException(ace);
        }
    }

    public void uploadingObject(File file, String key){
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
        String bucketName = (this.uniqueId + credentialsProvider.getCredentials().getAWSAccessKeyId()).toLowerCase();;

        try {
            System.out.println("Uploading a new object "+ key + " to S3 from a file named: "+ file);
            PutObjectRequest req = new PutObjectRequest(bucketName, key, file);
            s3.putObject(req);
            System.out.println("Uploading object from bucket: " + bucketName +" named: " + key + " from file named: " + file + " Complete Successfully!");
        } catch (AmazonServiceException ase) {
            s3CatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            s3CatchClientException(ace);
        }
    }

    public void uploadingObject(String bucketName, File file, String key){
        try {
            System.out.println("Uploading a new object "+ key + " to S3 from a file named: "+ file);
            PutObjectRequest req = new PutObjectRequest(bucketName, key, file);
            s3.putObject(req);
            System.out.println("Uploading object from bucket: " + bucketName +" named: " + key + " from file named: " + file + " Complete Successfully!");
        } catch (AmazonServiceException ase) {
            s3CatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            s3CatchClientException(ace);
        }
    }

    public void downloadingObject(String bucketName, String key) {
        System.out.println("Downloading an object named: "+ key +" from bucket: "+ bucketName);
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());

        S3Object object = s3.getObject(new GetObjectRequest(bucketName, key));
        System.out.println("Content-Type: " + object.getObjectMetadata().getContentType());
        System.out.println("Downloading object from bucket: " + bucketName +" named: " + key +" Complete Successfully!");
        System.out.println("Text of Object: ");
        try {
            displayTextInputStream(object.getObjectContent());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String downloadingSummery(String bucketName, String key) {
        System.out.println("Downloading an object named: "+ key +" from bucket: "+ bucketName);
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());

        S3Object object = s3.getObject(new GetObjectRequest(bucketName, key));
        System.out.println("Content-Type: " + object.getObjectMetadata().getContentType());
        System.out.println("Downloading Summery from bucket: " + bucketName +" Complete Successfully!");
        try {
            String output = TextInputStreamToString(object.getObjectContent());
            return output;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }


    public List<Review> downloadingListofReviews(String bucketName, String key) throws IOException {
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
        try {
            System.out.println("Downloading an object named: "+ key +" from bucket: "+ bucketName);
            S3Object object = s3.getObject(new GetObjectRequest(bucketName, key));
            System.out.println("Content-Type: " + object.getObjectMetadata().getContentType());
            List<Review> list = deserialize(object.getObjectContent());
            System.out.println("Downloading List of reviews from bucket: " + bucketName +" Complete Successfully!");
            return list;
        } catch (AmazonServiceException ase) {
            s3CatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            s3CatchClientException(ace);
        }
        return null;
    }

    private static ArrayList<Review> deserialize(S3ObjectInputStream object) {
        BufferedInputStream inputStream;
        ObjectInputStream ois;
        ArrayList<Review> reviews = new ArrayList<>();
        try {
            inputStream = new BufferedInputStream(object);
            ois = new ObjectInputStream(inputStream);
            reviews = (ArrayList<Review>)ois.readObject();
            ois.close();
            inputStream.close();
            return (ArrayList<Review>) reviews;

        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return reviews;
    }


    public void deletingObject(String key){
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
        String bucketName = (this.uniqueId + credentialsProvider.getCredentials().getAWSAccessKeyId()).toLowerCase();;
        try {
            System.out.println("Deleting an object named: " + key);
            s3.deleteObject(bucketName, key);
            System.out.println("Deleting object named: " + key + " from bucket named: " + bucketName + " Complete Successfully");
        } catch (AmazonServiceException ase) {
            s3CatchServiceException(ase);
        }
        catch (AmazonClientException ace) {
            s3CatchClientException(ace);
        }
    }

    public void deletingBucket(String bucketName){
        System.out.println("Deleting bucket " + bucketName);
        s3.deleteBucket(bucketName);
        System.out.println("Deleting bucket named: " + bucketName + " Complete Successfully");
    }

    private static String TextInputStreamToStringLine(InputStream input) throws IOException {
        String output = "";
        BufferedReader reader = new BufferedReader(new InputStreamReader(input));
        while (true) {
            String line = reader.readLine();
            if (line == null) break;

            output+="    " + line;
        }
        return output;
    }

    private static String TextInputStreamToString(InputStream input) throws IOException {
        java.util.Scanner s = new java.util.Scanner(input).useDelimiter("\\A");
        return s.hasNext() ? s.next() : "";
    }

    private static void displayTextInputStream(InputStream input) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(input));
        while (true) {
            String line = reader.readLine();
            if (line == null) break;

            System.out.println("    " + line);
        }
        System.out.println();
    }

    public AmazonS3 getS3() {
        return this.s3;
    }


    public static void s3CatchServiceException(AmazonServiceException ase) {
        System.out.println("Caught an AmazonServiceException, which means your request made it " +
                "to Amazon S3, but was rejected with an error response for some reason.");
        System.out.println("Error Message:    " + ase.getMessage());
        System.out.println("HTTP Status Code: " + ase.getStatusCode());
        System.out.println("AWS Error Code:   " + ase.getErrorCode());
        System.out.println("Error Type:       " + ase.getErrorType());
        System.out.println("Request ID:       " + ase.getRequestId());
    }

    public static void s3CatchClientException(AmazonClientException ace) {
        System.out.println("Caught an AmazonClientException, which means the client encountered " +
                "a serious internal problem while trying to communicate with S3, such as not " +
                "being able to access the network.");
        System.out.println("Error Message: " + ace.getMessage());
    }
}
