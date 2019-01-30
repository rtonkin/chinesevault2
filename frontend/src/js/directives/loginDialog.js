angular.module('putonghua')
    .directive('loginDialog', function (ngDialog, AuthEvents) {
        return {
            restrict: 'A',
            link: function (scope) {
                var loginDialog = null;

                var openDialog = function (nextUrl, showMessage) {
                    scope.nextUrl = nextUrl;
                    scope.showMessage = showMessage;
                    loginDialog = ngDialog.open({
                        template: '/static/templates/dialogs/login.html',
                        controller: 'LoginController',
                        className: 'ngdialog-theme-default ngdialog-theme-custom',
                        scope: scope
                    });
                };

                var closeDialog = function () {
                    if (loginDialog) {
                        loginDialog.close();
                    }
                };
/*
                scope.$on(AuthEvents.NOT_AUTHENTICATED, function (event, args) {
                    args = args || {nextUrl: ''};
                    openDialog(args.nextUrl);
                });

                scope.$on(AuthEvents.NOT_AUTHENTICATED_SIGNIN, function (event, args) {
                    args = args || {nextUrl: ''};
                    openDialog(args.nextUrl, true);
                });

                scope.$on(AuthEvents.LOGIN_SUCCESS, function (event, args) {
                    closeDialog(event, args);
                });
*/
            }
        };
    })

;
