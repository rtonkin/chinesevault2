/**
 * Created by svfat on 5/11/16.
 */
(function () {
angular.module('putonghua')
    .directive('paymentsCancellation', function (api, Auth)  {
      return {
        restrict: 'E',
        scope: {
        },
        templateUrl: '/static/templates/payments/payments_cancellation.html',
        link: function (scope, attr, elem) {
            scope.subscriptionStatus = {};
            scope.subscriptionStatus.active = true;
            api.deleteSubscription().then(function(data) {
                    Auth.updateUser().then(function(user) {
                        scope.subscriptionStatus.cancel_date = user.canceled_at;
                        scope.subscriptionStatus.active = false;
                    });
              }).catch(function(err) {
                    console.error(err.stack);
                });
        }
      };
    });

})();