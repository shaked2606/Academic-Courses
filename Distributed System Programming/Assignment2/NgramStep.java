import com.amazonaws.services.elasticmapreduce.model.HadoopJarStepConfig;
import com.amazonaws.services.elasticmapreduce.model.StepConfig;

public class NgramStep {
    private String jarName;
    private String mainClassName;
    private String stepConfigName;
    private String ngram;
    private String outputDir;

    public NgramStep(String jarName, String mainClassName, String stepConfigName, String ngram, String outputDir) {
        this.jarName = jarName;
        this.mainClassName = mainClassName;
        this.stepConfigName = stepConfigName;
        this.ngram = ngram;
        this.outputDir = outputDir;
    }

    public StepConfig configJarStep(){
        HadoopJarStepConfig hadoopJarStep = new HadoopJarStepConfig()
                .withJar("s3n://jarwordcount/" + this.jarName) // This should be a full map reduce application.
                .withMainClass(mainClassName)
                .withArgs("s3n://datasets.elasticmapreduce/ngrams/books/20090715/heb-all/" + this.ngram + "/data", "s3n://jarwordcount/" + this.outputDir);

        StepConfig stepConfig = new StepConfig()
                .withName(this.stepConfigName)
                .withHadoopJarStep(hadoopJarStep)
                .withActionOnFailure("TERMINATE_JOB_FLOW");
        return stepConfig;
    }
}
