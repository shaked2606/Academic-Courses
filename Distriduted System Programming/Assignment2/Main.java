import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.ec2.model.InstanceType;
import com.amazonaws.services.elasticmapreduce.AmazonElasticMapReduce;
import com.amazonaws.services.elasticmapreduce.AmazonElasticMapReduceClientBuilder;
import com.amazonaws.services.elasticmapreduce.model.*;

import java.util.LinkedList;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        AWSCredentials credentials_profile = new ProfileCredentialsProvider("default").getCredentials(); // specifies any named profile in .aws/credentials as the credentials provider
        AmazonElasticMapReduce mapReduce = AmazonElasticMapReduceClientBuilder.standard()
                .withCredentials(new AWSStaticCredentialsProvider(credentials_profile))
                .withRegion(Regions.US_EAST_1)
                .build();

        NgramStep mapReduce1 = new NgramStep("map_reduce1.jar","MapReduce1","stepConfigMapReduce1","1gram","outputMapReduce1");
        NgramStep mapReduce2 = new NgramStep("map_reduce2.jar","MapReduce2","stepConfigMapReduce2","2gram","outputMapReduce2");
        NgramStep mapReduce3 = new NgramStep("map_reduce3.jar","MapReduce3","stepConfigMapReduce3","3gram","outputMapReduce3");

        JoinStep join1 = new JoinStep("join1.jar","Join1","stepConfigJoin1","outputMapReduce1","outputMapReduce3", "outputJoin1");
        JoinStep join2 = new JoinStep("join2.jar","Join2","stepConfigJoin2","outputMapReduce2","outputMapReduce3", "outputJoin2");

        FinalJoinStep finaljoin = new FinalJoinStep("finaljoin.jar","FinalJoin","stepConfigFinalJoin","outputJoin1","outputJoin2", "outputMapReduce3","outputFinalJoin");

        SortStep finalsort = new SortStep("finalsort.jar","FinalSort","stepConfigFinalSort","outputFinalJoin","FinalSortedOutput");

        List<StepConfig> steps = new LinkedList<StepConfig>();

        //steps.add(mapReduce1.configJarStep());
        //steps.add(mapReduce2.configJarStep());
        //steps.add(mapReduce3.configJarStep());
        //steps.add(join1.configJarStep());
        steps.add(join2.configJarStep());
        steps.add(finaljoin.configJarStep());
        steps.add(finalsort.configJarStep());

        JobFlowInstancesConfig instances = new JobFlowInstancesConfig()
                .withInstanceCount(2)
                .withMasterInstanceType(InstanceType.M1Medium.toString())
                .withSlaveInstanceType(InstanceType.M1Medium.toString())
                .withHadoopVersion("2.10.0").withEc2KeyName("ec2")
                .withKeepJobFlowAliveWhenNoSteps(false)
                .withPlacement(new PlacementType("us-east-1a"));

        RunJobFlowRequest runFlowRequest = new RunJobFlowRequest()
                .withName("jobname")
                .withReleaseLabel("emr-5.20.0")
                .withSteps(steps)
                .withLogUri("s3n://jarwordcount/logs/")
                .withServiceRole("EMR_DefaultRole")
                .withJobFlowRole("EMR_EC2_DefaultRole")
                .withInstances(instances);

        RunJobFlowResult runJobFlowResult = mapReduce.runJobFlow(runFlowRequest);
        String jobFlowId = runJobFlowResult.getJobFlowId();
        System.out.println("Ran job flow with id: " + jobFlowId);
    }
}
