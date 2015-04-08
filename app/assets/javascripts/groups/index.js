//= require_tree .
'use strict';

var GroupsModule = angular.module('broker.groups', [])
    .factory('GroupsResource', GroupsResource)
    .controller('GroupsController', GroupsController)//Might want to include the users_box_directive.js sort of shindig
    //for ui outside of the admin tab
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
