(function() {
  'use strict';

  angular.module('app.states')
    .run(appRun);

  /** @ngInject */
  function appRun(routerHelper, navigationHelper) {
    routerHelper.configureStates(getStates());
    navigationHelper.navItems(navItems());
    navigationHelper.sidebarItems(sidebarItems());
  }

  function getStates() {
    return {
      'admin.wizard-questions.list': {
        url: '', // No url, this state is the index of admin.products
        templateUrl: 'app/states/admin/wizard-questions/list/list.html',
        controller: WizardQuestionsController,
        controllerAs: 'vm',
        title: 'Admin Wizard Quesiton List',
        resolve: {
          questions: function(WizardQuestion) {
            return WizardQuestion.query().$promise;
          }
        }
      }
    };
  }

  function navItems() {
    return {};
  }

  function sidebarItems() {
    return {};
  }

  /** @ngInject */
  function WizardQuestionsController(questions, WizardQuestion, logger, $q, $state) {
    var vm = this;

    vm.questions = questions;
    vm.question = new WizardQuestion({wizard_answers: [{}]});
    vm.createQuestion = createQuestion;
    vm.addAnswer = addAnswer;

    _.each(questions, addAnswer);

    function createQuestion() {
      vm.question.wizard_answers = formatAnswers(vm.question.wizard_answers);
      vm.question.$save(function(question){
        vm.question.id = question.id;
        vm.questions.push(vm.question);
        vm.question = new WizardQuestion({wizard_answers: [{}]});
      });
    }

    vm.deleteQuestion = function(question) {
      question.$delete(function(question){
        vm.questions = _.without(vm.questions, question)
      });
    }

    function addAnswer(question) {
      question.wizard_answers.push({});
    }

    vm.deleteAnswer = function(question, answer) {
      answer["_destroy"] = true
    }

    vm.saveQuestion = function(question) {
      question.wizard_answers = formatAnswers(question.wizard_answers);
      console.log(question.$save)
      question.$update();
    }

    function formatAnswers(answers){
      return _.map(answers, function(answer) {
        if(typeof answer.tags_to_add === "string") {
          answer.tags_to_add = answer.tags_to_add.split(",");
        }

        if(typeof answer.tags_to_remove === "string") {
          answer.tags_to_remove = answer.tags_to_remove.split(",");
        }

        return answer;
      });
    }
  }
})();
