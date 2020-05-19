package com.duke.microservice.quartz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * Created duke on 2020/5/19
 */
@SpringBootApplication
@EnableDiscoveryClient
public class QuartzAppliction {
    public static void main(String[] args) {
        SpringApplication.run(QuartzAppliction.class, args);
    }
}
