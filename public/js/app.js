'use strict';

angular.module('myApp', ['myApp.filters', 'myApp.services', 'myApp.directives']).config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider
    .when('/', {
      templateUrl: '/partials/index',
      controller: 'IndexCtrl'
    })
    .when('/post/:id', {
      templateUrl: '/partials/viewPost',
      controller: 'ReadPostCtrl'
    })
    .when('/newPost', {
      templateUrl: '/partials/newPost',
      controller: 'CreatePostCtrl'
    })
    .otherwise({
      redirectTo: '/'
    });
    return $locationProvider.html5Mode(true);
  }
]);
