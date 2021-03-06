'use strict';

/**@ngInject*/
function ListProductsController(products, categories) {
  var self = this;

  this.products = products;
  this.categories = categories;

  _.each(this.categories, function(category) {
    category.products = _.filter(self.products, function(product) {
      return product.product_type == category.title;
    });
  });
}

ListProductsController.resolve = {
  /**@ngInject*/
  products: function(ProductsResource) {
    return ProductsResource.query().$promise;
  }
};

window.ListProductsController = ListProductsController;
