angular.module('putonghua')
    .controller('PaidonlyController', function ($scope, $element, $stateParams, $http, api, Auth, $state) {
        $scope.nextState = $stateParams.nextState;
        $scope.hideSorry = $stateParams.hideSorry;
        if (!$scope.nextState) {
            $scope.nextState = 'home';
        }

        $scope.loggedin = false;
        $scope.usertype = "Error";
            if (Auth.isLoggedIn()) {
                    $scope.loggedin = true;
                } else {
                    $scope.loggedin = false;
                }

            if (Auth.isSubscriber()) {
                    $scope.usertype =  "Paid";
                } else {
                    $scope.usertype = "Free"
                }

    })
;
