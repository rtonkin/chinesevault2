angular.module('putonghua')
    .directive('testPanelNormal', function() {
      return {
        restrict: 'E',
        templateUrl: '/static/templates/practiceWords/testPanelNormal.html'
      };
    });
