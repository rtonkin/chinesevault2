angular.module('putonghua')
    .factory('TestSentencesSettings', function () {
        // TODO make it same as TestSettings (simpl/trad)
        return {
            defaultOptions: {
                number: 30,
                show: {
                    hanzi: true,
                    pinyin: false,
                    english: false,
                    simplified: true,
                    traditional: false
                },
                method: 'priority'
            },
            options: {
                number: 30,
                show: {
                    hanzi: true,
                    pinyin: false,
                    english: false,
                    simplified: true,
                    traditional: false
                },
                method: 'priority'
            },
            categories: []
        };
    })
    .controller('TestSentencesController', function ($scope, $location, $interval, $http, api, TestSentencesSettings, ngDialog) {
        if (TestSentencesSettings.categories.length <= 0) {
            $location.path('/test-settings-sentences');
        }
        $scope.showTestEndDialog = false;
        $scope.options = $.extend({}, TestSentencesSettings.options);

        $scope.categories = TestSentencesSettings.categories.filter(function (category) {
                return category.selected;
            }) || [];

        for ( i = 0; i < $scope.categories.length; i++) {
            $scope.categories[i].last_practiced = moment();
        }

        $scope.testedCards = [];
        $scope.startTime = 0;
        $scope.cards = [];
        $scope.counter = 0;
        $scope.cardRevealed = false;
        $scope.currentCard = null;

        $scope.shuffle = function (o) {
            for (var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
            return o;
        };

        $scope.prepareCards = function () {
            var i;
            $scope.cards = [];
            for (i in $scope.categories) {
                $scope.cards = $scope.cards.concat($scope.categories[i].cards);
            }

            if ($scope.options.method === 'random') {
                $scope.cards = $scope.shuffle($scope.cards);
            } else {
                // sort ascending by the lowest score
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
            $scope.statistics['Current Card'] = $scope.currentCard;
            $scope.statistics['Total Cards'] = $scope.cards.length;
            for (i = $scope.cards.length - 1; i >= 0; i--) {
                delete $scope.cards[i].Selected;
                delete $scope.cards[i].$$hashKey;
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
            return ($scope.testedCards.length / $scope.cards.length) * 100;
        };

        $scope.percentage = function () {
            if ($scope.testedCards.length === 0) {
                return 0;
            }

            return ($scope.correctCards() / $scope.testedCards.length) * 100;
        };

        $scope.statistics = {
            'Current Card': $scope.currentCard,
            'Total Cards': $scope.cards.length,
            'Progress': $scope.progress,
            'Correct': $scope.correctCards,
            'Incorrect': $scope.incorrectCards,
            'Percentage': $scope.percentage,
            'Total Time': moment().hour(0).minute(0).second($scope.startTime++).format('mm : ss')
        };

        $scope.showCurrentCard = function () {
            $scope.cardRevealed = true;
            $scope.options.show = {
                'hanzi': true,
                'pinyin': true,
                'english': true,
                'traditional': TestSentencesSettings.options.show.traditional,
                'simplified': TestSentencesSettings.options.show.simplified
            };
        };

        $scope.answerCard = function (score) {
            $scope.counter += 1;
            $scope.options.show = {
                'hanzi': TestSentencesSettings.options.show.hanzi,
                'pinyin': TestSentencesSettings.options.show.pinyin,
                'english': TestSentencesSettings.options.show.english,
                'traditional': TestSentencesSettings.options.show.traditional,
                'simplified': TestSentencesSettings.options.show.simplified
            };
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

            //api.markSentenceTested(...)
            $http.put('/api/1.0/sentencecard/' + $scope.currentCard.id + '/',
                angular.toJson({
                    'id': $scope.currentCard.id,
                    'last_practiced': $scope.currentCard.last_practiced,
                    'score': $scope.currentCard.score,
                    'times_tested': $scope.currentCard.times_tested
                }),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }
            )/* .then(
                function(response){
                  console.log('sucesssssssssssssssssssssssssss')
                }, 
                function(response){
                  console.log('failureeeeeeeeeee')
                }
             ) */;

            // move to history
            $scope.testedCards.push($scope.currentCard);

            if ($scope.counter <= $scope.cards.length - 1) {
                $scope.currentCard = angular.copy($scope.cards[$scope.counter]);
                $scope.statistics['Current Card'] = $scope.currentCard;
            } else {
                $scope.counter--; // dirty hack
                $scope.endTest();
            }
        };

        $scope.stopTimer = function () {
            if (angular.isDefined($scope.updateTotalTime)) {
                $interval.cancel($scope.updateTotalTime);
            }
        };

        $scope.startTimer = function () {
            // update elapsed time every second
            $scope.updateTotalTime = $interval(function () {
                $scope.statistics['Total Time'] = moment().hour(0).minute(0).second($scope.startTime++).format('mm : ss');
            }, 1000); // run every second
        };

        $scope.startTest = function (incorrect) {
            $scope.showTestEndDialog = false;

            if ($scope.endTestDialog) {
                $scope.endTestDialog.close();
            }
            $scope.options.show = {
                'hanzi': TestSentencesSettings.options.show.hanzi,
                'pinyin': TestSentencesSettings.options.show.pinyin,
                'english': TestSentencesSettings.options.show.english,
                'traditional': TestSentencesSettings.options.show.traditional,
                'simplified': TestSentencesSettings.options.show.simplified
            };
            $scope.cardRevealed = false;
            $scope.testedCards = [];
            $scope.startTime = 0;
            $scope.counter = 0;
            $scope.currentCard = null;

            if (incorrect === true) {
                $scope.cards = [];
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
            else {
                $scope.prepareCards();
            }
            $scope.incorrectCardsList = [];
            $scope.incorrectSelection = [];
            $scope.startTime = 0;
            $scope.startTimer();
            $scope.testRunning = true;
            $scope.showResults = false;

            $scope.categories.forEach(function (category) {
                api.markSentenceCategoryTested(category, moment()).then(function () {
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
            api.getSentenceCategories().then(function (data) {
                    $scope.userCategories = data;
                    $scope.addDestinationCategory = $scope.userCategories[0];
                });
            $scope._cardsToAdd = $scope.cardsToAdd();
            $scope.addToListDialog = ngDialog.open({
                template: '/static/templates/dialogs/add_cards_to_existing_list.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            });
        };
        

        $scope.addCardsToList = function (addDestinationCategory) {
            $scope.addDestinationCategory = addDestinationCategory.name;
            function markWordAdded(word) {
                word.added = true;
                word.categories.push(addDestinationCategory);
                return true;
            }
            var cards = $scope.cardsToAdd();
            for (var i = 0; i < cards.length; i++) {
                var word = cards[i].sentence;
                api.addSentenceToList(addDestinationCategory, word).then(function (response) {
                    markWordAdded(word)
                });
            }

            $scope.addToListDialog.close();
        };


        $scope.addCardsToNewList = function () {
            // showed after user choose new name
            cards = $scope.cardsToAdd();
            //api.addSentenceToNewCategory
            $http.post(
                '/api/1.0/sentencecategory/',
                angular.toJson({name: $scope.addDestinationCategory}),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                            $scope.userCategories.push(resp.data);
                            $scope.categories.push(resp.data);
                            $scope.addDestinationCategory = resp.data;
                            $scope.addCardsToList(resp.data);
                        
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );
                /* .success(function (data) {
                    $scope.userCategories.push(data);
                    $scope.categories.push(data);
                    $scope.addDestinationCategory = data;
                    $scope.addCardsToList(data);
                })
                .error(function () {
                }); */

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
            // shoe create dialog
            $scope.userCategories = [];
            api.getSentenceCategories().then(function (categories) {
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
            $location.path('/test-settings-sentences');
        };

        // Make sure that the interval is destroyed too
        $scope.$on('$destroy', function () {
            $scope.stopTimer();
        });

        $scope.startTest();
    })

    .controller('TestSettingsSentencesController', function ($scope, api, TestSentencesSettings) {
        $scope.categories = [];
        $scope.options = TestSentencesSettings.options;

        api.getSentenceCategories().then(function (categories) {
        
            $scope.categories = categories.filter(function (category) {
                if (category.last_practiced) {
                    category.current_time = moment(category.last_practiced).fromNow();
                } else 
                    category.current_time = "Never";
                return category.cards.length > 0;
            });

            TestSentencesSettings.categories = $scope.categories;
            $scope.categories.forEach(function(category) {
                category.learnedCards = category.cards.filter(function (card) {
                    if (card.times_tested <= 0) {
                        return false;
                    } else return true
                })
            }); 
        });  

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
                sum += category.cards.length;
            });

            return sum;
        };

        $scope.selectAllCategories = function () {
            $scope.categories.forEach(function (category) {
                category.selected = true;
            });
        };

        $scope.clearCategoriesSelection = function () {
            $scope.categories.forEach(function (category) {
                category.selected = false;
            });
        };

        $scope.resetDefaults = function () {
            TestSentencesSettings.options = $.extend(true, {}, TestSentencesSettings.defaultOptions);
            $scope.options = TestSentencesSettings.options;
        };

        TestSentencesSettings.categories = function () {
            return $scope.selectedCategories();
        }();
    });
