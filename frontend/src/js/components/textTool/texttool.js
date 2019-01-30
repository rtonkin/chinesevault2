angular.module('putonghua')
 .controller(
        'TextToolController',
        function ($window, $scope, $rootScope, $http, $location, $q, ngDialog, WordList, searchcacheService, PhuaAudio) {

            document.title = "Chinese Text Reader - ChineseVault.com";

            $scope.pinyinCharsArr = [
                {char: "ā", code: "&#257;"},
                {char: "á", code: "&#225;"},
                {char: "ǎ", code: "&#462;"},
                {char: "à", code: "&#462;"},
                {char: "ē", code: "&#275;"},
                {char: "é", code: "&#233;"},
                {char: "ě", code: "&#283;"},
                {char: "è", code: "&#232;"},
                {char: "ī", code: "&#299;"},
                {char: "í", code: "&#237;"},
                {char: "ǐ", code: "&#464;"},
                {char: "ì", code: "&#236;"},
                {char: "ō", code: "&#333;"},
                {char: "ó", code: "&#243;"},
                {char: "ǒ", code: "&#466;"},
                {char: "ò", code: "&#242;"},
                {char: "ū", code: "&#363;"},
                {char: "ú", code: "&#250;"},
                {char: "ǔ", code: "&#468;"},
                {char: "ù", code: "&#249;"},
                {char: "ǘ", code: "&#472;"},
                {char: "ǚ", code: "&#474;"},
                {char: "ǜ", code: "&#476;"},
            ];
            
            $scope.openKeyboard = false;
            $scope.pinyinText = '';

            var allMetaElements = document.getElementsByTagName('meta');
            
            for (var i = 0; i < allMetaElements.length; i++) { 
                if (allMetaElements[i].getAttribute("name") == "description") { 
                    allMetaElements[i].setAttribute('content', "Learn to read and understand Chinese with our Text Tool. Click on any Chinese word for a full definition, instantly add Pinyin to Chinese text, or convert from simplified to traditional characters."); 
                } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                    allMetaElements[i].setAttribute('content', "analyze chinese, add pinyin, convert pinyin, simplified to traditional, chinese text tools"); 
                }
            }

             var blankResult = function () {
                return {
                     'original':'',
                     'pinyin': '',
                     'pin1yin1': '',
                     'words': [],
                     'origtext' : {
                                    selected: null,
                                    words: []
                                  },
                     'analyzeFinished': false
                   };
                };
            $scope.savedResult = blankResult();

            $scope.resetTextTool = function () {
                $scope.result = blankResult();
                $scope.controlPanel = {
                                        'language': 'chinese',
                                        'tradorsimpl': 'simplified',
                                        'analyze': 'on',
                                        'pinyin': 'off',
                                        'select' : {
                                             sortby: '2',
                                             show: '0'
                                           }
                                      };
            };
            $scope.resetTextToolSetLang = function(language) {
                $scope.resetTextTool();
                $scope.controlPanel.language = language;
            };

            $scope.toogleKeyboard = function(){
                $scope.openKeyboard = !$scope.openKeyboard;
            }

            $scope.addPinyinChar = function(char) {
                    var twoChar = ["ā","á","ǎ", "à","ē","ě","ō","ó","ǒ","ò","ū","ú","ǔ","ù"];
                    var addPos = 1;
                    var el = document.getElementsByClassName("textarea-pinyin");
                    var position = doGetCaretPosition(el[0]);
                    
                    $scope.pinyinText = editValue($scope.pinyinText, position, char.char);
                    twoChar.forEach(function(ch){
                        if(char.char == ch){
                            addPos = 2;
                        }
                    })
                    
                    setTimeout(function(){
                        setCaretPosition(el[0], position + addPos);
                    },0);
            }

            editValue = function(value, position, char) {
                var startPosition = char ? position : position-2;
                return value.substring(0, startPosition) + char + value.substring(position);
            }

            setCaretPosition = function(el, caretPos){
                if (el !== null) {
                    if (el.createTextRange) {
                        var range = el.createTextRange();
                        range.move('character', caretPos);
                        range.select();
                        return true;
                    }
                    
                    else {
                        if (el.selectionStart || el.selectionStart === 0) {
                            el.focus();
                            el.setSelectionRange(caretPos, caretPos);
                        }
                    }
                }
            }
            $scope.removeChar = function(event) {
                var position = doGetCaretPosition(event.target);
                var twoChar = ["ā","á","ǎ", "à","ē","ě","ō","ó","ǒ","ò","ū","ú","ǔ","ù"];
                var equalChar = '';
                if(event.key === "Backspace"){
                    var isLastChar = $scope.pinyinText.substring(position - 2, position);
                    twoChar.forEach(function(char, i){
                        if(isLastChar == char){
                            equalChar = char;
                        }
                    })
                    if(equalChar){
                        event.preventDefault();
                        $scope.pinyinText = editValue($scope.pinyinText, position, '');
                        setTimeout(function(){
                            setCaretPosition(event.target, position-2);
                        },0);
                    }
                }
            }
            
            $scope.copyPinyinText = function(){
                var elCopied = document.getElementsByClassName("copied");
                elCopied[0].className = "copied copied-visible";
                setTimeout(function(){
                    elCopied[0].className = "copied";
                }, 2000);
            }

            doGetCaretPosition = function (oField) {
              var iCaretPos = 0;
              // IE support
              if (document.selection) {
                oField.focus();
                var oSel = document.selection.createRange();
                oSel.moveStart('character', -oField.value.length);
                iCaretPos = oSel.text.length;
              }

              // Firefox support
              else if (oField.selectionStart || oField.selectionStart == '0')
                iCaretPos = oField.selectionStart;

              // Return results
              return iCaretPos;
            }


            $scope.submitText = function () {
                analyzeText($scope.result.original, $scope.controlPanel).then(function(r) {
                    $scope.result = r;
                });
            };
            $scope.saveAndLoadState = function(language) {
              var tmp = $scope.result;
              $scope.resetTextToolSetLang(language);
              $scope.result = $scope.savedResult;
              $scope.savedResult = tmp;
            };

            $scope.newAnalysis = function () {
              $scope.resetTextTool();
              $scope.savedResult = blankResult();
            };

            $scope.resetTextTool();

            var analyzeText = function (text, controlPanel) {
                var result = blankResult();
                result.original = text;

                if (controlPanel.language == 'pinyin') {
                    return $http({
                                        method: 'POST',
                                        url: '/api/1.0/texttool/pinyin2p1y1/',
                                        data: {'text': text},
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                                        }
                                    })
                                .then(function(r) {
                                            if (r.data.success) {
                                                result.pin1yin1 = r.data.result;
                                            }
                                            return $http({
                                                        method: 'POST',
                                                        url: '/api/1.0/texttool/p1y12pinyin/',
                                                        data: {'text': text},
                                                        headers: {
                                                            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                                                        }
                                                    });
                                        })
                                .then(function(r) {
                                        if (r.data.success) {
                                            result.pinyin = r.data.result;
                                        }
                                        result.words = ['E','R','R','O','R'];
                                        result.analyzeFinished = true;
                                        return result;
                                    });
                }
                else if (controlPanel.language == 'chinese') {
                    angular.element('.spinner').css('display', 'block');
                    return $http({
                                        method: 'POST',
                                        url: '/api/1.0/texttool/',
                                        data: {'text': text},
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                                        }
                                    })
                                .then(function (r) {
                                        if (r.data.success) {
                                            var arr = r.data.words;
                                            var add_word = function(word) {
                                                var word_arr = result.words;
                                                word_arr.forEach(function(item, i, word_arr) {
                                                        if (item.id == word.id) {
                                                          word_arr[i].occurence +=1;
                                                          word.occurence = word_arr[i].occurence;
                                                        }
                                                    }
                                                );
                                                result.words.push(word);
                                                return word;
                                            };
                                            var english = /^[A-Za-z0-9\s\r\n]*$/;
                                            var last_item = null;
                                            var prom = [];
                                            arr.forEach(function(item, i, arr) {
                                                var deferred = $q.defer();

                                                if (!(english.test(item))) {
                                                    var promise = searchcacheService.getData(item);
                                                    promise.then(function (r) {  // this is only run after $http completes
                                                        deferred.resolve(r);
                                                    });
                                                    prom.push(deferred.promise);
                                                }
                                            });
                                            $q.all(prom).
                                                then (// results: an array of data objects from each deferred.resolve(data) call
                                                    function(results) {
                                                        var word, listWord = [];
                                                        angular.forEach(results, function (data, i) {
                                                            if (data) {
                                                                word = data;
                                                                word.occurence = 1;
                                                                word.position = i;
                                                                listWord[i] = add_word(word);
                                                            }
                                                        });

                                                        result.origtext.words = arr.map(function (item, i) {
                                                            var newWord;
                                                            angular.forEach(listWord, function (data, pos) {
                                                                 if (item === data.simplified) newWord = data;
                                                            });

                                                            if (newWord) {
                                                                return newWord;
                                                            }
                                                            angular.forEach(listWord, function (data, pos) {
                                                                 if (item === data.traditional) newWord = data;
                                                            });
                                                            if (newWord) {
                                                                return newWord;
                                                            }
                                                            return item;

                                                        });
                                                        angular.element('.spinner').css('display', 'none');
                                                    }
                                                )
                                                .catch(
                                                    function (response) {// error
                                                        console.error(response);
                                                        angular.element('.spinner').css('display', 'none');
                                                    }
                                                );
                                        } else {
                                            result.words = [];
                                            angular.element('.spinner').css('display', 'none');
                                        }
                                    })
                                .then(function() {
                                    result.analyzeFinished = true;
                                    return result;
                                });
                }
            };

        /////////// SOUND /////////////
        $scope.playSound = PhuaAudio.playSound;

        // TODO: refactor
        $scope.soundIsPlaying = false;

        $scope.$on('word-audio.play', function (event, data) {
          $scope.soundIsPlaying = true;
          $scope.$apply();
        });
        $scope.$on('word-audio.ended', function (event, data) {
          $scope.soundIsPlaying = false;
          $scope.$apply();
        });
        ////////////////////////////////


        $scope.selectWord = function selectWord(word) {
            $scope.infoword = word;
            $rootScope.globals.SelectedWord = word;
            $scope.result.origtext.selected = word;
        };


        $scope.openAddToListDialog = WordList.openAddToListDialog;

        $scope.playSound = PhuaAudio.playSound;


        }
    )
;
