'use strict';

angular.module('app').controller('ObjectController', ['$scope', '$http', '$state', function($scope, $http, $state) {

    // 数据库连接
    $scope.dbType = 'MySQL';
    $scope.dbIP = '10.10.10.174';
    $scope.dbPort = '3306';
    $scope.dbName = 'luth';
    $scope.dbUsername = 'zj_admin';
    $scope.dbPassword = '123456';

    // 数据库表
    $scope.tables = [];
    $scope.fields = [];

    // 待生成代码的数据库表
    $scope.tableList = [];

    // 包信息
    $scope.author = 'robot';
    $scope.projectDir = '/Users/likenice/workspace_xiyu/xiyu_demo';
    $scope.replaced = false;
    $scope.javaDir = 'src/main/java';
    $scope.resourcesDir = 'src/main/resources';
    $scope.testDir = 'src/test';
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

    // 添加实体
    $scope.add = function () {

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
            'artifactId': null
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
        param.databaseInfo = databaseInfo;
        param.tables = $scope.tableList;
        param.packageInfo = packageInfo;

        var jsonString = JSON.stringify(param);

        $http.post("/api/object", jsonString).success(function(data) {
            if (data.code == 200) {
                window.alert(data.data);
            } else {
                window.alert(data.message);
            }
        }).error(function (data) {
            console.log('data=' + data);
        });
    };

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