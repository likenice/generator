# 切换环境
spring.profiles.active=dev

# 服务端口
server.port=${servicePort?c}

# 日志配置
logging.config=classpath:log4j2.xml

# mybatis配置
#mybatis.config-location=classpath:mybatis/mybatis-config.xml
mybatis.mapper-locations=classpath:mybatis/mapper/*.xml
mybatis.type-aliases-package=${entityPackage}

# mapper配置
mapper.not-empty=false
mapper.identity=MYSQL
# 为了返回自动生成的UUID
mapper.before=true
mapper.mappers=com.domes.dao.CrudMapper,com.domes.dao.InsertUuidListMapper

# pagehelper配置
pagehelper.helperDialect=mysql
# 先执行 select count()
pagehelper.row-bounds-with-count=true
# 不合理的页面信息返回空数据
pagehelper.reasonable=false
# offset,limit
pagehelper.offset-as-page-num=false
pagehelper.supportMethodsArguments=true
pagehelper.params=count=countSql

# 数据源配置
spring.datasource.type=com.alibaba.druid.pool.DruidDataSource
spring.datasource.driver-class-name=com.mysql.jdbc.Driver

# 关闭自动热部署
spring.devtools.restart.enabled=false

# actuator接口使用的端口
#management.port=${managePort?c}

# actuator接口不需要密码验证
management.security.enabled=false

# 启用actuator的shutdown
endpoints.shutdown.enabled=true

# actuator的shutdown接口是否需要密码验证
endpoints.shutdown.sensitive=false

# actuator的health接口是否需要密码验证
endpoints.metrics.sensitive=false

# actuator的health接口是否需要密码验证
endpoints.health.sensitive=false

<#if projectType == "Spring Cloud">
# 开启hystrix
feign.hystrix.enabled=true

# 使用httpclient，解决@FeignClient的GET方法使用对象参数的问题
feign.httpclient.enabled=true

# 配置Hystrix的超时时间为5秒，默认1秒
hystrix.command.default.execution.isolation.thread.timeoutInMilliseconds=5000
</#if>