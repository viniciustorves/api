(function() {
  'use strict';

  angular.module('app.resources')
    .factory('Product', ProductFactory);

  /** @ngInject */
  function ProductFactory($resource, ApiService) {
    var Product = $resource(ApiService.routeResolve('productsById'), {id: '@id'}, {
      update: {method: 'PUT'}
    });

    Product.defaults = {
      name: '',
      description: '',
      active: true,
      setup_price: '0.0',
      monthly_price: '0.0',
      hourly_price: '0.0',
      tags: [],
      properties: {}
    };

    return Product;
  }
})();
