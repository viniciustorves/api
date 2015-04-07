'use strict';

/**@ngInject*/
var LeftSidebarController = function($state, currentUser, projects, products, AuthService) {
  this.currentUser = currentUser;
  this.projects = projects;
    this.products = products;

  this.AuthService = AuthService;
  this.$state = $state;
};

LeftSidebarController.prototype = {
  logout: function() {
    return this.AuthService.logout();
  }
};

LeftSidebarController.resolve = {
  /**@ngInject*/
  projects: function(currentUser, ProjectsResource) {
      console.log(ProjectsResource.query().$promise);
      return ProjectsResource.query().$promise;
  },

  products: function(currentUser, ProductsResource) {
      console.log(ProductsResource.query().$promise);
      return ProductsResource.query().$promise;
  }
};


window.LeftSidebarController = LeftSidebarController;

