// ----------------------------------------
// App
// ----------------------------------------


var MyApp = angular.module('MyApp', ['ui.router', 'restangular']);

// Service for Lodash/Underscore
MyApp.factory('_', ['$window', function($window) {
  return $window._;
}]);


// CSRF support
MyApp.config(
  ["$httpProvider",
  function($httpProvider) {
    var token = $('meta[name=csrf-token]')
      .attr('content');
    $httpProvider
      .defaults
      .headers
      .common['X-CSRF-Token'] = token;
  }]);


// Restangular config
MyApp.config(
  ['RestangularProvider',
  function(RestangularProvider) {

    RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.setRequestSuffix('.json');

  }]);


// UI-Router config
MyApp.config(
  ['$stateProvider', '$urlRouterProvider',
  function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/messages');

    $stateProvider
      .state('messages', {
        url: '/messages',
        controller: 'MessagesCtrl',
        templateUrl: '/templates/messages/index.html'
      });

  }]);


// MessagesCtrl
MyApp.controller('MessagesCtrl',
  ['_', '$scope', 'Restangular',
  function(_, $scope, Restangular) {

    // Get all messages from messages#index
    $scope.messages = Restangular
      .all('messages')
      .getList()
      .$object;


    // Create a message
    $scope.createMessage = function() {
      Restangular.all('messages')
        .post({
          message: {
            body: 'Hello Angular, Restangular and Rails goodness!'
          }
        })
        .then(function(response) {
          console.log(response);

          // Prepend to list
          $scope.messages.unshift(response);
          return response;
        });
    };


    // Destroy a message
    $scope.destroyMessage = function(message) {
      message.remove()
        .then(function(response) {
          var index = _.findIndex($scope.messages, function(msg) {
            return response.id === msg.id;
          });

          // Remove from list
          $scope.messages.splice(index, 1);
          return response;
        });
    };

  }]);


