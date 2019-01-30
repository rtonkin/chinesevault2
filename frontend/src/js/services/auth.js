angular.module('putonghua')
    .factory('Auth', ["api", "$http", "$rootScope", "AuthEvents", "$q", function (api, $http, $rootScope, AuthEvents, $q) {
        var Auth = {
            'user':null
        };

        Auth.updateUser = function() {
            var defer = $q.defer();
            api.getProfile().then(function(data) {
                /* console.log("User here",data); */
                    if (data != undefined) {
                        Auth.user = data.user;
                        defer.resolve(Auth.user);
                    } else {
                        defer.reject('Error while fetching data for user Profile');
                    }
            });
            return defer.promise;
        };


        Auth.login = function (identification, password) {
            return $http({
                method: 'POST',
                url: '/api/1.0/login/',
                data: {
                    'identification': identification,
                    'password': password
                },
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},

                transformRequest: function (data) {
                    return $.param(data);
                }
            }).then(
                function done(response) {

                    response = response.data;

                    if (response.success) {
                        angular.element('meta[name="user.username"]').attr('content', response.data.uname);
                        angular.element('meta[name="user.email"]').attr('content', response.data.email);
                        Auth.user = response.data;
                        /* console.log('User login', Auth.user); */
                    }

                    return response;
                },

                function interrupted(response) {
                    response = response.data;
                    return response;
                }
            );
        };

        Auth.requireLogin = function (nextUrl) {
            /* console.log('require login..........'); */
            $rootScope.$broadcast(AuthEvents.NOT_AUTHENTICATED, {nextUrl: nextUrl});
        };
        Auth.requireSubscription = function (nextUrl) {
            $rootScope.$broadcast(AuthEvents.NOT_SUBSCRIBER, {nextUrl: nextUrl});
        };

        Auth.isLoggedIn = function () {
            return !!angular.element('meta[name="user.username"]').attr('content');
        };

        Auth.isSubscriber = function() {
            if (Auth.user != null) {
                return Auth.user.has_active_subscription;
            }
            else {
                Auth.updateUser().then(
                        function() {
                            /* console.log('Updated', Auth.user); */
                        }
                    );
                return Auth.user.has_active_subscription;
            }
        };

        Auth.getUser = function () {
            return {
                'username': angular.element('meta[name="user.username"]').attr('content'),
                'email': angular.element('meta[name="user.email"]').attr('content')
            };
        };

        return Auth;
    }])

;
