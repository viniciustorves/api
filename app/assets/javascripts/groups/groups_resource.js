'use strict';

/**@ngInject*/
var GroupsResource = function($resource, apiResource, $state) {
    return $resource(apiResource('groupsById'), {'id': '@id'}, {
        // Get Single
        get: {
            method: 'GET',
            isArray: false
        },
        // Get All
        query: {
            method: 'GET',
            isArray: true
        },
        'update': {
            method: 'PUT'
        }
    });

    /**
     * @todo This is probably not a good representation of what will be needed for
     *        groups, but will keep here for the general idea.
     */
    /*
     Users.prototype.fullName = function() {
     return [this.first_name, this.last_name].join(' ');
     };

     Users.prototype.isAdmin = function() {
     return this.role === 'admin';
     };*/
};

window.GroupsResource = GroupsResource;
