(function() {
  'use strict';

  angular.module('app.states')
    .run(appRun);

  /** @ngInject */
  function appRun(routerHelper, navigationHelper, WIZARD_AUTOSUBMIT, WIZARD_MULTIPAGE) {
    routerHelper.configureStates(getStates(WIZARD_AUTOSUBMIT, WIZARD_MULTIPAGE));
  }

  function getStates(WIZARD_AUTOSUBMIT, WIZARD_MULTIPAGE) {
    if (WIZARD_MULTIPAGE) {
      return multiPageWizard;
    } else {
      return singlePageWizard;
    };
  }

  var multiPageWizard = {
    "wizard": {
      controller: multiPageWizardController,
      controllerAs: "vm",
      resolve: {
        question: function(WizardQuestion) {
          return WizardQuestion.get({ id: "first" }).$promise;
        },
        questions: function(WizardQuestion) {
          return WizardQuestion.query().$promise;
        }
      },
      templateUrl: "app/states/wizard/multi_page.html",
      url: "/project/:projectId/wizard",
    }
  };

  var singlePageWizard = {
    "wizard": {
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
        templateUrl: "app/states/wizard/single_page.html",
      url: "/project/:projectId/wizard",
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
        { projectId: $stateParams.projectId, tags: vm.tags.join(',') }
      );
    }
  }
})();
