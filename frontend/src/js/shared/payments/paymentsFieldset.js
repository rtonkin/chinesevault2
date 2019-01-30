/**
 * Created by svfat on 4/5/16.
 */
(function () {
    'use strict';
    angular.module('putonghua')
        .directive('paymentsFieldset', function () {
            return {
                restrict: 'E',
                templateUrl: '/static/templates/payments/paymentsFieldset.template.html',
            };
        });

}());