'use strict';

/**@ngInject*/
var FooterController = function(footerLinks, APP_CONFIG) {

  this.footerLinks = footerLinks;
  this.copyrightYear = new Date();
  this.jellyfishVersion = APP_CONFIG.version;
};

FooterController.resolve = {
  /**@ngInject*/
  footerLinks: function(currentUser, SettingsResource) {
    return {};
  }
};

FooterController.prototype = {

};

window.FooterController = FooterController;



