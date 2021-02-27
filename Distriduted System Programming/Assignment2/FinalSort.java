/**
 * WordCount.java - the very-first MapReduce Program
 *
 * <h1>How To Compile</h1>
 * export HADOOP_HOME=/usr/lib/hadoop-0.20/
 * export DIR=wordcount_classes
 * rm -fR $DIR
 * mkdir $DIR
 * javac -classpath ${HADOOP_HOME}/hadoop-core.jar -d $DIR WordCount.java 
 * jar -cvf wordcount.jar -C $DIR .
 */


import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

public class FinalSort {
    public static class Map extends Mapper<LongWritable, Text, FinalCompareTo, Text> {

        @Override
        protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            String[] split_line = value.toString().split("\t");
            String[] splitKey = split_line[0].split(" ");
            context.write(new FinalCompareTo(new Text(splitKey[0]+" "+splitKey[1]),new Text(splitKey[2]),new DoubleWritable(Double.valueOf(splitKey[3]))), new Text(""));
        }
    }

    public static class Reduce extends Reducer<FinalCompareTo, Text, FinalCompareTo, Text> {

        @Override
        protected void reduce(FinalCompareTo key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            context.write(key,new Text(""));
        }
    }

    public static class FinalCompareTo implements WritableComparable<FinalCompareTo> {
        private Text firstTwoWords;
        private Text thirdWord;
        private DoubleWritable prob;

        public FinalCompareTo(){
            this.firstTwoWords = new Text();
            this.thirdWord = new Text();
            this.prob = new DoubleWritable(0);
        }

        public FinalCompareTo(Text firstTwoWords, Text thirdWord, DoubleWritable prob) {
            this.firstTwoWords = new Text(firstTwoWords);
            this.thirdWord = new Text(thirdWord);
            this.prob = new DoubleWritable(prob.get());
        }

        public String toString(){
            return this.firstTwoWords + " " + this.thirdWord + " " + this.prob.get();
        }

        public int compareTo(FinalCompareTo other) {
            if(firstTwoWords.toString().compareTo(other.getFirstTwoWords().toString()) > 0){
                return 1;
            }
            else if(firstTwoWords.toString().compareTo(other.getFirstTwoWords().toString()) < 0){
                return -1;
            }
            else {
                if(this.prob.get() > other.getProb().get()){
                    return -1;
                }
                else if (this.prob.get() < other.getProb().get()){
                    return 1;
                }
                else{
                    return 0;
                }
            }
        }

        public void write(DataOutput dataOutput) throws IOException {
            this.prob.write(dataOutput);
            this.firstTwoWords.write(dataOutput);
            this.thirdWord.write(dataOutput);
        }

        public void readFields(DataInput dataInput) throws IOException {
            this.prob.readFields(dataInput);
            this.firstTwoWords.readFields(dataInput);
            this.thirdWord.readFields(dataInput);
        }

        public DoubleWritable getProb() {
            return prob;
        }

        public Text getFirstTwoWords() {
            return firstTwoWords;
        }

        public Text getThirdWord() {
            return thirdWord;
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = new Job(conf, "finalsort");
        job.setJarByClass(FinalSort.class);
        job.setOutputKeyClass(FinalCompareTo.class);
        job.setOutputValueClass(Text.class);
        job.setMapperClass(Map.class);
        job.setCombinerClass(Reduce.class);
        job.setReducerClass(Reduce.class);
        job.setInputFormatClass(TextInputFormat.class);
        job.setOutputFormatClass(TextOutputFormat.class);
        job.setNumReduceTasks(1);

        FileInputFormat.setInputPaths(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        boolean success = job.waitForCompletion(true);
        System.out.println(success);
    }
}