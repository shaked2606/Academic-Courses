import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.ec2.AmazonEC2;
import com.amazonaws.services.ec2.AmazonEC2ClientBuilder;
import com.amazonaws.services.ec2.model.*;


public class EC2 {
    public AmazonEC2 ec2;

    public EC2(){
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(new ProfileCredentialsProvider().getCredentials());
        AmazonEC2 ec2 = AmazonEC2ClientBuilder.standard()
                .withCredentials(credentialsProvider)
                .withRegion(Regions.US_EAST_1)
                .build();
        this.ec2 = ec2;
    }

    public void create(Tag tag, String image, int minCount, int maxCount, String instanceType, String script){
        try {
            TagSpecification tagSpecification = new TagSpecification().withTags(tag);
            tagSpecification.setResourceType(ResourceType.Instance);

            System.out.println("Creating EC2 instance");
            RunInstancesRequest request = new RunInstancesRequest()
                    .withImageId(image)
                    .withInstanceType(instanceType)
                    .withMinCount(minCount)
                    .withMaxCount(maxCount)
                    .withTagSpecifications(tagSpecification)
                    .withUserData(script);

            this.ec2.runInstances(request);
        } catch (AmazonServiceException ase) {
            System.out.println("Caught Exception: " + ase.getMessage());
            System.out.println("Reponse Status Code: " + ase.getStatusCode());
            System.out.println("Error Code: " + ase.getErrorCode());
            System.out.println("Request ID: " + ase.getRequestId());
        }
    }

    public AmazonEC2 getEc2(){
        return this.ec2;
    }

    public boolean isManagerExist() {
        DescribeInstancesRequest request = new DescribeInstancesRequest();
        while (true) {
            DescribeInstancesResult response = ec2.describeInstances(request);

            for (Reservation reservation : response.getReservations()) {
                for (Instance instance : reservation.getInstances()) {
                    System.out.printf(
                            "Found instance with id %s, " +
                                    "AMI %s, " +
                                    "type %s, " +
                                    "state %s " +
                                    "and monitoring state %s",
                            instance.getInstanceId(),
                            instance.getImageId(),
                            instance.getInstanceType(),
                            instance.getState().getName(),
                            instance.getMonitoring().getState());
                    for(Tag tag:instance.getTags()){
                        if(tag.getValue().equals("manager")&&(!(instance.getState().getName().equals("terminated")|instance.getState().getName().equals("shutting-down")))){
                                return true;
                        }
                    }
                }
            }

            request.setNextToken(response.getNextToken());

            if (response.getNextToken() == null) {
                break;
            }
        }
        return false;
    }
}
