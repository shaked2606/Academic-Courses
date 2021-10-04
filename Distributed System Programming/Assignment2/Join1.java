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

import org.apache.commons.lang3.tuple.Pair;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.join.TupleWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

import java.io.IOException;
import java.util.ArrayList;

public class Join1 {
    public static class singlesMapper extends Mapper<LongWritable, Text, Text, Text> {

        @Override
        protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            String[] split_line = value.toString().split("\t");

            context.write(new Text(split_line[0]), new Text(split_line[1]));
        }
    }

    public static class tripletsMapper extends Mapper<LongWritable, Text, Text, Text> {

        @Override
        protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            String[] split_line = value.toString().split("\t");
            String[] split_triplets = split_line[0].split(" ");
            if(split_triplets.length != 3){
                return;
            }
            String word2 = split_triplets[1];
            String word3 = split_triplets[2];

            context.write(new Text("*~*"),new Text("triplets" + " "+ split_triplets[0] +" " + split_triplets[1] + " " +split_triplets[2] + " c0"));
            context.write(new Text(word2), new Text("triplets" + " " + split_triplets[0] +" " + split_triplets[1] + " " +split_triplets[2] + " c1" ));
            context.write(new Text(word3), new Text("triplets" + " "+ split_triplets[0] +" " + split_triplets[1] + " " +split_triplets[2] +" n1" ));
        }
    }

    public static class OurCombiner extends Reducer<Text, Text, Text, Text> {
        private IntWritable sum = new IntWritable(0);

        @Override
        protected void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            StringBuilder valuesOutput = new StringBuilder();
            for(Text value:values) {
                valuesOutput.append(value.toString()).append("#@!");
            }

            context.write(key, new Text(valuesOutput.toString()));
        }
    }

    public static class Reduce extends Reducer<Text, Text, Text, Text> {
        private IntWritable sum = new IntWritable(0);

        @Override
        protected void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            ArrayList<Text> tempValues = new ArrayList<Text>();
            for (Text value : values) {
                String[] seperateByTabsValues = value.toString().split("#@!");
                for (String t : seperateByTabsValues) {
                    String[] split = t.split(" ");
                    if (!split[0].equals("triplets")) {
                        sum.set(Integer.parseInt(split[0]));
                    } else {
                        Text tmp = new Text();
                        tmp.set(t);
                        tempValues.add(tmp);
                    }
                }
                for (Text t : tempValues) {
                    String[] split = t.toString().split(" ");
                    context.write(new Text(split[1] + " " + split[2] + " " + split[3]), new Text(split[4] + " " + sum.get()));
                }
            }
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = new Job(conf, "join1");
        job.setJarByClass(Join1.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        job.setCombinerClass(OurCombiner.class);
        job.setReducerClass(Reduce.class);
        job.setInputFormatClass(TextInputFormat.class);
        job.setOutputFormatClass(TextOutputFormat.class);
        job.setNumReduceTasks(10);

        MultipleInputs.addInputPath(job, new Path(args[0]), TextInputFormat.class,singlesMapper.class);
        MultipleInputs.addInputPath(job, new Path(args[1]),TextInputFormat.class,tripletsMapper.class);
        FileOutputFormat.setOutputPath(job, new Path(args[2]));

        boolean success = job.waitForCompletion(true);
        System.out.println(success);
    }
}