/* global toastr:false, moment:false, _:false, $:false */
(function() {
  'use strict';

  angular.module('app.core')
    .constant('lodash', _)
    .constant('jQuery', $)
    .constant('toastr', toastr)
    .constant('WIZARD_AUTOSUBMIT', angular.element('meta[name="wizard-autosubmit"]').attr('content') === 'true')
    .constant('WIZARD_MULTIPAGE', angular.element('meta[name="wizard-multipage"]').attr('content') === 'true')
    .constant('moment', moment);
})();
