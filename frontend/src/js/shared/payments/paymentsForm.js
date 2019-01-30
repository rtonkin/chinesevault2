/**
 * Created by svfat on 4/5/16.
 */
(function () {
    'use strict';
    angular.module('putonghua')
        .directive('paymentsForm', function (api, ngDialog) {
            return {
                restrict: 'E',
                scope: {
                    getsub: '&cbGetSubscription',
                    name: '=',
                    expMonth: '=',
                    expYear: '=',
                    number: '=',
                    cvc: '=',
                },
                transclude: true,
                templateUrl: '/static/templates/payments/paymentsForm.template.html',
                link: function (scope) {
                    if (scope.getsub == undefined) {
                        alert('getSubscription function undefined');
                    }
                    scope.stripeCallback = function (code, result) {
                        if (result.error) {
                            scope.formError = result.error;
                            ngDialog.open({
                                template: '<div class="panel cards-dialog">'+
                                                '<div class="panel-heading">Please try again</div>'+
                                                '<div class="panel-body p20px text-center">'+
                                                    '<p>There was an error processing your payment.<br/></p>'+
                                                '</div>'+
                                            '</div>',
                                plain: true
                            });
                        } else {
                            api.createSubscription(result.id).then(function (data) {
                                /* console.log('getsub', scope.getsub); */
                                scope.getsub()
                            })
                        }
                    };
                }
            }
        });

}());