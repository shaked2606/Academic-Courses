import java.util.ArrayList;
import java.util.List;

public class LocalData {

    private String bucketName;
    private String queueUrlToLocal;
    private int reviewsCount;
    private int n;
    private List<String> outputs;

    public LocalData(String bucketName, String queueUrlToLocal, int reviewsCount, int n){
        this.bucketName = bucketName;
        this.queueUrlToLocal = queueUrlToLocal;
        this.reviewsCount = reviewsCount;
        this.n = n;
        this.outputs = new ArrayList<>();
    }

    public String getBucketName() {
        return bucketName;
    }

    public String getQueueUrlToLocal() {
        return queueUrlToLocal;
    }

    public int getReviewsCount() {
        return reviewsCount;
    }

    public void setReviewsCount(int reviewsCount) {
        this.reviewsCount = reviewsCount;
    }

    public int getN() {
        return n;
    }

    public void addOutput(String output){
        outputs.add(output);
        reviewsCount--;
    }

    public List<String> getSummery() {
        return outputs;
    }

    public boolean isFinish(){
        if(reviewsCount == 0){
            return true;
        }
        return false;
    }
}
