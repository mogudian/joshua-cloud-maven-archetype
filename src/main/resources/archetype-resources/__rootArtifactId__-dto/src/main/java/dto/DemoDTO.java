package ${package}.dto;

import lombok.Getter;
import lombok.Setter;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@ApiModel(value = "示例DTO")
@Getter
@Setter
public class DemoDTO {

    @ApiModelProperty(value = "消息")
    private String message;

}