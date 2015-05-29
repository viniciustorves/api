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
        controller: StateController,
        controllerAs: 'vm',
        templateUrl: 'app/states/wizard/multipage-wizard/multipage-wizard.html',
      }
    };
  }

  function StateController($stateParams, question, questions, WizardQuestion, Projects, lodash) {
    var vm = this;

    vm.nextQuestion = nextQuestion;
    vm.projectId = $stateParams.projectId;
    vm.question = question;
    vm.resetWizard = resetWizard;
    vm.tags = [];

    function nextQuestion() {
      vm.tags = lodash.union(vm.tags, vm.answer.tags_to_add);
      vm.tags = lodash.difference(vm.tags, vm.answer.tags_to_remove);

      if(vm.question.next_question_id) {
        vm.question.next().then(function(question) {
          vm.question = question;
        });
      } else {
        vm.noMoreQuestions = true;
      }
    }

    function resetWizard() {
      vm.answer = {};
      vm.question = question;
      vm.tags = [];
    }
  }


})();
