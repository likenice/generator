# 数据库配置
spring.datasource.url=jdbc:mysql://10.10.10.174:3306/${dbName}?useUnicode=true&characterEncoding=utf8&useSSL=false
spring.datasource.username=zj_admin
spring.datasource.password=123456

<#if projectType == "Spring Cloud">
# Spring Cloud 配置
spring.cloud.inetutils.preferred-networks=10.10.10
eureka.client.service-url.defaultZone=http://10.10.10.77:10000/eureka/
eureka.instance.prefer-ip-address=true
eureka.instance.instance-id=${r'${spring.cloud.client.ipAddress}'}:${r'${spring.application.name}'}:${r'${server.port}'}
</#if>