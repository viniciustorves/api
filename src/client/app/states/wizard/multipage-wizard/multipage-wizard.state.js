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
      'wizard.multipage': {
        controller: multiPageWizardController,
        controllerAs: "vm",
        resolve: {
          question: function(WizardQuestion) {
            return WizardQuestion.get({ id: "first" }).$promise;
          },
          questions: function(WizardQuestion) {
            return WizardQuestion.query().$promise;
          },
        },
        templateUrl: "app/states/wizard/multipage-wizard/multipage-wizard.html",
      }
    }
  };

  function multiPageWizardController($stateParams, question, questions, WizardQuestion, Projects) {
    var vm = this;

    vm.nextQuestion = nextQuestion;
    vm.projectId = $stateParams.projectId;
    vm.question = question;
    vm.resetWizard = resetWizard;
    vm.tags = [];

    function nextQuestion() {
      vm.tags = _.union(vm.tags, vm.answer.tags_to_add);
      vm.tags = _.difference(vm.tags, vm.answer.tags_to_remove);

      if(vm.question.next_question_id) {
        vm.question.next().then(function(question) {
          vm.question = question;
        });
      } else {
        vm.noMoreQuestions = true;
      }
    };

    function resetWizard() {
      vm.answer = {};
      vm.question = question;
      vm.tags = [];
    };
  }


})();
