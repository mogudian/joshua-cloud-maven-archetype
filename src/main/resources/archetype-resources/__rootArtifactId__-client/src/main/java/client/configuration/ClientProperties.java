package ${package}.client.configuration;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Client配置
 * @author sunbo
 */
@ConfigurationProperties(prefix = "${rootArtifactId}")
@Getter
@Setter
public class ClientProperties {

}
