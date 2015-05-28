(function() {
  'use strict';

  angular.module('app.resources')
    .factory('Tag', TagFactory);

  /** @ngInject */
  function TagFactory($resource) {
    var Tag = $resource('/api/mock/tags/:id', {}, {
      grouped: {
        url: '/api/mock/tags/grouped',
        method: 'GET',
        isArray: false
      }
    });

    return Tag;
  }
})();
