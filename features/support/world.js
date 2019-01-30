// features/support/world.js
var zombie = require('zombie');
zombie.waitDuration = '30s';
function World() {
  this.browser = new zombie(); // this.browser will be available in step definitions
  this.visit = function (url, callback) {
    this.browser.visit(url, callback);
  };
}

module.exports = function() {
  this.World = World;
  this.setDefaultTimeout(60 * 1000);
};
