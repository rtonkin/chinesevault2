angular.module('putonghua')
    .factory('TestSettings', function () {
        return {
            defaultOptions: {
                number: 30,
                show: {
                    hanzi: true,
                    pinyin: false,
                    english: false,
                    traditional: false
                },
                tone: 'hanzi', // another values: 'englishpinyin'
                fill: 'pinyin', // another values: 'hanzi'
                multi: 'pinyin', // another values: 'correcttones', 'definition'
                method: 'priority',
                mode: 'normal'
            },
            options: {
                number: 30,
                show: {
                    hanzi: true,
                    pinyin: false,
                    english: false,
                    traditional: false
                },
                tone: 'hanzi', // another values: 'englishpinyin'
                fill: 'pinyin', // another values: 'hanzi'
                multi: 'pinyin', // another values: 'correcttones', 'definition'
                method: 'priority',
                mode: 'normal' // another values: 'tonepractice', 'fillintheblanks', 'multiplechoice'
            },
            categories: []
        };
    })
    .controller('PracticeController', function ($scope, $state) {

        document.title = "Chinese Flashcards – ChineseVault.com";

        var allMetaElements = document.getElementsByTagName('meta');
        
        for (var i = 0; i < allMetaElements.length; i++) { 
            if (allMetaElements[i].getAttribute("name") == "description") { 
                allMetaElements[i].setAttribute('content', "Free online flashcard app to help to learn mandarin Chinese. Existing flashcard lists including HSK are ready to study now. Don’t forget what you learn!"); 
            } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                allMetaElements[i].setAttribute('content', "chinese flashcards, memorize chinese, chinese practice, online flashcards, practice characters, free chinese flashcards"); 
            }
        }
        $scope.sentencesTestCards = function(){
            $state.go('test-settings-sentences');
        }
        $scope.testCards = function(){
            $state.go('test-settings');
        }
        $scope.arrangeSentencesCard = function(){
            $state.go('arrange-cards-sentences');
        }
        $scope.arrageCards = function () {
            $state.go('arrange-cards');
        };
    })
    .controller('TestController', function ($rootScope, $scope, $location, $interval, $http, api, $stateParams, TestSettings, ngDialog, $timeout) {
       
        $scope.shuffle = function (o) {
            for (var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
            return o;
        };

        $scope.playSound = function() {
            var audio = new Audio($scope.currentCard.url);
            audio.play();
            audio.addEventListener('play', function(){ $rootScope.$broadcast('voice-audio.play', this); });
            audio.addEventListener('ended', function(){ $rootScope.$broadcast('voice-audio.ended', this); });
        };

        $scope.playSoundEndTest = function(url) {
            var audio = new Audio(url);
            audio.play();
            audio.addEventListener('play', function(){ $rootScope.$broadcast('voice-audio.play', this); });
            audio.addEventListener('ended', function(){ $rootScope.$broadcast('voice-audio.ended', this); });
        };

        $scope.soundIsPlaying = false;
        $rootScope.$on('voice-audio.play', function (event, data) {
            $scope.soundIsPlaying = true;
            $scope.$apply();
        });
        $rootScope.$on('voice-audio.ended', function (event, data) {
            $scope.soundIsPlaying = false;
            $scope.$apply();
        });

        $scope.voices = [];

        $scope.prepareCards = function () {
            $scope.cards = [];

            if (TestSettings.options.mode == 'tonepracticewithaudio') {
                api.getVoices(TestSettings.options.number).then(function(response) {
                    $scope.voices = JSON.parse(response.tones);
                    $scope.currentCard = angular.copy($scope.voices[$scope.counter]);
                    /* console.log("voices", $scope.voices); */
                   /*  for local */
                    angular.forEach($scope.voices,function(data){
                        data.url =   data.url;
                    })
                    prepareCardHook();  
                    $scope.statistics['Current Card'] = $scope.currentCard; 
                    $scope.statistics['Total Cards'] = $scope.voices.length;
                })
            } else {
                var i;

                for (i = 0; i < $scope.categories.length; i++) {
                    $scope.cards = $scope.cards.concat($scope.categories[i].cards);
                }

                if ($scope.options.method === 'random') {
                    $scope.cards = $scope.shuffle($scope.cards);
                } else {
                    /* // sort ascending by the lowest score */
                    $scope.cards = $scope.cards.sort(function (a, b) {
                        return (a.score - b.score);
                    });
                }

                if ($scope.cards.length >= $scope.options.number) {
                    // limit the cards to the number chosen on the test settings page
                    $scope.cards = $scope.cards.splice(0, $scope.options.number);

                } else {
                    // duplicate the cards in the list so they reach the number chosen on the test page
                    var moreCards = [],
                        min = 0,
                        max = $scope.cards.length;

                    for (i = 0, diff = $scope.options.number - $scope.cards.length; i < diff; i++) {
                        var index = Math.floor(Math.random() * (max - min)) + min;
                        moreCards.push($scope.cards[index]);
                    }

                    $scope.cards = $scope.cards.concat(moreCards);
                }

                $scope.currentCard = angular.copy($scope.cards[$scope.counter]);

                prepareCardHook();
                $scope.statistics['Current Card'] = $scope.currentCard;
                $scope.statistics['Total Cards'] = $scope.cards.length;

                for (i = $scope.cards.length - 1; i >= 0; i--) {
                    if ($scope.cards[i] !== undefined) {
                        delete $scope.cards[i].Selected;
                        delete $scope.cards[i].$$hashKey;
                    }
                }
            }

        };

        $scope.correctCards = function () {
            var correct = $scope.testedCards.filter(function (card) {
                    return card.currentScore >= 3;
                }) || [];
            return correct.length;
        };

        $scope.incorrectCards = function () {
            var incorrect = $scope.testedCards.filter(function (card) {
                    return card.currentScore <= 1;
                }) || [];
            return incorrect.length;
        };

        $scope.progress = function () {
            if(TestSettings.options.mode == 'tonepracticewithaudio') {
                return ($scope.testedCards.length / $scope.voices.length) * 100;
            } else {
                return ($scope.testedCards.length / $scope.cards.length) * 100;
            }
        };

        $scope.percentage = function () {
            if ($scope.testedCards.length === 0) {
                return 0;
            }

            return ($scope.correctCards() / $scope.testedCards.length) * 100;
        };

        function showCorrect() {
            $scope.correctMessage = true;
            $scope.incorrectMessage = false;
            $timeout(
                function () {
                    $scope.correctMessage = false;
                },
                800
            )
        }

        function showIncorrect() {
            $scope.incorrectMessage = true;
            $scope.correctMessage = false;
            $timeout(
                function () {
                    $scope.incorrectMessage = false;
                },
                800
            )
        }

        $scope.showCurrentCard = function () {
            $scope.cardRevealed = true;
            $scope.options.show = {
                'hanzi': true,
                'pinyin': true,
                'english': true,
                'traditional': TestSettings.options.show.traditional
            };
            $scope.options.mode = TestSettings.options.mode;
        };

        $scope.answerTone = function (value) {
            
            if(TestSettings.options.mode == 'tonepracticewithaudio') {
                var subStr = $scope.toneString.substring(0, ($scope.toneString.length -1));
                var currentAnswer = String(subStr + value) ;
                $scope.currentCard.currentAnswer = currentAnswer;
                api.getVoice(currentAnswer).then(function(response) {
                    $scope.currentCard.currentAnswer = response.pinyin_normalized;
                    $scope.currentCard.answerUrl = response.url; /*https://chinesevault.com*/                  
                    
                    popped = $scope.tones.pop();
                    if (value != popped) {
                        $scope.answerCard(0);
                        showIncorrect();
                    }
                    else {
                        if ($scope.tones.length === 0) {
                            $scope.answerCard(4);
                            showCorrect();
                        }
                    }
                });
            } else {
                popped = $scope.tones.pop();
                if (value != popped) {
                    $scope.answerCard(0);
                    showIncorrect();
                }
                else {
                    if ($scope.tones.length === 0) {
                        $scope.answerCard(4);
                        showCorrect();
                    }
                }
            }
            /*
             compare user entered value with saved value in $scope.tones,
             if they a different call $scope.answerCard(0), if they a same
             (user answered right) test if user entered all values and call
             $scope.answerCard(4)
             */
        };

        var prepareTones = function (card) {
            if(TestSettings.options.mode == 'tonepracticewithaudio') {
                angular.element('.test-button').each(function(i, elem) {
                    
                    if($scope.currentCard.varicks.indexOf(String(elem.attributes['id'].value)) >= 0) {
                        elem.className += " test-button ";
                    } else {
                        elem.className += " diss ";
                    }
                    if( i == 0) {
                        elem.className += " abc "
                    }
                })
            }
                
            /*
             find tones in card for further comparsion with user's answers
             */
            var tmp = [];
            var s = null;
            toneSet = {'1': true, '2': true, '3': true, '4': true, '5': true};
            if(TestSettings.options.mode == 'tonepracticewithaudio') {
                setTimeout($scope.playSound, 500);
                s = card.name;
            } else {
                s = card.word.pinyin;
            }
            for (var i = 0; i < s.length; i++) {
                var ch = s.charAt(i);
                if (ch in toneSet) {
                    tmp.push(parseInt(s.charAt(i)));
                }
            }
            $scope.tones = tmp.reverse();
            $scope.toneString = s;
        };

        $scope.answerFillin = function (text) {
            /* depending of selected options, test value with card's chinese or pinyin */
            var score = 0; // minimum score
            if (TestSettings.options.fill == 'hanzi') {
                
                if ($scope.currentCard.word.simplified == text.text || $scope.currentCard.word.traditional == text.text) {
                    score = 4;
                }
            }
            else if (TestSettings.options.fill == 'pinyin') {
                
                var c = $scope.currentCard;
                if ($scope.currentCard.word.pinyin == text.text || $scope.currentCard.word.pinyin_normalized == text.text) {
                    score = 4;
                }
            }
            if (score == 4) {
                showCorrect();
            } else {
                showIncorrect();
            }

            $scope.answerCard(score);
        };

        $scope.answerMulti = function (text) {
            /* depending of selected options, test value with card's chinese or pinyin */
            var c;
            var score = 0; // minimum score
            if (TestSettings.options.multi == 'pinyin') {
                if ($scope.currentCard.word.pinyin_normalized == text) {
                    score = 4;
                }
            }
            else if (TestSettings.options.multi == 'correcttones') {
                if ($scope.currentCard.word.pinyin == text) {
                    score = 4;
                }
            }
            else if (TestSettings.options.multi == 'definition') {
                if ($scope.currentCard.word.meanings_references[0] == text) {
                    score = 4;
                }
            }
            if (score == 4) {
                showCorrect();
            } else {
                showIncorrect();
            }
            $scope.answerCard(score);
        };


        var prepareCardHook = function () {

            if (TestSettings.options.mode == 'tonepractice' || TestSettings.options.mode == 'tonepracticewithaudio') {
                prepareTones($scope.currentCard);
                /* console.log("tone output:  " + JSON.stringify($scope.currentCard)); */
            }
            else if (TestSettings.options.mode == 'fillintheblanks') {
                $scope.filltext.text = '';
            }
            else if (TestSettings.options.mode == 'multiplechoice') {
                $scope.choices = generateChoices();
            }
        };

        var countSyllables = function (word) {
            /* returns number of 1,2,3,4,5 characters in word
             == number of syllables in pin1yin1
             */
            var tones = ['1', '2', '3', '4', '5'];
            var result = 0;
            for (var i = 0; i < word.length; i++) {
                var ch = word.charAt(i);
                if (ch in tones) {
                    result++;
                }
            }
            return result;
        };

        var generatePinyinVarinates = function (pinyin) {
            var i;
            var exclude = {};
            var shuffled_cards;
            exclude[pinyin] = true;
            var result = [pinyin];
            var sampleSylCount = countSyllables(pinyin);
            shuffled_cards = $scope.shuffle($scope.cards);
            for (i = 0; (i < shuffled_cards.length && result.length < 4); i++) {
                tmp = shuffled_cards[i].word.pinyin_normalized;
                if (!(tmp in exclude) && (sampleSylCount == countSyllables(tmp))) {
                    result.push(tmp);
                    exclude[tmp] = true;
                }
            }
            for (i = 0; (i < shuffled_cards.length && result.length < 4); i++) {
                tmp = shuffled_cards[i].word.pinyin_normalized;
                if (sampleSylCount == countSyllables(tmp)) {
                    result.push(tmp);
                }
            }
            while (result.length < 4) {
                shuffled_cards = $scope.shuffle($scope.cards);
                for (i = 0; (i < shuffled_cards.length && result.length < 4); i++) {
                    result.push(shuffled_cards[i].word.pinyin_normalized);
                }
            }
            return result;
        };

        var permutator = function (list, maxLen) {
            // Copy initial values as arrays
            var perm = list.map(function (val) {
                return [val];
            });
            // Our permutation generator
            var generate = function (perm, maxLen, currLen) {
                // Reached desired length
                if (currLen === maxLen) {
                    return perm;
                }
                // For each existing permutation
                for (var i = 0, len = perm.length; i < len; i++) {
                    var currPerm = perm.shift();
                    // Create new permutation
                    for (var k = 0; k < list.length; k++) {
                        perm.push(currPerm.concat(list[k]));
                    }
                }
                // Recurse
                return generate(perm, maxLen, currLen + 1);
            };
            // Start with size 1 because of initial values
            return generate(perm, maxLen, 1);
        };

        var removeA = function (arr, what) {
            /*
             remove item from array by value
             */
            result = [];
            for (var i = 0; i < arr.length; i++) {
                if (what.toString() != arr[i].toString()) {
                    result.push(arr[i]);
                }
            }
            return result;
        };


        var getTones = function (pinyin) {
            /* return array of tone numbers
             */
            var tones = ['1', '2', '3', '4', '5'];
            var result = [];
            for (var i = 0; i < pinyin.length; i++) {
                var ch = pinyin.charAt(i);
                if (ch in tones) {
                    result.push(ch);
                }
            }
            return result;
        };


        var replacePinyinTones = function (pinyin, newtones) {
            /*
             replacing tune numbers
             used in generatePinyinTonesVariantes
             */
            var tones = ['1', '2', '3', '4', '5'];
            var result = [];
            var j = 0;
            for (var i = 0; i < pinyin.length; i++) {
                var ch = pinyin.charAt(i);
                if (!(ch in tones)) {
                    result.push(ch);
                }
                else {
                    result.push(newtones[j++]);
                }
            }
            return result.join('');
        };

        var generatePinyinTonesVariantes = function (pinyin) {
            var result = [pinyin];
            var tones = ['1', '2', '3', '4', '5'];
            var combinations = permutator(tones, countSyllables(pinyin));
            combinations = $scope.shuffle(removeA(combinations, getTones(pinyin)));
            for (var i = 0; (i < combinations.length && result.length < 4); i++) {
                var tmp = replacePinyinTones(pinyin, combinations[i]);
                result.push(tmp);
            }
            return result;
        };

        var generateDefinitionVariantes = function (definition) {
            var i;
            var exclude = {};
            var shuffled_cards;
            exclude[definition] = true;
            var result = [definition];
            shuffled_cards = $scope.shuffle($scope.cards);
            for (i = 0; (i < shuffled_cards.length && result.length < 4); i++) {
                tmp_def = shuffled_cards[i].word.meanings_references[0];
                if (!(tmp_def in exclude)) {
                    result.push(tmp_def);
                    exclude[tmp_def] = true;
                }
            }
            while (result.length < 4) {
                shuffled_cards = $scope.shuffle($scope.cards);
                for (i = 0; (i < shuffled_cards.length && result.length < 4); i++) {
                    result.push(shuffled_cards[i].word.meanings_references[0]);
                }
            }
            return result;
        };
        var removeDiss = function () {
            angular.element('.test-button').each(function(i, elem) {
                elem.className = temporaryClassName[i];
            })
        }
        var generateChoices = function () {
            var result = [];
            var word = $scope.currentCard.word;
            /* console.log(word) */
            if (TestSettings.options.multi == 'pinyin') {
                result = generatePinyinVarinates(word.pinyin_normalized);
            }
            else if (TestSettings.options.multi == 'correcttones') {
                result = generatePinyinTonesVariantes(word.pinyin);
            }
            else if (TestSettings.options.multi == 'definition') {
                result = generateDefinitionVariantes(word.meanings_references[0]);
            }
            return $scope.shuffle(result);
        };

        var temporaryClassName = [];

        $scope.answerCard = function (score) {
            /*
             collect score and save it to DB
             show nextCard
             */

            if(TestSettings.options.mode == 'tonepracticewithaudio') {
                $scope.counter += 1;
                $scope.options.mode = TestSettings.options.mode;
                $scope.cardRevealed = false;
                if (score <= 1) {
                    $scope.incorrectCardsList.push($scope.currentCard);
                }
                $scope.currentCard.currentScore = score;
                $scope.currentCard.score += $scope.currentCard.currentScore;
                $scope.currentCard.times_tested += 1;
                $scope.testedCards.push($scope.currentCard);
                if ($scope.counter <= $scope.voices.length - 1) {
                    $scope.currentCard = angular.copy($scope.voices[$scope.counter]);
                    $scope.statistics['Current Card'] = $scope.currentCard;
                    angular.element('.test-button').each(function(i, elem) {
                        temporaryClassName.push(elem.className)
                        elem.className += " diss ";
                    });
                    setTimeout(removeDiss, 800)
                    setTimeout(prepareCardHook, 800);
                    // prepareCardHook();
                } else {
                    $scope.counter--; // dirty hack
                    $scope.endTest();
                }

            } else {
                $scope.counter += 1;
                $scope.options.show = {
                    'hanzi': TestSettings.options.show.hanzi,
                    'pinyin': TestSettings.options.show.pinyin,
                    'english': TestSettings.options.show.english,
                    'traditional': TestSettings.options.show.traditional
                };
                $scope.options.mode = TestSettings.options.mode;
                $scope.cardRevealed = false;
                // if incorrect - move to incorrect cards
                if (score <= 1) {
                    $scope.incorrectCardsList.push($scope.currentCard);
                    // dirty hack
                    var uniqueArray = [];
                    var duplicateIds = [];
                    for (var i = 0; i < $scope.incorrectCardsList.length; i++) {
                        if (duplicateIds.indexOf($scope.incorrectCardsList[i].id) == -1) {
                            uniqueArray.push($scope.incorrectCardsList[i]);
                            duplicateIds.push($scope.incorrectCardsList[i].id);
                        }
                    }
                    $scope.incorrectCardsList = uniqueArray;
                }

                $scope.currentCard.currentScore = score;
                $scope.currentCard.score += $scope.currentCard.currentScore;
                $scope.currentCard.times_tested += 1;

                api.markWordTested($scope.currentCard,
                    $scope.currentCard.last_practiced,
                    $scope.currentCard.score,
                    $scope.currentCard.times_tested).then(function () {
                });

                // move to history
                $scope.testedCards.push($scope.currentCard);
                    if ($scope.counter <= $scope.cards.length - 1) {
                        $scope.currentCard = angular.copy($scope.cards[$scope.counter]);
                        $scope.statistics['Current Card'] = $scope.currentCard;
                        
                         
                        prepareCardHook();

                    } else {
                        $scope.counter--; // dirty hack
                        $scope.endTest();
                    }
                }
            
            };

            $scope.stopTimer = function () {
                if (angular.isDefined($scope.updateTotalTime)) {
                    $interval.cancel($scope.updateTotalTime);
                }
            };

            $scope.startTimer = function () {
                $scope.updateTotalTime = $interval(function () {
                    // $scope.statistics['Total Time'] = moment().subtract($scope.startTime).format('mm:ss');
                    $scope.statistics['Total Time'] = moment().hour(0).minute(0).second($scope.startTime++).format('mm : ss');
                }, 1000); // run every second
            };
        $scope.startTest = function (incorrect) {
            $scope.startTime = 0;
            $scope.counter = 0;
            $scope.showTestEndDialog = false;
            if ($scope.endTestDialog) {
                $scope.endTestDialog.close();
            }
            $scope.options.show = {
                'hanzi': TestSettings.options.show.hanzi,
                'pinyin': TestSettings.options.show.pinyin,
                'english': TestSettings.options.show.english,
                'traditional': TestSettings.options.show.traditional
            };
            $scope.options.mode = TestSettings.options.mode;
            $scope.cardRevealed = false;
            $scope.testedCards = [];
            $scope.startTime = 0;
            $scope.counteranswerTone = 0;
            $scope.currentCard = null;

            if (incorrect === true) {
                $scope.cards = [];
                $scope.voices = [];
                if(TestSettings.options.mode == 'tonepracticewithaudio') {
                    for (var i = $scope.incorrectSelection.length - 1; i >= 0; i--) {
                        $scope.voices.push($scope.incorrectSelection[i]);
                    }
                    if ($scope.voices.length <= 0) {
                        $scope.endTest();
                    }
                    $scope.currentCard = $scope.voices[$scope.counter];
                    $scope.statistics['Current Card'] = $scope.currentCard;
                    $scope.statistics['Total Cards'] = $scope.voices.length;
                } else {
                    for (var i = $scope.incorrectSelection.length - 1; i >= 0; i--) {
                        $scope.cards.push($scope.incorrectSelection[i]);
                    }
                    if ($scope.cards.length <= 0) {
                        $scope.endTest();
                    }
                    $scope.currentCard = $scope.cards[$scope.counter];
                    $scope.statistics['Current Card'] = $scope.currentCard;
                    $scope.statistics['Total Cards'] = $scope.cards.length;
                }
            }
            else {
                $scope.prepareCards();
                $scope.prepareFinished = true;
            }
            $scope.incorrectCardsList = [];
            $scope.incorrectSelection = [];
            $scope.startTime = 0;
            $scope.startTimer();
            $scope.testRunning = true;
            $scope.showResults = false;

            $scope.categories.forEach(function (category) {
                api.markCategoryTested(category, moment()).then(function () {
                })
            });
        };


        $scope.endTest = function () {
            $scope.stopTimer();
            $scope.incorrectSelection = $scope.incorrectCardsList;
            
            for (var i = $scope.incorrectSelection.length - 1; i >= 0; i--) {
                $scope.incorrectSelection[i].Selected = true;
            }
            $scope.showTestEndDialog = true;
            /*
             $scope.endTestDialog = ngDialog.open({
             template: '/static/templates/dialogs/test_end.html',
             className: 'ngdialog-theme-default ngdialog-theme-custom',
             closeByDocument: false,
             closeByEscape: false,
             showClose: false,
             scope: $scope
             });
             */
        };

        $scope.cardsToAdd = function cardsToAdd() {
            result = $scope.incorrectSelection.filter(function (card) {
                    return card.Selected === true;
                }) || [];
            return result;
        };

        $scope.ifcardsToAdd = function ifcardsToAdd() {
            return $scope.cardsToAdd().length;
        };

        $scope.clearAllSelections = function clearAllSelections() {
            $scope.clearAllSelectionsClicked = true;
            for (var i = $scope.incorrectSelection.length - 1; i >= 0; i--) {
                $scope.incorrectSelection[i].Selected = false;
            }
        };

        $scope.selectAllSelections = function selectAllSelections() {
            $scope.clearAllSelectionsClicked = false;
            for (var i = $scope.incorrectSelection.length - 1; i >= 0; i--) {
                $scope.incorrectSelection[i].Selected = true;
            }
        };

        $scope.addToExistingList = function addToExistingList() {
            // show category choosing dialog
            $scope.userCategories = [];
            api.getCategories().then(function (categories) {
                $scope.userCategories = categories;
                $scope.addDestinationCategory = $scope.userCategories[0];
            });
            $scope._cardsToAdd = $scope.cardsToAdd();
            $scope.addToListDialog = ngDialog.open({
                template: '/static/templates/dialogs/add_cards_to_existing_list.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            });
        };


        $scope.addCardsToListN = function () {

            function markWordAdded(word) {
                word.added = true;
                word.categories.push($scope.addDestinationCategory);
            }
            var cards = $scope.cardsToAdd();
            for (var i = 0; i < cards.length; i++) {
                var word = cards[i].word;
                api.addWordToList($scope.addDestinationCategory, word).then(function () {
                    markWordAdded(word)
                });
            }

            $scope.addToListDialog.close();
        };

        $scope.addCardsToList = function (addDestinationCategory) {
            $scope.addDestinationCategory = addDestinationCategory.name;
            function markWordAdded(word) {
                word.added = true;
                word.categories.push(addDestinationCategory);
            }
            var cards = $scope.cardsToAdd();
            for (var i = 0; i < cards.length; i++) {
                var word = cards[i].word;
                api.addWordToList(addDestinationCategory.name, word).then(function () {
                    markWordAdded(word)
                });
            }

            $scope.addToListDialog.close();
        };


        $scope.addCardsToNewList = function () {
            // showed after user choose new name
            api.createCategory($scope.addDestinationCategory)
                .then(function (category) {

                    $scope.addCardsToListN();
                });
            $scope.addToListDialog.close();
        };

        $scope.destinationCategoryNameOk = function () {
            //fix
            for (i = 0; i < $scope.userCategories.length; i++) {
                if ($scope.userCategories[i].name === $scope.addDestinationCategory) {
                    return false;
                }
            }
            return true;
        };

        $scope.addToNewList = function addToNewList() {
            // shows create dialog
            $scope.userCategories = [];
            api.getCategories()
                .then(function (categories) {
                    $scope.userCategories = categories;
                    $scope.addDestinationCategory = null;
                });

            $scope.addToListDialog = ngDialog.open({
                template: '/static/templates/dialogs/test_categories_new.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            });
        };


        $scope.restartTestIncorrect = function () {
            if ($scope.endTestDialog) {
                $scope.endTestDialog.close();
            }
            $scope.startTest(true);
            $scope.filltext.text = '';
        };


        $scope.restartTest = function () {
            if ($scope.endTestDialog) {
                $scope.endTestDialog.close();
            }
            $scope.endTest();
            $scope.startTest(false);
        };

        $scope.configureNewTest = function () {
            if ($scope.endTestDialog) {
                $scope.endTestDialog.close();
            }
            $location.path('/test-settings/?');
        };

        // Make sure that the interval is destroyed too
        $scope.$on('$destroy', function () {
            $scope.stopTimer();
        });
        $scope.prepareFinished = false;

        if (TestSettings.categories.length <= 0 && !$stateParams.quick) {
            $location.path('/test-settings/?');
        }
        if ($stateParams.quick) {
            api.getCategories().then(function (categories) {
                // only consider categories that have cards
                TestSettings.categories = categories.filter(function (category) {
                    return category.cards.length > 0;
                });
                for (var i = 0; i < TestSettings.categories.length; i++) {
                    TestSettings.categories[i].selected = true;
                }
                $scope.showTestEndDialog = false;
                $scope.options = $.extend({}, TestSettings.options);

                $scope.categories = TestSettings.categories.filter(function (category) {
                        return category.selected;
                    }) || [];

                $scope.testedCards = [];
                $scope.startTime = 0;
                $scope.cards = [];
                $scope.counter = 0;
                $scope.cardRevealed = false;
                $scope.currentCard = null;

                // used with Tone practice
                $scope.tones = [];
                // used with FillIn practice
                $scope.filltext = {text: ''};
                // used with MultipleChoice practice
                $scope.choices = [];
                $scope.statistics = {
                    'Current Card': $scope.currentCard,
                    'Total Cards': $scope.cards.length,
                    'Progress': $scope.progress,
                    'Correct': $scope.correctCards,
                    'Incorrect': $scope.incorrectCards,
                    'Percentage': $scope.percentage,
                    'Total Time': moment().hour(0).minute(0).second($scope.startTime++).format('mm : ss')
                };
                $scope.startTest();
            });
        }
        else {
            $scope.showTestEndDialog = false;
            $scope.options = $.extend({}, TestSettings.options);

            $scope.categories = TestSettings.categories.filter(function (category) {
                    return category.selected;
                }) || [];

            $scope.testedCards = [];
            $scope.startTime = 0;
            $scope.cards = [];
            $scope.counter = 0;
            $scope.cardRevealed = false;
            $scope.currentCard = null;

            // used with Tone practice
            $scope.tones = [];
            $scope.toneString = null;
            // used with FillIn practice
            $scope.filltext = {text: ''};
            // used with MultipleChoice practice
            $scope.choices = [];
            $scope.statistics = {
                'Current Card': $scope.currentCard,
                'Total Cards': $scope.cards.length,
                'Progress': $scope.progress,
                'Correct': $scope.correctCards,
                'Incorrect': $scope.incorrectCards,
                'Percentage': $scope.percentage,
                'Total Time': moment().hour(0).minute(0).second($scope.startTime++).format('mm : ss')
            };
            $scope.startTest();
        }

    })

    .controller('TestSettingsController', function ($scope, api, TestSettings) {
        $scope.categories = [];
        $scope.options = TestSettings.options;

        api.getCategoriesFast().then(function (categories) {
            // only consider categories that have cards
            $scope.categories = categories.filter(function (category) {
                if (category.last_practiced) {
                    category.current_time = moment(category.last_practiced).fromNow();
                } else 
                    category.current_time = "Never"                
                return category.cards_count > 0;
            });
            TestSettings.categories = $scope.categories;
        });

        $scope.loadCategory = function (index, catId) {
            if ($scope.categories[index].selected) {
                api.getCategory(catId).then(function (data) {
                    $scope.categories[index].cards = data.cards;
                })
            }
        }

        $scope.getLearnedCards = function (category) {
            // card is considered learned if it's tested at least once
            // and it's score is >= 50%
            return category.cards.filter(function (card) {
                if (card.times_tested <= 0) {
                    return false;
                }

                return card.score >= (card.times_tested * 2);
            });
        };

        $scope.selectedCategories = function () {
            var selected = [];

            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    selected.push(category);
                }
            });

            return selected;
        };


        $scope.getTotalSelected = function () {
            var sum = 0;

            $scope.selectedCategories().forEach(function (category) {
                sum += category.cards_count;
            });

            return sum;
        };

        $scope.selectAllCategories = function () {
            for (var i = 0; i < $scope.categories.length; i++) {
                var category = $scope.categories[i];
                var save_i = i;
                if (angular.isUndefined(category.cards)) {
                    api.getCategory(category.id).then(function (data) {
                        $scope.categories[save_i].cards = data.cards;
                    })
                }
                category.selected = true;

            }
        };

        $scope.clearCategoriesSelection = function () {
            $scope.categories.forEach(function (category) {
                category.selected = false;
            });
        };

        $scope.resetDefaults = function () {
            TestSettings.options = $.extend(true, {}, TestSettings.defaultOptions);
            $scope.options = TestSettings.options;
        };

        TestSettings.categories = function () {
            return $scope.selectedCategories();
        }();
    })
;