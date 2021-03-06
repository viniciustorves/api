'use strict';

/**@ngInject*/
function NewProjectQuestionController($scope, $state, ProjectQuestion, FlashesService) {
  $scope.projectQuestion = {};
  $scope.pageFunction = $state.params.id;

  $scope.submitProject = function() {
    ProjectQuestion.save($scope.projectQuestion.options ? $scope.projectQuestion : _.omit($scope.projectQuestion, 'options'), function() {
        FlashesService.add({
            timeout: true,
            type: 'success',
            message: 'Project question successfully added.'
        });
        $state.go('base.authed.admin.projects.project_questions', {}, {reload: true});
    }, function () {
        FlashesService.add({
            timeout: true,
            type: 'error',
            message: 'Failed adding project question. Please try again later.'
        });
    });
  };
}

window.NewProjectQuestionController = NewProjectQuestionController;
