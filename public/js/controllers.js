"use strict";

angular.module('myApp').controller('IndexCtrl', function($scope, $http) {
  return $http.get("/api/posts").success(function(data, status, headers, config) {
    return $scope.posts = data.posts;
  });
});

angular.module('myApp').controller('CreatePostCtrl', function($scope, $http, $location) {
  $scope.post = {};
  $scope.savePost = function() {
    return $http.post("/api/post", $scope.post).success(function(data) {
      return $location.path("/");
    });
  };
  return $scope.cancel = function() {
    return $location.path("/");
  };
});

angular.module('myApp').controller('ReadPostCtrl', function($scope, $http, $location, $routeParams, $log) {
  $scope.post = {};
  $scope.comment = {};
  $http.get("/api/post/" + $routeParams.id).success(function(data) {
    return $scope.post = data.post;
  });

  $scope.editDialog = function() {
    show_form();
  };

  $scope.savePost = function() {
    return $http.put("/api/post/" + $routeParams.id, $scope.post).success(function(data) {
      $scope.post = data.post;
      hide_form();
    });
  };

  $scope.cancel = function() {
    // roll back model changes
    $http.get("/api/post/" + $routeParams.id).success(function(data) {
      return $scope.post = data.post;
    });
    hide_form();
  };

  function show_form() {
    $('#edit-post').show();
    $('#view-post').hide();
  };
 
  function hide_form() {
    $('#edit-post').hide();
    $('#view-post').show();
  };



  $scope.deleteDialog = function() {
    $('#my-modal').show();
  };

  $scope.deletePost = function() {
    return $http["delete"]('/api/post/' + $routeParams.id).success(function(data) {
      return $location.url("/");
    });
  };

  $scope.cancelDelete = function() {
    $('#my-modal').hide();
  };

  $scope.saveComment = function() {
    return $http.post('/api/post/' + $routeParams.id + '/newComment', $scope.post).success(function(data) {
      return $scope.post = data.post;
    });
  };
  $scope.deleteComment = function(comment) {
    return $http["delete"]('/api/post/' + $routeParams.id + '/deleteComment/' + comment._id).success(function(data) {
      return $scope.post = data.post;
    });
  };
  $scope.editComment = function(comment) {
    $scope.$log = $log;
    $scope.message = comment;
    return comment.edit = true;
  };
  $scope.changeComment = function(comment) {
    comment.edit = false;
    return $http.put('/api/post/' + $routeParams.id + '/editComment/' + comment._id, comment).success(function(data) {
      return $scope.post = data.post;
    });
  };
});
