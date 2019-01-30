angular.module('putonghua')
    .controller('LoginController', function ($scope, $state, $stateParams, $rootScope, $location, $window, AuthEvents, Auth, ngDialog) {
        $scope.credentials = {
            identification: '',
            password: ''
        };
        $scope.formData = null;
        var nextState = $stateParams.nextState;
        var forceLogout = $stateParams.forceLogout;
        if (!nextState) {
            nextState = 'home';
        }

        if (Auth.user != 'AnonymousUser') {
            if (forceLogout) {
                $window.location.href('/accounts/signout');
            }
            $state.go(nextState);
        }
        $scope.login = function () {
            Auth.login($scope.credentials.identification, $scope.credentials.password).then(
                function (response) {
                    $scope.formData = response;
                    if (response.success) {
                        $rootScope.$broadcast(AuthEvents.LOGIN_SUCCESS, response);
                        $state.go(nextState);
                    } else {
                        $rootScope.$broadcast(AuthEvents.LOGIN_FAILURE, response);
                    }
                },
                function (response) {
                    $scope.formData = response;
                    $rootScope.$broadcast(AuthEvents.LOGIN_FAILURE, response);
                }
            );
        };
    })
;
