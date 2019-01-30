/**
 * Created by svfat on 4/5/16.
 */
angular.module('putonghua').controller('SignupController', function ($scope, $window, $state, $location, $http, api, $stateParams, Auth, ngDialog) {
    if (Auth.isLoggedIn()) {
        $location.path('/');
    }

    $scope.signupSuccess = false;
    $scope.countries = [];
    $scope.chinese_levels = [
        'Beginner',
        'Intermediate',
        'Advanced'
    ];
    /* console.log("email id.........", $stateParams.email); */
    $scope.form = {
        paid: false,
        paymentSuccess: false,
        username: '',
        email: $stateParams.email,
        password1: "",
        password2: "",
        location: "",
        chinese_level: "",
        errors: {}
    };

    api.getCountries({limit: 0}).then(function (countries) {
        $scope.countries = countries;
    });



    $scope.submitSignupForm = function () {

        $http({
            method: 'POST',
            url: '/api/1.0/signup/',
            data: $scope.form,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function (data) {
                return $.param(data);
            }
        }).then(
            function response(resp) {
                if (resp.data.success) {
                    $scope.signupSuccess = true;
                    $state.go('userSuccessSignup', {userData: $scope.form})
                } else {
                    $scope.form.errors = resp.data.errors;
                    /* console.log('submitSignupForm-error', $scope.form.errors); */
                    setTimeout(function () {
                        $scope.form.errors= {};
                        $scope.$apply();
                    }, 5000)
                }
            },

            function failure(data) {
                alert("We had a network connection problem. Please try again later.");
            }
        );

    };
});