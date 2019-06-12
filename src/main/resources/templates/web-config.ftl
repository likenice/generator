package ${packageName};

import com.domes.generatortools.exception.GlobalExceptionHandler;
import com.domes.generatortools.web.HttpRequestFilter;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.springframework.boot.autoconfigure.web.HttpMessageConverters;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;

/**
 * ${classRemark}
 *
 * @author ${author}
 * @date ${date}
 */
@Configuration
public class WebConfig {

    /**
     * 定义SpringMVC的消息转换器，使用FastJson转换请求信息和响应信息
     *
     * @return
     */
    @Bean
    public HttpMessageConverters fastJsonHttpMessageConverters() {
        FastJsonHttpMessageConverter fastConverter = new FastJsonHttpMessageConverter();
        FastJsonConfig fastJsonConfig = new FastJsonConfig();
        fastJsonConfig.setSerializerFeatures(SerializerFeature.PrettyFormat);
        fastConverter.setFastJsonConfig(fastJsonConfig);
        HttpMessageConverter<?> converter = fastConverter;
        return new HttpMessageConverters(converter);
    }

    /**
     * 定义HTTP请求过滤器，输出HTTP请求日志，包括请求参数和执行时间
     *
     */
    @Bean
    public HttpRequestFilter addFilter() {
        return new HttpRequestFilter();
    }

    /**
     * 定义统一的异常处理类，程序内部直接抛出异常即可
     *
     */
    @Bean
    public GlobalExceptionHandler addAdvice() {
        return new GlobalExceptionHandler();
    }
}