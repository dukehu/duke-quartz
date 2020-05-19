package com.duke.microservice.quartz;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * Created duke on 2020/5/19
 */
@Configuration
@ConfigurationProperties(prefix = "duke.quartz", ignoreInvalidFields = true)
@Getter
@Setter
public class QuartzProperties {
}
