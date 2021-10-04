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
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

import java.io.IOException;
import java.util.ArrayList;

public class FinalJoin {
    public static class singlesMapper extends Mapper<LongWritable, Text, Text, Text> {

        @Override
        protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            String[] split_line = value.toString().split("\t");
            context.write(new Text(split_line[0]), new Text(split_line[1]));
        }
    }

    public static class pairsMapper extends Mapper<LongWritable, Text, Text, Text> {

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
            context.write(new Text(split_line[0]), new Text("n3 "+ split_line[1]));
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
        private DoubleWritable c0 = new DoubleWritable(0);
        private DoubleWritable c1 = new DoubleWritable(0);
        private DoubleWritable c2 = new DoubleWritable(0);
        private DoubleWritable n1 = new DoubleWritable(0);
        private DoubleWritable n2 = new DoubleWritable(0);
        private DoubleWritable n3 = new DoubleWritable(0);
        private DoubleWritable k2 = new DoubleWritable(0);
        private DoubleWritable k3 = new DoubleWritable(0);
        private DoubleWritable prob = new DoubleWritable(0);

        @Override
        protected void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            for (Text value : values) {
                String[] seperateByTabsValues = value.toString().split("#@!");
                for (String t : seperateByTabsValues) {
                    String[] stringArray = t.split(" ");
                    if (stringArray[0].equals("c0")) {
                        c0.set(Double.parseDouble(stringArray[1]));
                    } else if (stringArray[0].equals("c1")) {
                        c1.set(Double.parseDouble(stringArray[1]));
                    } else if (stringArray[0].equals("c2")) {
                        c2.set(Double.parseDouble(stringArray[1]));
                    } else if (stringArray[0].equals("n1")) {
                        n1.set(Double.parseDouble(stringArray[1]));
                    } else if (stringArray[0].equals("n2")) {
                        n2.set(Double.parseDouble(stringArray[1]));
                    } else if (stringArray[0].equals("n3")) {
                        n3.set(Double.parseDouble(stringArray[1]));
                    } else {
                        return;
                    }
                }
            }

            k2.set((Math.log(n2.get()+1)+1)/(Math.log(n2.get()+1)+2));
            k3.set((Math.log(n3.get()+1)+1)/(Math.log(n3.get()+1)+2));

            prob.set(k3.get()*(n3.get()/c2.get())+(1-k3.get())*k2.get()*(n2.get()/c1.get())+(1-k3.get())*(1-k2.get())*(n1.get()/c0.get()));

            context.write(new Text(key.toString() + " " + prob.get()),new Text(""));
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = new Job(conf, "finaljoin");
        job.setJarByClass(FinalJoin.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        job.setCombinerClass(OurCombiner.class);
        job.setReducerClass(Reduce.class);
        job.setInputFormatClass(TextInputFormat.class);
        job.setOutputFormatClass(TextOutputFormat.class);
        job.setNumReduceTasks(10);

        MultipleInputs.addInputPath(job, new Path(args[0]), TextInputFormat.class,singlesMapper.class);
        MultipleInputs.addInputPath(job, new Path(args[1]),TextInputFormat.class,pairsMapper.class);
        MultipleInputs.addInputPath(job, new Path(args[2]),TextInputFormat.class,tripletsMapper.class);
        FileOutputFormat.setOutputPath(job, new Path(args[3]));

        boolean success = job.waitForCompletion(true);
        System.out.println(success);
    }
}