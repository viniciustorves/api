'use strict';

/**@ngInject*/
var ListGroupsController = function() {
  this.groups = [{"id":11,"group_name":"Sonja's Group","email":"group11@bah.com","created_at":"2015-04-07T19:04:56.844Z","updated_at":"2015-04-07T19:34:08.130Z"},
      {"id":15,"group_name":"Garrett's Group","email":"group15@bah.com","created_at":"2015-04-07T19:04:56.679Z","updated_at":"2015-04-07T19:04:56.679Z"},
      {"id":13,"group_name":"Allen's Group","email":"group13@bah.com","created_at":"2015-04-07T19:04:56.510Z","updated_at":"2015-04-07T19:04:56.510Z"},
      {"id":12,"group_name":"Dev Kids of Kacerguis","email":"group12@bah.com","created_at":"2015-04-07T19:04:56.342Z","updated_at":"2015-04-07T19:04:56.342Z"},
      {"id":14,"group_name":"Team Ample Hample","email":"group14@bah.com","created_at":"2015-04-07T19:04:56.173Z","updated_at":"2015-04-07T19:04:56.173Z"];
};

//ListGroupsController.resolve = {
  /**@ngInject*/
//  groups: function(GroupsResource) {
//  return GroupsResource.query().$promise;
//  }
//};

ListGroupsController.prototype = {

};

window.ListGroupsController = ListGroupsController;
