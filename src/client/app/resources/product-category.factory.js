(function() {
  'use strict';

  angular.module('app.resources')
    .factory('ProductCategory', ProductCategoryFactory);

  /** @ngInject */
  function ProductCategoryFactory($resource) {
    var ProductCategory = $resource('/api/mock/product_categories/:id');

    return ProductCategory;
  }
})();
