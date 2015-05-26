'use strict';

/**@ngInject*/
function ProjectController($scope, $interval, $state, project, OrderItemsResource, alerts, products, FlashesService, WizardQuestionsResource, currentUser) {

  $scope.intervalDelay = 30000;
  $scope.$interval = $interval;
  WizardQuestionsResource.query()
    .$promise.then(function(questions) {
      $scope.wizardPresent = questions.length > 0
    });

  $scope.project = project;
  this.reason = null; // The reason this project has been rejected.

  // Filter the alerts to only show them for this project.
  $scope.alerts = _.filter(alerts, function(alert) {
    return alert.project_id == $scope.project.id;
  });
  this.products = products;

  this.OrderItemsResource = OrderItemsResource;

  this.FlashesService = FlashesService;

  $scope.groups = currentUser.groups;


  /**
   * Project Approval actions
   */
  this.approve = function(project) {
    project.$approve();
    $state.reload();

  };

  this.reject = function(project,reason) {
    project.$reject({reason: reason});
    $state.transitionTo('base.authed.projectHome');
  };

}

ProjectController.resolve = {
  /**@ngInject*/
  project: function(ProjectsResource, $stateParams) {
    return ProjectsResource.get({
      id: $stateParams.projectId,
      'includes[]': ['approvals', 'approvers', 'services', 'memberships', 'groups', 'project_answers']
    }).$promise;
  },
  /**@ngInject*/
  products: function(ProductsResource) {
    return ProductsResource.query().$promise;
  },
  currentUser: function(UsersResource) {
    return UsersResource.getCurrentMember(
      {'includes[]': ['groups']}
    ).$promise;
  }
};

ProjectController.prototype = {
  /**
   * Links the service with the product.
   * @param serviceObject
   * @returns {*}
   */
  getServiceWithProduct: function(serviceObject) {
    var productId = serviceObject.product_id;

    var product = _.find(this.products, function(obj) {
      return obj.id == productId;
    });

    // Hook on the product details we need to use the product box.
    serviceObject.img = product.img;
    serviceObject.name = product.name;
    serviceObject.description = product.description;

    return serviceObject;
  },

  removeServiceFromProject: function(project, service) {
    var self = this,
      serviceIndex = _.findIndex(project.services, service);

    this.OrderItemsResource.delete({id: service.id, order_id: service.order_id}).$promise.then(
      _.bind(function() {
        // Remove it from the existing array.
        project.services.splice(serviceIndex, 1);
        this.FlashesService.add({
          timeout: true,
          type: 'success',
          message: "The service was successfully removed from this project."
        });
      }, this),
      function(error) {
        this.FlashesService.add({
          timeout: true,
          type: 'error',
          message: "There was an error removing this service."
        });
      }
    );
  },

  getLeftData: function(project) {
    var projectBudget = project.budget || 0;
    var projectSpent = project.spent || 0;
    var monthlySpend = project.monthly_spend || 0;

    var leftPercent = 1.0;
    var leftMonths = '>12';
    var leftColor = 'green';

    if (projectBudget > 0 && monthlySpend !== 0 && this._isANumber(monthlySpend)) {

      leftMonths = Math.round((projectBudget - projectSpent) / monthlySpend);
      leftPercent = leftMonths / 12;

      if (leftMonths > 12) {
        leftPercent = 1.0;
      } else if (leftMonths <= 5 && leftMonths > 3) {
        leftColor = '#CCDB23';
      } else if (leftMonths <= 3 && leftMonths > 0) {
        leftColor = 'red';
      } else if (leftMonths <= 0) {
        leftMonths = 0;
        leftPercent = 0.0;
        leftColor = 'red';
      }

      if (leftMonths > 99) {
        leftMonths = '>99';
      }

    }

    return {
      'leftPercent': leftPercent,
      'leftColor': leftColor,
      'leftMonths': leftMonths,
      'monthlySpend': monthlySpend
    };
  },

  getBudgetData: function(project) {
    var projectBudget = project.budget || 0;
    var projectSpent = project.spent || 0;
    var usedPercent = 0.0;
    var usedColor = 'green';

    if (projectBudget > 0) {

      usedPercent = projectSpent / projectBudget;
      if (usedPercent > 1.0) {
        usedPercent = 1.0;
      }

      // Set the colors for usedAmount
      if (usedPercent <= 0.85 && usedPercent > 0.65) {
        usedColor = '#CCDB23';
      } else if (usedPercent >= 0.85) {
        usedColor = 'red';
      }

    }

    return {
      'total': projectBudget,
      'used': projectSpent,
      'usedPercent': usedPercent,
      'usedColor': usedColor
    };
  },

  /**
   * Loops through the resolved order history on the project
   * If any of these orders are not completed, we return false.
   * A completed order is currently equivalent to a service.
   *
   * @private
   */
  _areAllServicesComplete: function(project) {

    // This short circuits on the first non complete item.
    var anyNotComplete = _.some(project.services, function(item, key) {
      // @todo Who nows if this will be the final status.
      return item.provision_status !== 'Complete';
    });

    // We return the reverse here.
    // Are all services complete
    return !anyNotComplete;

  },

  /**
   * Check that a variable is a number and defined (avoids NaN and undefined)
   *
   * http://stackoverflow.com/questions/18082/validate-decimal-numbers-in-javascript-isnumeric
   *
   * @private
   */
  _isANumber: function(n) {
    return (!isNaN(parseFloat(n)) && isFinite(n));
  }
};

window.ProjectController = ProjectController;
