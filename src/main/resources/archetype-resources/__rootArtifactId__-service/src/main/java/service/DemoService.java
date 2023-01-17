package ${package}.service;

import ${package}.dto.DemoDTO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Api(tags = "示例接口")
@RequestMapping("/demo")
public interface DemoService {

    @ApiOperation(value = "打招呼")
    @PostMapping("/say-hello")
    DemoDTO sayHello(@ApiParam(value = "参数名", required = true) @RequestBody DemoDTO demo);

}