"use strict";angular.module("yoAgainApp",["ngAnimate","ngCookies","ngResource","ngRoute","ngSanitize","ngTouch","ui.sortable"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/test",{templateUrl:"views/test.html",controller:"TestCtrl"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).otherwise({redirectTo:"/"})}]),angular.module("yoAgainApp").controller("MainCtrl",["$scope",function(a){a.todos=[],a.addTodo=function(){a.todos.push(a.todo),a.todo=""},a.removeTodo=function(b){a.todos.splice(b,1)}}]),angular.module("yoAgainApp").controller("AboutCtrl",["$scope",function(a){a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("yoAgainApp").controller("TestCtrl",["$scope","$http",function(a,b){b.get("http://localhost:5002/test").success(function(b){a.items=b})}]);