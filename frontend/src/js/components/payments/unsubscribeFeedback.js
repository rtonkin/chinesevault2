/**
 * Created by svfat on 5/11/16.
 */
(function () {
angular.module('putonghua')
    .directive('paymentsUnsubscribeFeedback', function (api, $state)  {
      return {
        restrict: 'E',
        scope: {
        },
        templateUrl: '/static/templates/payments/payments_unsubscribe_feedback.html',
        link: function (scope, attr, elem) {
            scope.form = {
                reason:''
            };
            scope.cancelSubscription = function () {
                api.postReason(scope.form.reason);
                $state.go('paymentsCancellation');
            };
        }
      };
    });

})();