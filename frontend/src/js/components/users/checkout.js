/*app
.controller("CheckoutController",function() {
          this.doCheckout = function(token) {
            alert("Got Stripe token: " + token.id);
          };
        });*/
angular.module('putonghua')
    .controller(
        'CheckoutController',
        function ($scope, api, Auth, $state, $stateParams) {
            // Stripe Response Handler
            $scope.getSubscription = function() {
              api.getSubscription().then(function(data) {
                $scope.subscription = data.subscription;
                Auth.updateUser();
              });

            }

            $scope.goNextState = function() {
                var nextState = $stateParams.nextState;
                if (!nextState) {
                    nextState = 'home';
                }

                $state.go(nextState);
            };

            $scope.subscription = null;
            $scope.getSubscription();

        }
    )
;
