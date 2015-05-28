(function() {
  'use strict';

  angular.module('mock')
    .run(mock);

  function mock($httpBackend) {
    $httpBackend.whenGET(/^(?!\/api\/mock\/).+$/).passThrough();
    $httpBackend.whenDELETE(/^(?!\/api\/mock\/).+$/).passThrough();
    $httpBackend.whenPUT(/^(?!\/api\/mock\/).+$/).passThrough();
    $httpBackend.whenPOST(/^(?!\/api\/mock\/).+$/).passThrough();
  }
})();
