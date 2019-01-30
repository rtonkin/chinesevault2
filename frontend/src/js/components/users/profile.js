angular.module('putonghua')
    .controller('ProfileController', function ($scope, $element, $stateParams, $http, api, Auth, $state) {

        Auth.updateUser().then(function(data){
            $scope.isUnsubscribe = data.unsubscribe_status;
        });

        $scope.countries = [];

        $scope.updateSuccess = false;

        $scope.nextState = $stateParams.nextState;
        if (!$scope.nextState) {
            $scope.nextState = 'home';
        }


        $scope.form = {
            chinese_level: '',
            location: '',
            currentPassword: '',
            password1: '',
            password2: '',
            errors: {}
        };

        $scope.chinese_levels = [
            'Beginner',
            'Intermediate',
            'Advanced'
        ];

        $scope.$watch('form.location', function (newValue, oldValue) {
            setTimeout(function () {
                angular.element('#inputCountry').prop('value', newValue);
            }, 100);
        });

        api.getCountries({limit:0}).then(function (data) {
            /* console.log('Countries: ', data) */
            $scope.countries = data;
            api.getProfile().then(function (data) {
               /*  console.log('Profile: ', data) */
                $scope.form.location = data.user.location ? '' + data.user.location : null;
                $scope.form.chinese_level = data.user.chinese_level;
            });
        });

        $scope.loggedin = false;
        $scope.usertype = "Error";
        $scope.subscriptionRenewalDate = "";
        $scope.subscriptionDetails = "";


        function updateScope() {
            if (Auth.isLoggedIn()) {
                    $scope.loggedin = true;
                } else {
                    $scope.loggedin = false;
                }

            if (Auth.isSubscriber()) {
                    $scope.usertype =  "Paid member";
                    api.getSubscription().then(function(data) {
                        var subscription = data.subscription;
                        $scope.subscriptionRenewalDate = subscription.current_period_end;
                        $scope.subscriptionDetails = 'USD 7/month';
                        });
                } else {
                    $scope.usertype = "Free member"
                }
        }

        updateScope();

        $scope.deleteSubscription = function() {
            $state.go('paymentsConfirmUnsubscribe')
        };

        $scope.updateSubscription = function(args) {
            args = args || {nextState: ''};
            $state.go('checkout', args);
        };

        $scope.renewSubscription = function() {
                api.renewSubscription().then(function(data) {
                    Auth.updateUser().then(function(data){
                    $scope.isUnsubscribe = data.unsubscribe_status;
                    $state.go('profile');
                });
            });
        }
        

        $scope.submit = function () {
            /* console.log('form data....', $scope.form); */
            $http({
                method: 'POST',
                url: '/api/1.0/profile/',
                data: $scope.form,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                transformRequest: function (data) {
                    return $.param(data);
                }
            }).then(
                function response(resp) {
                    /* console.log('response......',resp); */
                    if (resp.data.success) {
                        $scope.updateSuccess = true;
                    } else {
                        $scope.updateSuccess = false;
                        $scope.form.errors = resp.data.errors;
                        setTimeout(function () {
                            $scope.form.errors= {};
                            $scope.$apply();
                        }, 5000)
                    }
                },    
                function failure(data) {
                    alert("We had a network connection problem. Please try again later.");
                }
            );/* .success(function (data) {
                if (data.success) {
                    $scope.updateSuccess = true;
                } else {
                    $scope.form.errors = data.errors;
                }
            }); */
        };
    })
;
