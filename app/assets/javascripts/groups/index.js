//= require_tree .
'use strict';

var GroupsModule = angular.module('broker.groups', [])
    .factory('GroupsResource', GroupsResource)
    .directive('groupsBox', GroupsBoxDirective)
    .controller('GroupsController', GroupsController)
    .config(
    /**@ngInject*/
    function($stateProvider) {
        $stateProvider
            .state('base.authed.groups', {
                url: '/groups',
                abstract: true,
                template: '<div class="page groups-page" ui-view></div>',
                controller: 'GroupsController as groupsCtrl'
            });
    }
);

window.GroupsModule = GroupsModule;
