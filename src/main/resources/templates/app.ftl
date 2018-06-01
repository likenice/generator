package ${packageName};

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
<#if projectType == "Spring Cloud">
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.cloud.netflix.hystrix.EnableHystrix;
<#else>
import org.springframework.boot.autoconfigure.SpringBootApplication;
</#if>
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * ${classRemark}
 *
 * @author ${author}
 * @date ${date}
 */
<#if projectType == "Spring Cloud">
@EnableFeignClients(basePackages = "${basePackage}")
@ComponentScan(basePackages = "cn.zjhf.kingold.cloud")
@EnableHystrix
@SpringCloudApplication
<#else>
@SpringBootApplication
</#if>
@MapperScan("${mapperPackage}")
@EnableSwagger2
public class ${className} {

    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
            .apiInfo(apiInfo())
            .select()
            .apis(RequestHandlerSelectors.basePackage("${packageName}"))
            .paths(PathSelectors.any())
            .build();
    }


    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
            .title("${classRemark}" + " Api Documentation")
            .description("${classRemark}" + " Api Documentation")
            .contact(new Contact("${author}", "", ""))
            .version("1.0.0")
            .build();
    }


    public static void main(String[] args) {
        SpringApplication.run(${className}.class, args);
    }
}