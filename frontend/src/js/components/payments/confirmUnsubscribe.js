/**
 * Created by svfat on 5/11/16.
 */
(function () {
angular.module('putonghua')
    .directive('paymentsConfirmUnsubscribe', function ($state)  {
      return {
        restrict: 'E',
        scope: {
        },
        templateUrl: '/static/templates/payments/payments_confirm_unsubscribe.html',
        link: function (scope, attr, elem) {
            scope.cancelSubscription = function () {
                $state.go('paymentsUnsubscribeFeedback');

            };
            scope.continueSubscription = function () {
                $state.go('profile');
            };
        }
      };
    });

})();