angular.module('putonghua')
    .directive('wordInfo', function($window, WordList, PhuaAudio, AppConfig, WordInfoEvents, $rootScope) {
      return {
        restrict: 'E',
        scope: {
          word: '='
        },
        templateUrl: '/static/templates/wordinfo/wordinfo.html',
        link: function (scope, element, attrs) {
            var firstclick = false;
            scope.features = AppConfig.features;
            scope.openAddToListDialog = function () {
                WordList.openAddToListDialog(scope.word);
            };

            scope.playSound = function () {
                PhuaAudio.playSound('word', scope.word.id);
            };

            scope.close = function() {
                $rootScope.$broadcast(WordInfoEvents.WORDINFO_CLOSE);
            };


            angular.element($window).on('click', function (event) {

              if (element[0].contains(event.target)) { 
                return;
              }

              if(!angular.element(event.target).hasClass('texttool-span-no-space') && !angular.element(event.target).hasClass('show-sidebar')) {
                scope.close();
              }
              
              scope.$apply();

            });




            scope.$on('$destroy', function() {

                //TODO: function doesn't unbind
                angular.element($window).unbind('click');
            });

            scope.soundIsPlaying = false;
            $rootScope.$on('word-audio.play', function (event, data) {
              scope.soundIsPlaying = true;
              scope.$apply();
            });
            $rootScope.$on('word-audio.ended', function (event, data) {
              scope.soundIsPlaying = false;
              scope.$apply();
            });

        },
        controller: function ($scope, $element) {
            $scope.uniqueMeanings = [];
            $scope.generateUniqueMeanings = function() {
              $scope.uniqueMeanings = _.chain($scope.word.pinyinSortedMeanings)
                .pluck('meanings')
                .flatten()
                .unique()
                .value();
              };
        }
      };
    });
