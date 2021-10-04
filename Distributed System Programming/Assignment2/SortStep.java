import com.amazonaws.services.elasticmapreduce.model.HadoopJarStepConfig;
import com.amazonaws.services.elasticmapreduce.model.StepConfig;

public class SortStep {
    private String jarName;
    private String mainClassName;
    private String stepConfigName;
    private String inputDir;
    private String outputDir;

    public SortStep(String jarName, String mainClassName, String stepConfigName, String inputDir, String outputDir) {
        this.jarName = jarName;
        this.mainClassName = mainClassName;
        this.stepConfigName = stepConfigName;
        this.inputDir = inputDir;
        this.outputDir = outputDir;
    }

    public StepConfig configJarStep(){
        HadoopJarStepConfig hadoopJarStep = new HadoopJarStepConfig()
                .withJar("s3n://jarwordcount/" + this.jarName) // This should be a full map reduce application.
                .withMainClass(mainClassName)
                .withArgs("s3n://jarwordcount/" + this.inputDir, "s3n://jarwordcount/" + this.outputDir);

        StepConfig stepConfig = new StepConfig()
                .withName(this.stepConfigName)
                .withHadoopJarStep(hadoopJarStep)
                .withActionOnFailure("TERMINATE_JOB_FLOW");
        return stepConfig;
    }
}
