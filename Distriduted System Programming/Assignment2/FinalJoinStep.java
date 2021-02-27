import com.amazonaws.services.elasticmapreduce.model.HadoopJarStepConfig;
import com.amazonaws.services.elasticmapreduce.model.StepConfig;

public class FinalJoinStep {
    private String jarName;
    private String mainClassName;
    private String stepConfigName;
    private String inputDir1;
    private String inputDir2;
    private String inputDir3;
    private String outputDir;

    public FinalJoinStep(String jarName, String mainClassName, String stepConfigName, String inputDir1, String inputDir2, String inputDir3, String outputDir) {
        this.jarName = jarName;
        this.mainClassName = mainClassName;
        this.stepConfigName = stepConfigName;
        this.inputDir1 = inputDir1;
        this.inputDir2 = inputDir2;
        this.inputDir3 = inputDir3;
        this.outputDir = outputDir;
    }

    public StepConfig configJarStep(){
        HadoopJarStepConfig hadoopJarStep = new HadoopJarStepConfig()
                .withJar("s3n://jarwordcount/" + this.jarName) // This should be a full map reduce application.
                .withMainClass(mainClassName)
                .withArgs("s3n://jarwordcount/" + this.inputDir1, "s3n://jarwordcount/" + this.inputDir2, "s3n://jarwordcount/" + this.inputDir3, "s3n://jarwordcount/" + this.outputDir);

        StepConfig stepConfig = new StepConfig()
                .withName(this.stepConfigName)
                .withHadoopJarStep(hadoopJarStep)
                .withActionOnFailure("TERMINATE_JOB_FLOW");
        return stepConfig;
    }
}
