
angular.element(document).ready(function() {
  angular.bootstrap(document, ['app']);
});

angular.module( 'app.controllers', [] );
angular.module( 'app.providers', [] );
angular.module( 'app.directives', [] );
angular.module( 'app.services', [] );

var module = angular.module( 'app', [
  'ngRoute',
  'ngCookies',
  'ngAnimate',
  'ngAria',
  'ngSanitize',
  'ngMaterial',
  'app.controllers',
  'app.providers',
  'app.directives',
  'app.services'
]);

module.config( ['$routeProvider', '$locationProvider', 'SessionProvider', 'HttpOptionsProvider',
  function( $routeProvider, $locationProvider, SessionProvider, HttpOptionsProvider) {
  // Turn on HTML5 PushState URL's
  $locationProvider.html5Mode( true );

  $routeProvider
    .when( '/', {
      templateUrl: 'views/home.html',
      controller: 'HomeController',
      public: true,
    })
    .when( '/signup', {
      templateUrl: 'views/sign-up.html',
      controller: 'SignUpController',
      public: true,
    })
    .when( '/main', {
      templateUrl: 'views/main.html',
      controller: 'MainController',
      public: false,
    })
    .when( '/chat', {
      templateUrl: 'views/chat.html',
      controller: 'ChatController',
      public: false,
    })
    .when( '/404', {
      templateUrl: 'views/error/404.html',
      public: true,
    })
    .otherwise({
      redirectTo: '/404'
    });

}]);
