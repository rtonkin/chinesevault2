angular.module('putonghua')
    .controller('ContactController', function ($scope, $location, $http) {
        $scope.form = {
            name: '',
            email: '',
            subject: '',
            message: '',
            errors: {}
        };

        $scope.contactSuccess = false;
        /* console.log('name........', $scope.form.name)
        console.log('email..........', $scope.form.email) */
        $scope.submitForm = function () {
            $http({
                method: 'POST',
                url: '/contact/',
                data: $scope.form,
                transformRequest: function (data) {
                    return $.param(data);
                }
            }).then(
                function response(resp) {
                    if (resp.data.success) {
                        $scope.contactSuccess = true;
                        $scope.contactSuccess
                    } else {
                        $scope.form.errors = resp.data.errors;
                        $scope.contactSuccess = false;
                    }
                },    
                function failure(data) {
                    alert("We had a network connection problem. Please try again later.");
                }
            );/* .success(function (response) {
                if (response.success) {
                    $scope.contactSuccess = true;
                } else {
                    $scope.form.errors = response.errors;
                }
            }); */
        };
    });
