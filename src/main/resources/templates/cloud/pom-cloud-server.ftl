<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>${projectInfo.groupId}</groupId>
        <artifactId>${projectInfo.artifactId}</artifactId>
        <version>${projectInfo.version}</version>
    </parent>

    <artifactId>${projectInfo.artifactId}-server</artifactId>
    <name>${projectInfo.artifactId}-server</name>
    <description>${projectInfo.artifactId}-server</description>

    <dependencies>

        <!-- spring-boot-starter -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-logging</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <!-- log4j2 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-log4j2</artifactId>
        </dependency>

        <!-- test -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- facade -->
        <dependency>
            <groupId>${projectInfo.groupId}</groupId>
            <artifactId>${projectInfo.artifactId}-facade</artifactId>
            <version>${projectInfo.version}</version>
        </dependency>

        <!-- common-tool -->
        <dependency>
            <groupId>com.rent</groupId>
            <artifactId>common-tool</artifactId>
            <version>1.0.0-SNAPSHOT</version>
        </dependency>

        <!-- common-mybatis -->
        <dependency>
            <groupId>com.rent</groupId>
            <artifactId>common-mybatis</artifactId>
            <version>1.0.0-SNAPSHOT</version>
        </dependency>

        <!-- 监控 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>

        <#if projectType == "Spring Cloud">
        <!-- spring cloud eureka -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka</artifactId>
        </dependency>

        <!-- spring-cloud-feign -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-feign</artifactId>
        </dependency>

        <!-- spring-cloud-hystrix -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-hystrix</artifactId>
        </dependency>

        <!-- spring-cloud-sleuth-zipkin >
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-sleuth-zipkin</artifactId>
        </dependency-->

        <!-- http client -->
        <dependency>
            <groupId>org.apache.httpcomponents</groupId>
            <artifactId>httpclient</artifactId>
            <version>4.5.3</version>
        </dependency>

        <!-- feign http client -->
        <dependency>
            <groupId>com.netflix.feign</groupId>
            <artifactId>feign-httpclient</artifactId>
            <version>8.18.0</version>
        </dependency>

        </#if>

        <#list dependencies as dependency>
        <!-- ${dependency.name} -->
        <dependency>
            <groupId>${dependency.groupId}</groupId>
            <artifactId>${dependency.artifactId}</artifactId>
            <version>${dependency.version}</version>
        </dependency>

        </#list>

    </dependencies>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${projectInfo.springCloudVersion}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <executions>
                    <execution>
                        <goals>
                            <goal>build-info</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>${projectInfo.javaVersion}</source>
                    <target>${projectInfo.javaVersion}</target>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
