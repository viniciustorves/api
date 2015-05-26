(function() {
  'use strict';

  angular.module('app.resources')
    .factory('WizardQuestion', WizardQuestionFactory);

  /** @ngInject */
  function WizardQuestionFactory($resource, ApiService, lodash) {
    var WizardQuestion = $resource(ApiService.routeResolve('wizardQuestionsById'), {
      id: '@id',
      'includes[]': ['wizard_answers']
      }, {
        update: { method: 'PUT' }
      });

    return WizardQuestion;
  }
})();
