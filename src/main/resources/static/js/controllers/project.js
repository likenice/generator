'use strict';

angular.module('app').controller('ProjectController', ['$scope', '$http', '$state', function($scope, $http, $state) {

    console.log('ProjectController 1.0.2');

    // 基本信息
    $scope.groupId = 'com.domes';
    $scope.artifactId = 'service-demo';
    $scope.port = '9090';
    $scope.version = '1.0.0';
    $scope.description = 'Demo project for Spring Cloud';
    $scope.javaVersion = '1.8';
    $scope.springBootVersion = '1.5.8.RELEASE';
    $scope.springCloudVersion = 'Dalston.SR4';

    // 项目类型
    $scope.projectType = 'Spring MVC';
    $scope.projectTypeList = [
        "Spring MVC",
        "Spring Boot",
        "Spring Cloud"
    ];

    // 项目依赖
    $scope.dependencies = [];

    // 数据库连接
    $scope.dbType = 'MySQL';
    $scope.dbIP = '192.168.2.171';
    $scope.dbPort = '3306';
    $scope.dbName = 'test';
    $scope.dbUsername = 'root';
    $scope.dbPassword = 'Urwork_123!';

    // 数据库表
    $scope.tables = [];
    $scope.fields = [];

    // 待生成代码的数据库表
    $scope.tableList = [];

    // 包信息
    $scope.author = 'wangxun';
    $scope.projectDir = '/Users/likenice/workspace_xiyu/' + $scope.artifactId;
    $scope.javaDir = 'src/main/java';
    $scope.resourcesDir = 'src/main/resources';
    $scope.testDir = 'src/test/java';
    $scope.basePackage = 'com.domes.service.user';
    $scope.configPackage = 'config';
    $scope.controllerPackage = 'controller';
    $scope.servicePackage = 'service';
    $scope.daoPackage = 'dao';
    $scope.entityPackage = 'entity';
    $scope.dtoPackage = 'dto';
    $scope.voPackage = 'vo';

    // 表类型/主键类型/主表名称/连接字段名称
    $scope.tableType = 'Single';
    $scope.tableTypeList = [
        "Single",
        "SubTable"
    ];
    $scope.primaryKeyFieldType = 'NONE';
    $scope.keyTypeList = [
        "NONE",
        "ID",
        "UUID"
    ];
    $scope.masterTableName = '';
    $scope.masterFieldName = '';

    $scope.sortTypeList = [
        "None",
        "ASC",
        "DESC"
    ];

    // 数据库表展开
    $scope.maxRows = 100;
    $scope.row_status = [];
    for (var i = 0; i < $scope.maxRows; i++) {
        $scope.row_status[i] = true;
    }

    $scope.resetRowStatus = function () {
        for (var i = 0; i < $scope.row_status.length; i++) {
            $scope.row_status[i] = true;
        }
    };

    // 生成项目
    $scope.save = function () {
        // 依赖的项目
        $scope.dependencyList = new Array();
        angular.forEach ($scope.dependencies, function (dependency, index) {
            if (dependency.selected) {
                var item = {
                    'name': null,
                    'groupId': null,
                    'artifactId': null,
                    "version":null
                };
                item.name = dependency.artifactId;
                item.groupId = dependency.groupId;
                item.artifactId = dependency.artifactId;
                item.version = dependency.version;
                $scope.dependencyList.push(item);
            }
        });

        // 封装请求参数
        var param = {
            'projectInfo': null,
            'dependencies': null,
            'databaseInfo': null,
            'tables': null,
            'packageInfo': null
        };

        var projectInfo = {
            'groupId': null,
            'artifactId': null,
            'port': null,
            'version': null,
            'name': null,
            'description': null,
            'javaVersion': null,
            'springBootVersion': null,
            'springCloudVersion': null,
            'projectType': null
        };

        var databaseInfo = {
            'dbType': null,
            'dbIP': null,
            'dbPort': null,
            'dbName': null,
            'dbUsername': null,
            'dbPassword': null
        };

        var packageInfo = {
            'basePackage': null,
            'configPackage': null,
            'controllerPackage': null,
            'servicePackage': null,
            'daoPackage': null,
            'entityPackage': null,
            'dtoPackage': null,
            'voPackage': null,
            'author': null,
            'projectPath': null,
            'javaPath': null,
            'resourcePath': null,
            'testPath': null
        };

        projectInfo.groupId = $scope.groupId;
        projectInfo.artifactId = $scope.artifactId;
        projectInfo.port = $scope.port;
        projectInfo.version = $scope.version;
        projectInfo.name = $scope.artifactId;
        projectInfo.description = $scope.description;
        projectInfo.javaVersion = $scope.javaVersion;
        projectInfo.springBootVersion = $scope.springBootVersion;
        projectInfo.springCloudVersion = $scope.springCloudVersion;
        projectInfo.projectType = $scope.projectType;

        databaseInfo.dbType = $scope.dbType;
        databaseInfo.dbIP = $scope.dbIP;
        databaseInfo.dbPort = $scope.dbPort;
        databaseInfo.dbName = $scope.dbName;
        databaseInfo.dbUsername = $scope.dbUsername;
        databaseInfo.dbPassword = $scope.dbPassword;

        packageInfo.basePackage = $scope.basePackage;
        packageInfo.configPackage = $scope.configPackage;
        packageInfo.controllerPackage = $scope.controllerPackage;
        packageInfo.servicePackage = $scope.servicePackage;
        packageInfo.daoPackage = $scope.daoPackage;
        packageInfo.entityPackage = $scope.entityPackage;
        packageInfo.dtoPackage = $scope.dtoPackage;
        packageInfo.voPackage = $scope.voPackage;
        packageInfo.author = $scope.author;
        packageInfo.projectPath =$scope.projectDir;
        packageInfo.javaPath =$scope.javaDir;
        packageInfo.resourcePath = $scope.resourcesDir;
        packageInfo.testPath = $scope.testDir;

        param.projectInfo = projectInfo;
        param.dependencies = $scope.dependencyList;
        param.databaseInfo = databaseInfo;
        param.tables = $scope.tableList;
        param.packageInfo = packageInfo;

        var jsonString = JSON.stringify(param);

        $http.post("/api/project/save", jsonString).success(function(data) {
            if (data.code == 200) {
                window.alert(data.data);
            } else {
                window.alert(data.message);
            }
        }).error(function (data) {
            console.log('data=' + data);
        });
    };

    $scope.initDefaultDependency = function() {

        // var fastjson = [];
        // fastjson.selected = true;
        // fastjson.name = 'fastjson';
        // fastjson.groupId = 'com.alibaba';
        // fastjson.artifactId = 'fastjson';
        // fastjson.version = '1.2.32';

        // var mybatis = [];
        // mybatis.selected = true;
        // mybatis.name = 'mybatis';
        // mybatis.groupId = 'org.mybatis.spring.boot';
        // mybatis.artifactId = 'mybatis-spring-boot-starter';
        // mybatis.version = '1.3.0';
        //
        // var mybatis_tk = [];
        // mybatis_tk.selected = true;
        // mybatis_tk.name = 'mybatis_tk';
        // mybatis_tk.groupId = 'tk.mybatis';
        // mybatis_tk.artifactId = 'mapper-spring-boot-starter';
        // mybatis_tk.version = '1.1.5';
        //
        // var mybatis_page = [];
        // mybatis_page.selected = true;
        // mybatis_page.name = 'mybatis_page';
        // mybatis_page.groupId = 'com.github.pagehelper';
        // mybatis_page.artifactId = 'pagehelper-spring-boot-starter';
        // mybatis_page.version = '1.2.3';

        // var mysql = [];
        // mysql.selected = true;
        // mysql.name = 'mysql';
        // mysql.groupId = 'mysql';
        // mysql.artifactId = 'mysql-connector-java';
        // mysql.version = '5.1.40';
        //
        // var druid = [];
        // druid.selected = true;
        // druid.name = 'druid';
        // druid.groupId = 'com.alibaba';
        // druid.artifactId = 'druid';
        // druid.version = '1.0.18';

        // var common = [];
        // common.selected = true;
        // common.name = 'common';
        // common.groupId = 'cn.zjhf.kingold.cloud';
        // common.artifactId = 'kingold-common';
        // common.version = '1.0.0-SNAPSHOT';

        var rocket_mq = [];
        rocket_mq.selected = false;
        rocket_mq.name = 'rocketmq';
        rocket_mq.groupId = 'cn.zjhf.kingold';
        rocket_mq.artifactId = 'spring-boot-starter-rocketmq';
        rocket_mq.version = '1.0.2';

        var service_consumer = [];
        service_consumer.selected = false;
        service_consumer.name = 'service_consumer';
        service_consumer.groupId = 'cn.zjhf.kingold';
        service_consumer.artifactId = 'service-consumer';
        service_consumer.version = '1.1';

        // var lombok = [];
        // lombok.selected = true;
        // lombok.name = 'lombok';
        // lombok.groupId = 'org.projectlombok';
        // lombok.artifactId = 'lombok';
        // lombok.version = '1.16.14';

        // var guava = [];
        // guava.selected = true;
        // guava.name = 'guava';
        // guava.groupId = 'com.google.guava';
        // guava.artifactId = 'guava';
        // guava.version = '22.0';

        // var jolokia = [];
        // jolokia.selected = true;
        // jolokia.name = 'jolokia';
        // jolokia.groupId = 'org.jolokia';
        // jolokia.artifactId = 'jolokia-core';
        // jolokia.version = '1.3.7';

        // $scope.dependencies.push(fastjson);
        // $scope.dependencies.push(guava);
        // $scope.dependencies.push(jolokia);
        // $scope.dependencies.push(lombok);
        // $scope.dependencies.push(mybatis);
        // $scope.dependencies.push(mybatis_tk);
        // $scope.dependencies.push(mybatis_page);
        // $scope.dependencies.push(mysql);
        // $scope.dependencies.push(druid);
        // $scope.dependencies.push(common);
        $scope.dependencies.push(service_consumer);
        $scope.dependencies.push(rocket_mq);
    };

    $scope.initDefaultDependency();

    // 测试数据源
    $scope.testDBConnection = function () {
        var param = {
            'dbType': null,
            'dbIP': null,
            'dbPort': null,
            'dbName': null,
            'dbUsername': null,
            'dbPassword': null
        };

        param.dbType = $scope.dbType;
        param.dbIP = $scope.dbIP;
        param.dbPort = $scope.dbPort;
        param.dbName = $scope.dbName;
        param.dbUsername = $scope.dbUsername;
        param.dbPassword = $scope.dbPassword;

        var jsonString = JSON.stringify(param);

        $http.post("/api/database/connect", jsonString).success(function(data) {
            if (data.code == 200) {
                window.alert("成功！")
            } else {
                window.alert(data.message)
            }
        }).error(function (data) {
            console.log('data=' + data);
        });
    };

    // 读取表的列表
    $scope.readTables = function () {
        var param = {
            'dbType': null,
            'dbIP': null,
            'dbPort': null,
            'dbName': null,
            'dbUsername': null,
            'dbPassword': null
        };

        param.dbType = $scope.dbType;
        param.dbIP = $scope.dbIP;
        param.dbPort = $scope.dbPort;
        param.dbName = $scope.dbName;
        param.dbUsername = $scope.dbUsername;
        param.dbPassword = $scope.dbPassword;

        var jsonString = JSON.stringify(param);

        $http.post("/api/database/tables", jsonString).success(function(data) {
            if (data.code == 200) {
                $scope.resetRowStatus();
                $scope.tables = data.data;
            } else {
                window.alert(data.message)
            }
        }).error(function (data) {
            console.log('data=' + data);
        });
    };

    // 读取表的详情
    $scope.select = function (index, table) {
        if (!$scope.row_status[index]) {
            $scope.row_status[index] = !$scope.row_status[index];
        } else {
            var param = {
                'dbType': null,
                'dbIP': null,
                'dbPort': null,
                'dbName': null,
                'dbUsername': null,
                'dbPassword': null
            };

            param.dbType = $scope.dbType;
            param.dbIP = $scope.dbIP;
            param.dbPort = $scope.dbPort;
            param.dbName = $scope.dbName;
            param.dbUsername = $scope.dbUsername;
            param.dbPassword = $scope.dbPassword;

            var jsonString = JSON.stringify(param);
            var tableName = table.name;
            $http.post("/api/database/tables/" + tableName, jsonString).success(function(data) {
                if (data.code == 200) {
                    $scope.resetRowStatus();
                    $scope.fields = data.data;
                    $scope.row_status[index] = !$scope.row_status[index];

                    // primary key type
                    $scope.primaryKeyFieldType = "NONE";
                    angular.forEach ($scope.fields, function (field, index) {
                        if (field.primaryKey) {
                            if (field.typeName == 'BIGINT' || field.typeName == 'BIGINT UNSIGNED') {
                                $scope.primaryKeyFieldType = "ID";
                            } else if (field.typeName == 'CHAR' || field.typeName == 'VARCHAR') {
                                $scope.primaryKeyFieldType = "UUID";
                            } else {
                                console.log("Unknown primary key type = " + field.typeName);
                            }
                        }
                    });
                } else {
                    window.alert(data.message)
                }
            }).error(function (data) {
                console.log('data=' + data);
            });
        }
    };

    // 添加数据库表到待生成列表
    // tableType: 单表，主表，子表
    // keyType: ID，UUID
    // masterTableName: 主表名称
    // masterFieldName: 主表主键字段名称
    $scope.addTable = function (table, tableType, keyType, masterTableName, masterFieldName) {
        var found = false;
        angular.forEach ($scope.tableList, function (tableItem, index) {
            if (tableItem.name == table.name) {
                found = true;
            }
        });

        if (found) {
            window.alert('"' + table.name + '"表已经存在');
            return;
        }

        var tableInfo = {
            'name': null,
            'remark': null,
            'type': null,   // Single/Main/Sub
            'key': null,
            'keyType': null,
            'main': null,
            'join': null,
            'query': null,
            'order': null
        };

        var primaryKeyFieldName = '';
        var keyList = new Array();
        angular.forEach ($scope.fields, function (field, index) {
            if (field.key) {
                keyList.push(field.columnName);
            }
        });

        var queryList = new Array();
        angular.forEach ($scope.fields, function (field, index) {

            if (field.query) {
                queryList.push(field.columnName);
            }


            if (field.primaryKey) {
                primaryKeyFieldName = field.columnName;
            }
        });

        var orderByList = new Array();
        angular.forEach ($scope.fields, function (field, index) {
            if (field.order != 'None') {
                var item = {
                    'field': field.columnName,
                    'sort': field.order
                };
                orderByList.push(item);
            }
        });


        tableInfo.name = table.name;
        tableInfo.remark = table.remark;
        tableInfo.type = tableType;
        tableInfo.key = primaryKeyFieldName;
        tableInfo.keyType = keyType;
        tableInfo.main = masterTableName;
        tableInfo.join = masterFieldName;
        tableInfo.query = queryList;
        tableInfo.order = orderByList;

        $scope.tableList.push(tableInfo);
    };

    // 移除待生成的数据库表
    $scope.removeTable = function (table) {
        for(var i=0; i<$scope.tableList.length; i++) {
            if ($scope.tableList[i].name == table.name) {
                $scope.tableList.splice(i, 1);
                break;
            }
        }
    };

}]);