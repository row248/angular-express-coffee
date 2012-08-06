"use strict"

# LogCtrl = ($scope, $log) ->
#   $scope.$log = $log
#   $scope.message = 'Hello World!'


angular.module("myApp", [ "myApp.filters", "myApp.services", "myApp.directives" ]).config [ "$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider.when("/",
    templateUrl: "/partials/index"
    controller: IndexCtrl
  ).when("/post/:id",
    templateUrl: "/partials/viewPost"
    controller: ReadPostCtrl
  ).when("/newPost",
    templateUrl: "/partials/newPost"
    controller: CreatePostCtrl
  ).when("/editPost/:id",
    templateUrl: "/partials/editPost"
    controller: EditPostCtrl
  ).when("/deletePost/:id",
    templateUrl: "/partials/deletePost"
    controller: DeletePostCtrl
  ).otherwise redirectTo: "/"
  $locationProvider.html5Mode true
 ]

