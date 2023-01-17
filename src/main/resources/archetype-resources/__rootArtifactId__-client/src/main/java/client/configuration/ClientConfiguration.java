package ${package}.client.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * Client配置类
 * @author sunbo
 */
@Configuration
@EnableConfigurationProperties(ClientProperties.class)
@ComponentScan(basePackages = "${package}.client")
public class ClientConfiguration {

    @Autowired
    private ClientProperties properties;

}