(function() {
  'use strict';

  angular.module('app.states')
    .run(appRun);

  /** @ngInject */
  function appRun(routerHelper, navigationHelper, WIZARD_MULTIPAGE) {
    routerHelper.configureStates(getStates(WIZARD_MULTIPAGE));
  }

  function getStates(WIZARD_MULTIPAGE) {
    return {
      'wizard': {
        url: '/project/:projectId/wizard',
        redirectTo: WIZARD_MULTIPAGE ? 'wizard.multipage' : 'wizard.singlepage',
        template: '<ui-view></ui-view>'
      }
    };
  }
})();
