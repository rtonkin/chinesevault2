(function () {
    angular.module('putonghua', ['ngDialog',
        'ngMaterial',
        'ngCookies',
        'ui.router',
        'restangular',
        'ngSanitize',
        'blockUI',
        'com.2fdevs.videogular',
        'com.2fdevs.videogular.plugins.controls',
        'com.2fdevs.videogular.plugins.overlayplay',
        'com.2fdevs.videogular.plugins.poster',
        'angularPayments',
        'ngAnimate',
        'ngScrollbars',
        'ui.bootstrap',
        'ui.router.metatags',
        'ngClickCopy',
        'cl.paging'
    ]);

    angular.module('putonghua')
        .config(function (RestangularProvider) {
            RestangularProvider.setBaseUrl('/api/1.0/');
            RestangularProvider.setDefaultHeaders({'Content-Type': 'application/json'});
            RestangularProvider.setResponseExtractor(function (response, operation, what, url) {
                var newResponse;
                if (operation === 'getList') {
                    newResponse = response.objects;
                    newResponse.metadata = response.meta;
                } else {
                    newResponse = response;
                }
                return newResponse;
            });
            RestangularProvider.setRequestSuffix('/?');
        })
        .config(function (ScrollBarsProvider) {
            // the following settings are defined for all scrollbars unless the 
            // scrollbar has local scope configuration 
            ScrollBarsProvider.defaults = {
                scrollButtons: {
                    scrollAmount: 'auto', // scroll amount when button pressed 
                    enable: true // enable scrolling buttons by default 
                },
                scrollInertia: 400, // adjust however you want 
                axis: 'yx', // enable 2 axis scrollbars by default, 
                theme: 'dark',
                autoHideScrollbar: true
            };
        })

        .config(function ($httpProvider, $locationProvider, $interpolateProvider, blockUIConfig, $windowProvider, $qProvider) {
            $qProvider.errorOnUnhandledRejections(false);
            $httpProvider.interceptors.push([
                '$injector',
                function ($injector) {
                    return $injector.get('AuthInterceptor');
                }
            ]);
            $locationProvider.html5Mode(true);
            // $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
            $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
            $httpProvider.defaults.xsrfCookieName = 'csrftoken';
            $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken';

            $interpolateProvider.startSymbol('{$');
            $interpolateProvider.endSymbol('$}');
            // Change the default delay to 500ms before the blocking is visible
            blockUIConfig.delay = 500;
            blockUIConfig.autoBlock = true;
            blockUIConfig.requestFilter = function(config) {

                if(config.url.match(/^\/api\/1.0\/word\/search($|\/).*/)) {
                    return false; // ... don't block it.
                }
            };

           var $window = $windowProvider.$get();
           $window.Stripe.setPublishableKey('pk_live_jePyfu0lZshJHQPUhwxvYLEG');
            /* $window.Stripe.setPublishableKey('pk_test_LUQpRtLdkfQfGCHpHpSpnC5P'); */

            
        })
        .constant('AuthEvents', {
            LOGIN_SUCCESS: 1,
            LOGIN_FAILURE: 2,
            LOGOUT_SUCCESS: 3,
            LOGOUT_FAILURE: 4,
            SESSION_TIMEOUT: 5,
            NOT_AUTHENTICATED: 6,
            NOT_AUTHORIZED: 7,
            NOT_AUTHENTICATED_SIGNIN: 8,
            NOT_SUBSCRIBER: 9
        })
        .constant('WordInfoEvents', {
            WORDINFO_CLOSE: 1,

        })
         .constant('AppConfig', {
            // Store app config here
            features: {
                dictionary: true,
                flashcards: true,
                textTool: true,
                lessons: true,
                studyContent: true,
                users: true
            }
        })
        .factory('AuthInterceptor', function ($rootScope, $q, AuthEvents) {
            return {
                responseError: function (response) {
                    $rootScope.$broadcast({
                        401: AuthEvents.NOT_AUTHENTICATED
                    }[response.status], response);
                    return $q.reject(response);
                }
            };
        })

        .run(
            function ($http, $cookies, $rootScope, $state, api, Auth, AuthEvents, WordInfoEvents, ngDialog, $window, $location, $transitions) {

                $http.defaults.headers.post['X-CSRFToken'] = $cookies.csrftoken;

                // Global variables
                $rootScope.csrftoken = $cookies.csrftoken;
                $rootScope.auth = Auth;
                $rootScope.path = $state.href;
                $rootScope.usernameValidationPattern = $('meta[name="validation:username"]').attr('content');
                $rootScope.$on("$locationChangeSuccess", function () {
                    window.scrollTo(0, 0);    //scroll to top of page after each route change
                    /* console.log("location change occur",$state.current.name) */
                    $rootScope.subscriptionBox = true;                    
                    if($state.current.name == 'login' || $state.current.name == 'signup' || $state.current.name == 'paidonly' || $state.current.name == 'contact' || $state.current.name == 'about' || $state.current.name == 'terms-of-use' || $state.current.name == 'privacy-policy' || $state.current.name == 'profile' ){
                        $rootScope.subscriptionBox = false;
                    }
                });

                //$rootScope.$state = $state;

                $rootScope.redirect = function (path) {
                    ngDialog.closeAll();
                    location.assign(path);
                };

                /* $rootScope.$on('$stateChangeStart', function (event, stateParams) {
                
                    console.log('111111111111')
                    $rootScope.$broadcast(WordInfoEvents.WORDINFO_CLOSE);
                    Auth.updateUser().then(function () {
                       
                        if (stateParams.requireLogin && !Auth.isLoggedIn()) {
                            console.log('not logged in');
                            event.preventDefault();
                            $rootScope.$broadcast(AuthEvents.NOT_AUTHENTICATED, {nextState: stateParams.name});
                        }
                        else if (stateParams.requireSubscription && !Auth.isSubscriber()) {
                            console.log('no subscr');
                            event.preventDefault();
                            $rootScope.$broadcast(AuthEvents.NOT_SUBSCRIBER, {nextState: stateParams.name});
                        }
                    });
                }); */

                $transitions.onStart( { }, function(trans) {
                   /*  console.log("transition state..........", trans.to()) */
                   
                    $rootScope.$broadcast(WordInfoEvents.WORDINFO_CLOSE);
                    Auth.updateUser().then(function () {
                    
                        if (trans.to().requireLogin && !Auth.isLoggedIn()) {
                            /* console.log('not logged in'); */
                            //event.preventDefault();
                            $rootScope.$broadcast(AuthEvents.NOT_AUTHENTICATED, {nextState: trans.to().name});
                        }
                        else if (trans.to().requireSubscription && !Auth.isSubscriber()) {
                           /*  console.log('no subscr'); */
                            //event.preventDefault();
                            $rootScope.$broadcast(AuthEvents.NOT_SUBSCRIBER, {nextState: trans.to().name});
                        }
                    });
                });

                $rootScope.$on(AuthEvents.NOT_AUTHENTICATED, function (event, args) {
                    args = args || {nextState: ''};
                    $state.go('login', args)
                });
                $rootScope.$on(AuthEvents.NOT_AUTHENTICATED_SIGNIN, function (event, args) {
                    args = args || {nextState: ''};
                    $state.go('login', args)
                });
                $rootScope.$on(AuthEvents.NOT_SUBSCRIBER, function (event, args) {
                    args = args || {nextState: ''};
                    $state.go('paidonly', args)
                });
                $rootScope.$on('$stateChangeSuccess', function (event) {
                    $window.ga('send', 'event', 'User_go_to', 'User_go_to', $location.path());
                    $window.ga('send', 'pageview', $location.path());
                });
                api.init();
            }
        )
        .controller('ForgotPasswordController', function ($scope, $http, $location, $cookies, ngDialog, Restangular) {
            $scope.email = '';

            $scope.submitForm = function () {
                var resourceName = 'accounts/password/reset';
                Restangular.all(resourceName)
                          .post({email: $scope.email});
            };
        })

        .controller('SignupDialogController', function ($scope, $http) {

        })
    ;
})();
