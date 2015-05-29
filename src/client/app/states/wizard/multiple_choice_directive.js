(function() {
  'use strict';

  angular.module('app.components')
    .directive('multipleChoice', MultipleChoiceDirective)

  function MultipleChoiceDirective() {
    return {
      controller: MultipleChoiceDirectiveController,
      link: link,
      restrict: 'E',
      scope: {
        action: "=",
        model: "=",
        options: "=",
      },
      templateUrl: 'app/states/wizard/multiple_choice.html',
    }
  };

  function MultipleChoiceDirectiveController($scope, WIZARD_AUTOSUBMIT, WIZARD_MULTIPAGE) {
    $scope.WIZARD_AUTOSUBMIT = WIZARD_AUTOSUBMIT;
    $scope.WIZARD_MULTIPAGE = WIZARD_MULTIPAGE;
  }

  function link(scope) {
    if(scope.WIZARD_AUTOSUBMIT && scope.WIZARD_MULTIPAGE) {
      scope.$watch('model', function(newValue){
        if(newValue) {
          scope.action()
        }
      })
    }
  };
}());
