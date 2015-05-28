(function() {
  'use strict';

  angular.module('app.states')
    .run(appRun);

  /** @ngInject */
  function appRun(routerHelper, navigationHelper) {
    routerHelper.configureStates(getStates());
  }

  function getStates() {
    return {
      'wizard.singlepage': {
        controller: singlePageWizardController,
        controllerAs: "vm",
        resolve: {
          question: function(WizardQuestion) {
            return WizardQuestion.get({ id: "first" }).$promise;
          },
          questions: function(WizardQuestion) {
            return WizardQuestion.query().$promise;
          },
        },
        templateUrl: "app/states/wizard/singlepage-wizard/singlepage-wizard.html",
      }
    }
  };

  function singlePageWizardController($stateParams, $state, questions) {
    var vm = this;

    vm.answers = {};
    vm.questions = questions;
    vm.submitAnswers = submitAnswers;
    vm.tags = [];

    function submitAnswers() {
      vm.questions.forEach(function(question) {
        var answer = vm.answers[question.id];
        if(answer) {
          vm.tags = _.union(vm.tags, answer.tags_to_add);
          vm.tags = _.difference(vm.tags, answer.tags_to_remove);
        };
      });

      $state.go(
        "marketplace",
        { projectId: $stateParams.projectId, tags: vm.tags }
      );
    }
  }
})();
