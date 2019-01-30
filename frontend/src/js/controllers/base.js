angular.module('putonghua')
    .controller(
        'BaseController',
        function ($state, $scope, $rootScope, $location, ngDialog, Auth, WordInfoEvents, AuthEvents, AppConfig, $mdSidenav, $http, Restangular) {
            
            $scope.isSidenavOpen = false;
            
            $scope.toggleLeft = function() {
                $mdSidenav('left').toggle();
            };
            $scope.close = function () {
                $mdSidenav('left').close()
            } 

            $rootScope.subscriptionBox = true;
            
            $rootScope.globals = {
                SelectedWord: ''
            };
            $scope.canAddFields = true;

            $scope.makeActive = function (state) {
                $scope.currentState = state;
               /*  console.log(state); */
            }

            $scope.stopscroll = function(){
                var body = angular.element('body');
                body.addClass('stop-scroll');
            }
            $scope.removestop = function(){
                var body = angular.element('body');
                body.removeClass('stop-scroll');
            }
            $rootScope.$watch('globals.SelectedWord', function (value) {
                var wrapper = angular.element('#wrapper');
                var body = angular.element('body');
                $scope.SelectedWord = $rootScope.globals.SelectedWord;
                if (value !== '') {
                    wrapper.addClass('toggle');
                    body.addClass('toggle');
                }
                if (value == '') {
                    wrapper.removeClass('toggle');
                    body.removeClass('toggle');
                }
            });
            $rootScope.$on(WordInfoEvents.WORDINFO_CLOSE, function () {
                $rootScope.globals.SelectedWord = ''
            });
            $scope.login = function (SignIn) {
                if (SignIn === true) {
                    
                    $rootScope.$broadcast(AuthEvents.NOT_AUTHENTICATED_SIGNIN);
                }
                else {
                   /*  console.log('login reuired'); */
                    $rootScope.$broadcast(AuthEvents.NOT_AUTHENTICATED);
                }
            };
            $scope.features = AppConfig.features; // features enabled

           
            $scope.chinese = '/'


            $scope.form = {
                newsletter_email: ''
            };
            
            
            $scope.newsLetterSuccess = false;
    
            $scope.submitNewsletterForm = function () {
                /* console.log('form data.', $scope.form); */
                if($scope.form.newsletter_email != ""){
                    $http({
                        method: 'POST',
                        url: '/newsletteradd/',
                        data: $scope.form,
                        transformRequest: function (data) {
                            return $.param(data);
                        }
                    }).then(
                        function response(resp) {
                            if (resp.data.success) {
                                $scope.newsLetterSuccess = true;
                                $scope.msg = resp.data.message;                               
                            } else {
                                $scope.newsLetterSuccess = false;
                                $scope.msg = resp.data.message;                                
                            }
                        },
            
                        function failure(data) {
                            alert("We had a network connection problem. Please try again later.");
                        }
                    );/* .success(function (response) {
                        if (response.success) {
                            $scope.newsLetterSuccess = true;
                            $scope.msg = response.message;
                        } else {
                            $scope.newsLetterSuccess = false;
                        }
                    }); */
                }
            };           

        }
    );