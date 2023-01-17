package ${package}.service.impl;

import ${package}.dto.DemoDTO;
import ${package}.service.DemoService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
public class DemoServiceImpl implements DemoService {

    @Override
    public DemoDTO sayHello(DemoDTO demo) {
        DemoDTO demoDTO = new DemoDTO();
        demoDTO.setMessage("hello " + demo.getMessage());
        return demoDTO;
    }

}