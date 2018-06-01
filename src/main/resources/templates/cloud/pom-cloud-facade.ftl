<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>${projectInfo.groupId}</groupId>
        <artifactId>${projectInfo.artifactId}</artifactId>
        <version>${projectInfo.version}</version>
    </parent>

    <artifactId>${projectInfo.artifactId}-facade</artifactId>
    <name>${projectInfo.artifactId}-facade</name>
    <description>${projectInfo.artifactId}-facade</description>
    <packaging>jar</packaging>

    <dependencies>

        <!-- common-web -->
        <dependency>
            <groupId>com.rent</groupId>
            <artifactId>common-web</artifactId>
            <version>1.0.0-SNAPSHOT</version>
        </dependency>

        <!-- spring-cloud-feign -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-feign</artifactId>
        </dependency>

    </dependencies>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>Dalston.SR4</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <distributionManagement>
        <repository>
            <id>nexus-releases</id>
            <url>http://nexus.zj-hf.cn:8081/nexus/content/repositories/zjinv</url>
        </repository>

        <snapshotRepository>
            <id>nexus-snapshots</id>
            <url>http://nexus.zj-hf.cn:8081/nexus/content/repositories/snapshots</url>
        </snapshotRepository>
    </distributionManagement>

</project>
