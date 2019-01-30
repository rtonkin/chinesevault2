angular.module('putonghua')
    .controller('WordDetailController', function ($scope, $rootScope, $stateParams, searchcacheService, $state, ngDialog, api, Auth, WordList, SentenceList, PhuaAudio, AppConfig, $timeout) {
        $scope.features = AppConfig.features;
        $scope.wordId = $stateParams.wordId;

        $scope.loggingPlus = function () {
            $scope.currentPage = $scope.currentPage + 1
            if (($scope.currentPage + 1) == Math.ceil($scope.word.exampleSentences.length / $scope.pageSize)) {
                api.getWord($scope.wordId, {
                    examples: 1,
                    offset: $scope.word.exampleSentences.length
                })
                    .then(function (word) {
                        for (var i = 0; i < word.exampleSentences.length; i++) {
                            $scope.word.exampleSentences.push(word.exampleSentences[i]);
                            $scope.word.exampleSentences[$scope.word.exampleSentences.length - 1].simple = convertToAngular($scope.word.exampleSentences[$scope.word.exampleSentences.length - 1].simple);
                        }
                        /*for (var i = 0; i < $scope.word.exampleSentences.length; i++) {
                            $scope.word.exampleSentences[i].simple = convertToAngular($scope.word.exampleSentences[i].simple);
                        } */
                    });
            }
        }

        $scope.loggingMinus = function () {
            $scope.currentPage = $scope.currentPage - 1;
        }

        $scope.word = {
            'simplified': '',
            'traditional': '',
            'meaning_references': [],
            'exampleSentences': []
        };

        $scope.query = '';
        $scope.categories = [];
        $scope.destinationCategory = $scope.categories[0];

        api.getCategoriesFast().then(function (items) {

            /* console.log("category list.....",items) */

            $scope.categories = items;
            $scope.destinationCategory = items[0];
        });

        $scope.options = {
            characters: 'simplified'
        };
        function convertToAngular(html) {
            var template_1 = '<span class=\"texttool-span-no-space chinese-hoverable\" ng-click=\"selectWord($event)\">';
            var template_2 = '</span>';
            return html.replace(/<chinese>/g, template_1).replace(/<\/chinese>/g, template_2);
        };

        // preload word without example sentences to speedup UI then load ex.sent.
        api.getWord($scope.wordId, { examples: 1 }).then(function (word) {
            $scope.word = word;

            for (var i = 0; i < $scope.word.exampleSentences.length; i++) {
                $scope.word.exampleSentences[i].simple = convertToAngular($scope.word.exampleSentences[i].simple);
            }
            var definStr = "";
            var definitions = $scope.word.meanings_references.slice(0, 4);

            for (var i = 0; i < definitions.length; i++) {
                definStr += definitions[i] + ", ";
            }
            definStr = definStr.slice(0, -2);
            var description = $scope.word.simplified + ' – ' + $scope.word.pinyin_normalized + ' – ' + definStr;
            var allMetaElements = document.getElementsByTagName('meta');

            document.title = 'Definitions of ' + $scope.word.simplified + ' – ' + $scope.word.pinyin_normalized + ' – Free Chinese / English Dictionary – ChineseVault.com';

            for (var i = 0; i < allMetaElements.length; i++) {
                if (allMetaElements[i].getAttribute("name") == "description") {
                    allMetaElements[i].setAttribute('content', description);
                } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                    allMetaElements[i].setAttribute('content', "chinese definitions, English chinese dictionary, chinese example sentences, chinese audio");
                }
            }

        });

        $scope.openAddToListDialog = WordList.openAddToListDialog;
        $scope.openAddToSentenceListDialog = SentenceList.openAddToListDialog;

        $scope.playSound = PhuaAudio.playSound;
        /* $scope.playSound = function (dataType, dataId, event) {

            var thisEvent = $(event.target)
            var test = thisEvent.closest('td').next().find('span').eq(0).text()

            console.log(test)

            var promise1 = searchcacheService.getData(test);
            promise1.then(function (result) {  // this is only run after $http completes
                if (result) {
                    $rootScope.globals.SelectedWord = result;

                    console.log(result)
                }
            });

            var resource, getVoice = null;
            resource = dataType;
            if (dataType == 'word') { getVoice = api.getWordVoice(dataId); }
            else if (dataType == 'sentence') { getVoice = api.getSentenceVoice(dataId); }
            getVoice.then(function (data) {
                var audio = new Audio(data.url);
                audio.play();
                audio.addEventListener('play', function () { $rootScope.$broadcast(resource + '-audio.play', this); });
                audio.addEventListener('ended', function () { $rootScope.$broadcast(resource + '-audio.ended', this); });
            });



        }; */


        $scope.playSoundd = PhuaAudio.playSoundd;

        // TODO: refactor
        $scope.soundIsPlaying = false;
        $scope.soundIsPlayingg = false;

        $scope.$on('word-audio.play', function (event, data) {
            $scope.soundIsPlaying = true;
            $scope.$apply();
        });
        $scope.$on('word-audio.ended', function (event, data) {
            $scope.soundIsPlaying = false;
            $scope.$apply();
        });

        $scope.$on('word-audio.playy', function (event, data) {
            $scope.soundIsPlayingg = true;
            $scope.$apply();
        });
        $scope.$on('word-audio.endedd', function (event, data) {
            $scope.soundIsPlayingg = false;
            $scope.$apply();
        });


        $scope.sentenceSoundIsPlaying = false;

        $scope.$on('sentence-audio.play', function (event, data) {
            $scope.sentenceSoundIsPlaying = true;
            $scope.$apply();
        });
        $scope.$on('sentence-audio.ended', function (event, data) {
            $scope.sentenceSoundIsPlaying = false;
            $scope.$apply();
        });

        $scope.isOpenCharInfo = false;

        $scope.showCharacterInfo = function (char) {
            $scope.isOpenCharInfo = !$scope.isOpenCharInfo;
            // var WIDTH = 400; //px
            // var HEIGHT = 400; //px

            // CdlUtils.getSvgPathStrings('你', {
            //   width: WIDTH,
            //   height: HEIGHT,
            //   apiKey: 'y5PiH9p4jUJfzfHrBUXGP5f1'
            // }).then(function(pathStrings) {
            //   drawFannedChar('target-element', pathStrings);
            // });

            // var drawFannedChar = function(targetId, pathStrings) {
            //   var svg = SVG(targetId);
            //   var numStrokes = pathStrings.length;
            //   var widthPerGroup = HEIGHT / numStrokes;
            //   var heightPerGroup = WIDTH / numStrokes;

            //   var pathStringsUpToNow = [];
            //   pathStrings.forEach(function(pathString, i) {
            //     pathStringsUpToNow.push(pathString);
            //     var group = svg.group();
            //     group.rect(WIDTH, HEIGHT).fill('none').stroke('#999');
            //     pathStringsUpToNow.forEach(function(currentPathString) {
            //       group.path(currentPathString).fill('#333');
            //     });
            //     group.scale(0.95 * (1/numStrokes)).translate(i*widthPerGroup, 0);
            //     svg.text('' + (i + 1))
            //       .font({
            //         size: '10px'
            //       })
            //       .cx((i + 0.5) * widthPerGroup)
            //       .y(heightPerGroup)
            //       .fill('#AAA');
            //   });
            // };
        }

        $scope.setOption = function (option, value) {
            $scope.options[option] = value;
            return false;
        };

        $scope.classForOption = function (option, value) {
            if ($scope.options[option] == value) {
                return 'active';
            }
            return '';
        };

        var searchDelayWord;

        $scope.submitQuery = function () {
            $scope.$watch('query', function () {
                $timeout.cancel(searchDelayWord);
                searchDelayWord = $timeout(function () {
                    localStorage.setItem('querystring', $scope.query);
                    $state.go('dictionary', { 'q': $scope.query });
                }, 2000)
            })
        };

        $scope.currentPage = 0;
        $scope.pageSize = 4;
        $scope.numberOfPages = function () {
            if ($scope.word.exampleSentences === undefined) {
                return 0;
            }
            else {
                return Math.ceil($scope.word.exampleSentences.length / $scope.pageSize);
            }
        };

        $scope.selectWord = function selectWord(event) {

            $($scope.oldTarget).removeClass('texttool-hgltd');
            $scope.oldTarget = event.target;
            $(event.target).addClass('texttool-hgltd');
            var promise = searchcacheService.getData(event.target.innerText);
            promise.then(function (result) {  // this is only run after $http completes
                if (result) {
                    $rootScope.globals.SelectedWord = result;
                    /* console.log(result) */
                }
            });
        };


    })
    ;
