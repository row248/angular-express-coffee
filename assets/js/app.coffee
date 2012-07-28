"use strict"

# LogCtrl = ($scope, $log) ->
#   $scope.$log = $log
#   $scope.message = 'Hello World!'


IndexCtrl = ($scope, $http) ->
  $http.get("/api/posts").success (data, status, headers, config) ->
    $scope.posts = data.posts


ReadPostCtrl = ($scope, $http, $routeParams, $log) ->
  $scope.post = {}
  $scope.comment = {}
  $http.get("/api/post/" + $routeParams.id).success (data) ->
    $scope.post = data.post
    # $scope.post.comments 
  $scope.saveComment = ->
    $http.post('/api/post/' + $routeParams.id + '/newComment', $scope.post).success (data) ->
      $scope.post = data.post

  $scope.deleteComment = (comment) ->
    $http.delete('/api/post/' + $routeParams.id + '/deleteComment/' + comment._id).success (data) ->
      $scope.post = data.post

  $scope.editComment = (comment) ->
    $scope.$log = $log
    $scope.message = comment
    comment.edit = true;

  $scope.changeComment = (comment) ->
    comment.edit = false;
    $http.put('/api/post/' + $routeParams.id + '/editComment/' + comment._id, comment).success (data) ->
      $scope.post = data.post




CreatePostCtrl = ($scope, $http, $location) ->
  $scope.post = {}
  $scope.savePost = ->
    $http.post("/api/post", $scope.post).success (data) ->
      $location.path "/"
  $scope.cancel = ->
    $location.path "/"


EditPostCtrl = ($scope, $http, $location, $routeParams) ->
  $scope.post = {}
  $http.get("/api/post/" + $routeParams.id).success (data) ->
    $scope.post = data.post

  $scope.savePost = ->
    $http.put("/api/post/" + $routeParams.id, $scope.post).success (data) ->
      $location.url "/viewPost/" + $routeParams.id
  $scope.cancel = ->
    $location.path "/"


DeletePostCtrl = ($scope, $http, $location, $routeParams) ->
  $http.get("/api/post/" + $routeParams.id).success (data) ->
    $scope.post = data.post
  
  $scope.deletePost = ->
    $http.delete('/api/post/' + $routeParams.id).success (data) ->
      $location.url "/"
  $scope.cancel = ->
    $location.path "/"




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

