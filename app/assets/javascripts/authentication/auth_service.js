'use strict';

/**@ngInject*/
var AuthService = function($http, $q, $state, Session, apiResource, USER_ROLES) {
  var authService = {};

  authService.ssoInit = function() {
    var deferred = $q.defer();

    $http.get(apiResource('ssoInit'))
      .success(function(response) {
        deferred.resolve(response.url);
      }).error(function() {
        deferred.resolve(false);
      });

    return deferred.promise;
  };

  authService.login = function(credentials) {
    return $http
      .post(apiResource('signIn'), credentials)
      .success(function(data, statusCode) {
        Session.create(data.email, data.role);
      });
  };

  authService.logout = function() {
    return $http
      .delete(apiResource('signOut'))
      .success(function() {
        Session.destroy();
        $state.transitionTo('base.public.login');
      });
  };

  authService.isAuthenticated = function() {
    return !!Session.email;
  };

  authService.isAuthorized = function(authorizedRoles) {
    if (!angular.isArray(authorizedRoles)) {
      authorizedRoles = [authorizedRoles];
    }

    // If authorizedRoles contains 'all', then we allow it through.
    if (authorizedRoles.indexOf(USER_ROLES.all) !== -1) {
      return true;
    } else {
      return (authService.isAuthenticated() && authorizedRoles.indexOf(Session.role) !== -1);
    }
  };

  return authService;
};

window.AuthService = AuthService;
