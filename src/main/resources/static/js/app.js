'use strict';

var myApp = angular.module('app', ['ui.bootstrap', 'ui.router', 'smart-table', 'toaster', 'ngAnimate', 'jsonFormatter']);

myApp.controller('AppCtrl', ['$scope', '$http', '$state', function($scope, $http, $state) {
    console.log('AppCtrl');

    $scope.app = {
        name:"Spring Cloud Quicker",
        version:"1.0.0"
    }
}]);