# 数据库配置
spring.datasource.url=jdbc:mysql://172.17.134.7:3306/${dbName}?useUnicode=true&characterEncoding=utf8
spring.datasource.username=zjht_admin
spring.datasource.password=zjhttest

<#if projectType == "Spring Cloud">
# Spring Cloud 配置
spring.cloud.inetutils.preferred-networks=172.17
spring.cloud.inetutils.ignored-interfaces[0]=eth0
eureka.client.service-url.defaultZone=http://172.17.134.56:10000/eureka/
eureka.instance.prefer-ip-address=true
</#if>