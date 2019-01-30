/**
 * Created by svfat on 5/8/16.
 */
(function () {
    angular.module('putonghua')
        .directive('userSuccessSignup', function ($state, $window, api, $stateParams) {
            return {
                restrict: 'E',
                scope: {},
                templateUrl: '/static/templates/users/user-success-signup.html',
                link: function (scope) {
                    scope.options = {
                        paymentFinished: false,
                        paymentSuccess: false
                    };
                    angular.element('.spinner').css('display', 'block');
                    _getDataToSend = function (data) {
                        var possibleKeys = ['number', 'expMonth', 'expYear',
                            'cvc', 'name', 'addressLine1',
                            'addressLine2', 'addressCity',
                            'addressState', 'addressZip',
                            'addressCountry']

                        var camelToSnake = function (str) {
                            return str.replace(/([A-Z])/g, function (m) {
                                return "_" + m.toLowerCase();
                            });
                        };

                        var ret = {};

                        for (i in possibleKeys) {
                            if (data.hasOwnProperty(possibleKeys[i])) {
                                ret[camelToSnake(possibleKeys[i])] = angular.copy(data[possibleKeys[i]]);
                            }
                        }

                        ret['number'] = (ret['number'] || '').replace(/ /g, '');

                        return ret;
                    };

                    makeStripeCall = function (card) {
                        if (!$window.Stripe) {
                            throw 'stripe.js is not installed. Include https://js.stripe.com/v2/ into your html.';
                        }
                        $window.Stripe.createToken(_getDataToSend(card), function () {
                            var args = arguments;
                            if (args[0] == 200 && args[1].id) {
                                api.createSubscription(args[1].id, scope.userData.username).then(function (data) {
                                    scope.options.trialEnd=data.subscription.current_period_end;
                                    scope.options.paymentSuccess = true;
                                    scope.options.paymentFinished = true;
                                    scope.userData.password1 = '';
                                    scope.userData.password2 = '';
                                    scope.userData.card = {};
                                    /* console.log(scope.userData)

                                    console.log('data', data) */
                                    angular.element('.spinner').css('display', 'none');
                                })
                            }
                            else {
                                scope.options.paymentSuccess = false;
                                scope.options.paymentFinished = true;
                            }
                            scope.$apply();
                        });
                    };

                    paidRoutine = function () {
                        makeStripeCall(scope.userData.card);
                    };

                    if (!$stateParams.userData) {
                        $state.go('signup');
                    }
                    else {
                        scope.userData = $stateParams.userData;
                        if (scope.userData.paid) {
                            paidRoutine();
                        }
                    }
                }
            };
        });

})();