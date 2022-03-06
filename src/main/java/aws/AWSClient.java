package aws;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

public class AWSClient {

    public static AmazonS3 getAmazonS3() {
        return AmazonS3ClientBuilder.standard()
                .withRegion("eu-central-1")
                .build();
    }
}
