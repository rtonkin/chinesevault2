angular.module('putonghua')
    .controller('ArrangeCardsSentencesController', function ($scope, $http, api, ngDialog) {
        $scope.categories = [];
        $scope.copyDestination = null;
        $scope.moveDestination = null;
        $scope.allCardsSelected = false;
        $scope.selectedCategory = null;
        $scope.selectedPubCategory = null;
        $scope.dialogs = {};
        $scope.dialogsOptions = {
            'cardsCopy': {
                template: '/static/templates/dialogs/cards_copy.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            },
            'cardsPubCopy': {
                template: '/static/templates/dialogs/cards_pub_copy.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            },
            'cardsMove': {
                template: '/static/templates/dialogs/cards_move.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            },
            'categoriesDelete': {
                template: '/static/templates/dialogs/categories_delete.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            },
            'categoriesCopy': {
                template: '/static/templates/dialogs/categories_copy.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            },
            'pubcategoriesSave': {
                template: '/static/templates/dialogs/pubcategories_save.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            },
            'categoriesNew': {
                template: '/static/templates/dialogs/categories_new.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            },
            'categoriesRename': {
                template: '/static/templates/dialogs/categories_rename.html',
                className: 'ngdialog-theme-default ngdialog-theme-custom',
                scope: $scope
            }
        };

        api.getSentenceCategories().then(function (categories) {
            $scope.categories = categories;
            $scope.copyDestination = $scope.categories[0];
            $scope.moveDestination = $scope.categories[0];
        });


        $scope.selectCategory = function (selectedCategory) {
            $scope.allCardsSelected = false;

            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    category.cards.forEach(function (card) {
                        card.selected = false;
                    });
                }
            })
            
            $scope.categories.map(function (category) {
                category.selected = false;
            });
            $scope.selectedCategory = selectedCategory;
            $scope.selectedCategory.selected = true;
        };

        $scope.selectPubCategory = function (selectedPubCategory) {
            $scope.pubcategories.map(function (pubcategory) {
                pubcategory.selected = false;
            });
            $scope.selectedPubCategory = selectedPubCategory;
            $scope.selectedPubCategory.selected = true;
        };

        $scope.isDefaultCategorySelected = function () {
            var selectedCategories = $scope.selectedCategories();
            for (var i in selectedCategories) {
                if (selectedCategories[i].name === 'Default') {
                    return true;
                }
            }
            return false;
        };

        $scope.getTotalSelected = function () {
            var sum = 0;

            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    sum += category.cards.length;
                }
            });

            return sum;
        };

        $scope.getTotalPubSelected = function () {
            var sum = 0;

            $scope.pubcategories.forEach(function (pubcategory) {
                if (pubcategory.selected) {
                    sum += pubcategory.cards.length;
                }
            });

            return sum;
        };

        $scope.$watch('newCategoryName', function() {
            $scope.newCategoryNameOk()
        });

        $scope.newCategoryNameOk = function () {
            if(!$scope.newCategoryName || $scope.newCategoryName.length === 0) return false
            for (i = 0; i < $scope.categories.length; i++) {
                if ($scope.categories[i].name == $scope.newCategoryName) {
                    return false;
                }
            }
            return true;
        };

        $scope.categoryNameOk = function (name) {
            for (i = 0; i < $scope.categories.length; i++) {
                if ($scope.categories[i] !== $scope.selectedCategory && $scope.categories[i].name === name) {
                    return false;
                }
            }
            return true;
        };

        $scope.openDialog = function (dialogName) {
            if (dialogName == 'categoriesRename') {
                $scope.categoryToRename = angular.copy($scope.selectedCategory.name);
            }
            $scope.dialogs[dialogName] = ngDialog.open($scope.dialogsOptions[dialogName]);
            $scope.newCategoryName = "";
        };

        $scope.selectAllCards = function () {
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    category.cards.forEach(function (card) {
                        card.selected = true;
                    });
                }
            });
            $scope.allCardsSelected = true;
        };

        $scope.clearAllCards = function () {
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    category.cards.forEach(function (card) {
                        card.selected = false;
                    });
                }
            });
            $scope.allCardsSelected = false;
        };

        $scope.selectAllPubCards = function () {
            $scope.pubcategories.forEach(function (pubcategory) {
                if (pubcategory.selected) {
                    pubcategory.cards.forEach(function (card) {
                        card.selected = true;
                    });
                }
            });
            $scope.allPubCardsSelected = true;
        };

        $scope.clearAllPubCards = function () {
            $scope.pubcategories.forEach(function (pubcategory) {
                if (pubcategory.selected) {
                    pubcategory.cards.forEach(function (card) {
                        card.selected = false;
                    });
                }
            });
            $scope.allPubCardsSelected = false;
        };

        $scope.selectedCategories = function () {
            return $scope.categories.filter(function (category) {
                return category.selected;
            });
        };

        $scope.selectedPubCategories = function () {
            return $scope.pubcategories.filter(function (pubcategory) {
                return pubcategory.selected;
            });
        };

        $scope.selectedCards = function () {
            if ($scope.selectedCategory) {
                return $scope.selectedCategory.cards.filter(function (card) {
                    return card.selected;
                });
            }
            return [];
        };

        $scope.selectedPubCards = function () {
            if ($scope.selectedPubCategory) {
                return $scope.selectedPubCategory.cards.filter(function (card) {
                    return card.selected;
                });
            }
            return [];
        };

        $scope.removeFromList = function (category, sentence_ids) {
            //api.removeSentenceFromCategory
            $http.post(
                '/api/1.0/sentencecategory/sentence/delete/',
                angular.toJson({list_id: category.id, sentence_id: sentence_ids}),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        category.cards = resp.data.cards;
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );                
                
        };

        $scope.copyToList = function (source, destination, sentence_ids) {
            //api.copySentenceToCategory
            $http.post(
                '/api/1.0/sentencecategory/sentence/copy/',
                angular.toJson({
                    source_list_id: source.id,
                    destination_list_id: destination.id,
                    sentence_id: sentence_ids
                }),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        destination.cards = destination.cards.concat(resp.data.cards);
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );
                
        };

        $scope.copyPubToList = function (source, destination, sentence_ids) {
            //api.copyPubSentenceToCategory
            $http.post(
                '/api/1.0/pubsentencecategory/sentence/copy/',
                angular.toJson({
                    source_list_id: source.id,
                    destination_list_id: destination.id,
                    sentence_id: sentence_ids
                }),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        destination.cards = destination.cards.concat(resp.data.cards);
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );
        };

        $scope.moveToList = function (source, destination, sentence_ids) {
            $http.post(
                '/api/1.0/sentencecategory/sentence/move/',
                angular.toJson({
                    source_list_id: source.id,
                    destination_list_id: destination.id,
                    sentence_id: sentence_ids
                }),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        
                        destination.cards = resp.data.destination_cards || [];
                        source.cards = resp.data.source_cards || [];
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );
        };

        $scope.cardsDelete = function () {
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    var selectedCardsIds = [];
                    category.cards.forEach(function (card) {
                        if (card.selected) {
                            selectedCardsIds.push(card.sentence.id);
                        }
                    });
                    $scope.removeFromList(category, selectedCardsIds);
                }
            });
        };

       /*  $scope.cardsCopy = function () {
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    var selectedCardsIds = [];
                    category.cards.forEach(function (card) {
                        if (card.selected) {
                            selectedCardsIds.push(card.word.id);
                        }
                    });
                    $scope.copyToList(category, $scope.copyDestination, selectedCardsIds);
                }
            });
            $scope.dialogs.cardsCopy.close();
        }; */

        $scope.cardsCopy = function () {
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    var selectedCardsIds = [];
                    category.cards.forEach(function (card) {
                        if (card.selected) {
                            selectedCardsIds.push(card.sentence.id);
                        }
                    });
                    $scope.copyToList(category, $scope.copyDestination, selectedCardsIds);
                }
            });

            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    category.cards.forEach(function (card) {
                        card.selected = false;
                    });
                }
            })
            $scope.dialogs.cardsCopy.close();
        };

        $scope.cardsPubCopy = function () {
            $scope.pubcategories.forEach(function (pubcategory) {
                if (pubcategory.selected) {
                    var selectedCardsIds = [];
                    pubcategory.cards.forEach(function (card) {
                        if (card.selected) {
                            selectedCardsIds.push(card.id);
                        }
                    });
                    $scope.copyPubToList(pubcategory, $scope.copyDestination, selectedCardsIds);
                }
            });
            $scope.dialogs.cardsPubCopy.close();
        };


        $scope.cardsMove = function () {
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    var selectedCardsIds = [];
                    category.cards.forEach(function (card) {
                        if (card.selected) {
                            selectedCardsIds.push(card.sentence.id);
                        }
                    });
                    $scope.moveToList(category, $scope.moveDestination, selectedCardsIds);
                }
            });
            $scope.dialogs.cardsMove.close();
        };

        $scope.categoriesDelete = function () {
            var categories = $scope.selectedCategories();
            var categoriesUris = categories.map(function (category) {
                // category's URI (not ID alone)
                return '/api/1.0/sentencecategory/' + category.id + '/';
            });
            //api.deleteSentenceCategories
            $http.patch(
                '/api/1.0/sentencecategory/',
                angular.toJson({
                    'objects': [],
                    'deleted_objects': categoriesUris
                }),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        for (var i in categories) {
                            var deletedCategory = categories[i];
                            var idx = $scope.categories.indexOf(deletedCategory);
                            $scope.categories.splice(idx, 1);
                        }
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );

            $scope.dialogs.categoriesDelete.close();
        };

        $scope.categoriesCopy = function () {
            var categoriesNames = $scope.selectedCategories().map(function (category) {
                return category.name;
            });
            //api.copySentenceCategories
            $http.post(
                '/api/1.0/sentencecategory/copy/',
                angular.toJson({categories_names: categoriesNames}),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        $scope.categories = $scope.categories.concat(resp.data.categories);
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );
            $scope.dialogs.categoriesCopy.close();
        };

        $scope.pubcategoriesSave = function () {
            var categoriesNames = $scope.selectedPubCategories().map(function (pubcategory) {
                return pubcategory.name;
            });

            //api.copyPubSentenceCategories
            $http.post(
                '/api/1.0/pubsentencecategory/copy/',
                angular.toJson({categories_names: categoriesNames}),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        api.getSentenceCategories().then(function (categories) {
                            $scope.categories = categories;
                            $scope.showPublicLists = false;
                        });
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );

            $scope.dialogs.pubcategoriesSave.close();
        };


        $scope.categoriesNew = function (name) {
            //api.createSentenceCategory
            $http.post(
                '/api/1.0/sentencecategory/',
                angular.toJson({name: name}),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                })
                .then(
                    function response(resp) {
                        $scope.categories.push(resp.data);                        
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );

            $scope.dialogs.categoriesNew.close();
        };

        $scope.categoryRename = function (newName) {
            //api.renameCategories
            $http.put(
                '/api/1.0/sentencecategory/' + $scope.selectedCategory.id + '/',
                angular.toJson({
                    id: $scope.selectedCategory.id,
                    name: newName
                }),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        api.getSentenceCategories().then(function (categories) {
                            $scope.categories = categories;
                            $scope.copyDestination = $scope.categories[0];
                            $scope.moveDestination = $scope.categories[0];
                        });
                    },
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );
                /* .success(function (data) {
                    api.getSentenceCategories().then(function (categories) {
                        $scope.categories = categories;
                        $scope.copyDestination = $scope.categories[0];
                        $scope.moveDestination = $scope.categories[0];
                    });
                }); */

            $scope.dialogs.categoriesRename.close();
        };
    });
