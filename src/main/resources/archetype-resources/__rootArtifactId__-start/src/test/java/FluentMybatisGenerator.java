package ${package};

import cn.org.atool.generator.FileGenerator;
import cn.org.atool.generator.annotation.Tables;
import cn.org.atool.generator.annotation.Table;
import org.junit.Test;

public class FluentMybatisGenerator {

    // 数据源 url
    private static final String url = "";

    // 数据库用户名
    private static final String username = "";

    // 数据库密码
    private static final String password = "";

    @Test
    public void generate() {
        // 引用配置类，build方法允许有多个配置类
        FileGenerator.build(Config.class);
    }

    @Tables(
            // 设置数据库连接信息
            url = url, username = username, password = password,
            // 设置entity类生成src目录，相对于 user.dir
            srcDir = "src/main/java",
            // 设置entity类的package值
            basePack = "${package}",
            // 设置dao接口和实现的src目录，相对于 user.dir
            daoDir = "src/main/java",
            // 设置entity结尾
            entitySuffix = "",
            // 设置哪些表要生成Entity文件
            tables = {@Table(value = {"", ""})}
            // , gmtCreated = "gmt_create", gmtModified = "gmt_update"
            // 生成的属性不用字母排序，而是用数据库中定义的
            , alphabetOrder = false
            // 生成的类中不加入注解@Accessors(chain = true)，这个注解加上会将setter带上返回值来达到链式set的目的，但是这样做会导致一些反射工具无法生成PropertyDescriptor从而无法调用setter，比如cglib的bean-copier
            , isSetterChain = false
    )
    static class Config { //类名随便取, 只是配置定义的一个载体
    }
}