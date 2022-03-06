import aws.AWSClient;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.models.s3.S3EventNotification;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.S3Object;
import lombok.SneakyThrows;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class ExportProcess implements RequestHandler<List<String>, String> {
    AmazonS3 amazonS3 = AWSClient.getAmazonS3();

    @SneakyThrows
    @Override
    public String handleRequest(List<String> files, Context context) {
        File f = File.createTempFile("importdata", "json");

        files.forEach(s->{
            try {
                S3Object mybucketasdasd = amazonS3.getObject("mybucketasdasd", s);
                System.out.println(s);
                FileOutputStream fos = new FileOutputStream(f, true);
                fos.write(mybucketasdasd.getObjectContent().getDelegateStream().readAllBytes());
                fos.write(" ".getBytes(StandardCharsets.UTF_8));
                mybucketasdasd.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        amazonS3.putObject("mybucketasdasd","final/output3.txt", f);

        return "Sup";
    }
}
