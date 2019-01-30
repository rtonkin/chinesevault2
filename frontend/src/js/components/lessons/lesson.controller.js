angular.module('putonghua')
    .controller('LessonListController', function ($scope, api) {

        document.title = "Free Chinese Lessons - ChineseVault.com";

        var allMetaElements = document.getElementsByTagName('meta');
        
        for (var i = 0; i < allMetaElements.length; i++) { 
            if (allMetaElements[i].getAttribute("name") == "description") { 
                allMetaElements[i].setAttribute('content', "A series of over 30 completely free Chinese lessons for beginners. Learn the basic vocabulary and sentence structures to get you speaking basic Chinese in no time."); 
            } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                allMetaElements[i].setAttribute('content', "free chinese lessons, online chinese lessons, free chinese, mandarin lessons, free mandarin lessons, learn chinese"); 
            }
        }
        /* $scope.baseUrl = 'https://chinesevault.com'; */
        $scope.lessons = [];
        api.getLessons().then(function (lessons) {
            /* console.log('OUR Lesson', lessons); */
            $scope.lessons = lessons;

        });
        $scope.switchLearnedStatus = function switchLearnedStatus(number) {
            api.switchLessonStatus(number).then(function () {
                for(var i = 0; i < $scope.lessons.length; i++)
                {
                  if($scope.lessons[i].number == number)
                  {
                    $scope.lessons[i].lesson_completed = !$scope.lessons[i].lesson_completed;
                  }
                }
            });
        };
    })

    .controller('LessonDetailController', function ($scope, api, $stateParams, $state, $sce, searchcacheService, WordList, PhuaAudio, $rootScope, $location) {
        $scope.playSound = PhuaAudio.playSound;
        var convertToAngular = function (html) {
            var template_1 = '<span class=\"texttool-span-no-space chinese-hoverable\" ng-click=\"selectWord($event)\">';
            var template_2 = '</span>';
            return html.replace(/<chinese>/g, template_1).replace(/<\/chinese>/g, template_2);
        };

        $scope.oldTarget = null;
        $scope.lessonNumber = $stateParams.lessonNumber;
        var previousLessonNumber = parseInt($scope.lessonNumber, 10) - 1;
        var nextLessonNumber = parseInt($scope.lessonNumber, 10) + 1;
        $scope.lesson = null;
        $scope.previousLesson = null;
        $scope.nextLesson = null;
        api.getLesson($scope.lessonNumber).then(function (data) {
            var tmp_lesson =  data;
            /*  we have some chinese text now, and we want to add some angular bindings to work with it */
            tmp_lesson.new_words_converted = JSON.parse(tmp_lesson.new_words_converted);
            tmp_lesson.word_usage = convertToAngular(tmp_lesson.word_usage);
            tmp_lesson.example_sentences = convertToAngular(tmp_lesson.example_sentences);
            $scope.lesson = tmp_lesson;
            /* console.log($scope.lesson); */
            document.title = $scope.lesson.name + " - Free Chinese Lessons - ChineseVault.com";
        })
        .catch(function () {
            $state.go('lesson');
        });
        $scope.init = function () {
            setTimeout(function () {
                var parent = angular.element('.simplified .chinese-hoverable').addClass('chinese-text');
            },0)
        }
        $scope.clickclick = function ( cid ) {
			$location.path('/page/'+cid);
		};
        api.getLesson(previousLessonNumber).then(function (data) {
            $scope.previousLesson = data;
        });
        api.getLesson(nextLessonNumber).then(function (data) {
            $scope.nextLesson = data;
        });
        $scope.status = {
             'newwords':true,
             'wordusage':false,
             'examplesentences':false
            };
        $scope.statusSelect = function statusSelect(status) {
            $scope.status.newwords = false;
            $scope.status.wordusage = false;
            $scope.status.examplesentences = false;
             $scope.status[status] = true;
            $scope.selectedWord = null;
        };
        $scope.selectWordFromDictionary = function selectWordFromDictionary(word) {
            var promise = searchcacheService.getData(word);
              promise.then(function(result) {  // this is only run after $http completes
                   if (result) {
                            $scope.globals.SelectedWord = result;
                        }
                });
        };
        $scope.selectWord = function selectWord(event) {
            $($scope.oldTarget).removeClass('texttool-hgltd');
            $scope.oldTarget = event.target;
            $(event.target).addClass('texttool-hgltd');
            var promise = searchcacheService.getData(event.target.innerText);
              promise.then(function(result) {  // this is only run after $http completes
                   if (result) {
                            $scope.globals.SelectedWord = result;
                        }
                }); 
        };
        $scope.openAddToListDialog = WordList.openAddToListDialog;
        $scope.completeLesson = function (lessonNumber) {
            api.completeLesson(lessonNumber);
            $state.go('lesson');
        }
    });
