/**
 * Created by svfat on 6/5/16.
 */
angular.module('putonghua')
    .controller('ArrangeCardsController', function ($scope, $filter, $http, api, ngDialog, $state, $mdDialog) {
        $scope.categories = [];
        $scope.copyDestination = null;
        $scope.moveDestination = null;
        $scope.allCardsSelected = false;
        $scope.selectedCategory = null;
        $scope.categoryToRename = null;

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

        $scope.pagination = {};
        $scope.pagination.filteredCards = [];
        $scope.loading = true;

        function resetPagination() {
            $scope.pagination.currentPage = 1;
            $scope.pagination.pageSize = 15;
            $scope.pagination.totalItems = 0;
            $scope.pagination.steps = 0;
            $scope.pagination.pages = 0;
            $scope.pagination.filteredCards.length = 0;
        }
        resetPagination();

        $scope.changePage = function () {
            var begin = (($scope.pagination.currentPage - 1) * $scope.pagination.pageSize);
            var end = begin + $scope.pagination.pageSize;
            
            if ($scope.selectedCategory) {
                $scope.pagination.totalItems = $scope.selectedCategory.cards.length;
                $scope.pagination.filteredCards = $scope.selectedCategory.cards.slice(begin, end);
            }
            else if ($scope.selectedPubCategory) {
                $scope.pagination.totalItems = $scope.selectedPubCategory.cards.length;
                $scope.pagination.filteredCards = $scope.selectedPubCategory.cards.slice(begin, end);
            }
            
        }

        $scope.tableEmpty = function() {
            resetPagination()
            $scope.allCardsSelected = false;
            $scope.allPubCardsSelected = false;
            $scope.selectedCategory = null;
            $scope.selectedPubCategory = null;
            if ($scope.showPublicLists) {
                api.getPubCategoriesFast({}, {}).then(function (pubcategories) {
                    $scope.pubcategories = pubcategories;
                });
            } else {
                api.getCategoriesFast().then(function (categories) {
                    $scope.categories = categories;
                    $scope.copyDestination = $scope.categories[0];
                    $scope.moveDestination = $scope.categories[0];
                });
            }
        }

        $scope.pagination.beginPage = function () {
            return ($scope.pagination.currentPage-1) * $scope.pagination.pageSize;
        };

        function recalculateFilteredCards() {
            $scope.pagination.filteredCards.length = 0;
            
            if ($scope.showPublicLists) {
              $scope.pagination.filteredCards =  $filter('limitTo')
              ($scope.selectedPubCategory.cards, $scope.pagination.pageSize, $scope.pagination.beginPage());
            } else {
              $scope.pagination.filteredCards =  $filter('limitTo')
              ($scope.selectedCategory.cards, $scope.pagination.pageSize, $scope.pagination.beginPage());
            }
        }


        api.getCategoriesFast().then(function (categories) {
            $scope.categories = categories;
            $scope.copyDestination = $scope.categories[0];
            $scope.moveDestination = $scope.categories[0];
        });


        api.getPubCategoriesFast({}, {cache: true}).then(function (pubcategories) {
            $scope.pubcategories = pubcategories;
        });

        $scope.$watch('newCategoryName', function() {
            $scope.newCategoryNameOk()
        });

        $scope.selectCategory = function (selectedCategory) {
            $scope.allCardsSelected = false;
            $scope.pagination.steps = 0;
            $scope.pagination.pages = 0;
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    category.cards.forEach(function (card) {
                        card.selected = false;
                    });
                }
            })
            
            $scope.selectedCategory = selectedCategory;
            $scope.loading = true;
            api.getCategory(selectedCategory.id).then(function (category) {
                resetPagination();
                $scope.selectedCategory.cards = category.cards;
                $scope.loadingWordsForCategory = true;
                $scope.categories.map(function (category) {
                    category.selected = false;
                });
                $scope.selectedCategory.selected = true;
                $scope.loading = false;
                $scope.pagination.totalItems = $scope.selectedCategory.cards.length;
                $scope.pagination.steps = parseInt($scope.pagination.totalItems % $scope.pagination.pageSize);
                if($scope.pagination.steps == 0) {
                    $scope.pagination.steps = parseInt($scope.pagination.totalItems / $scope.pagination.pageSize);   
                } else{
                    $scope.pagination.steps = parseInt($scope.pagination.totalItems / $scope.pagination.pageSize) + 1;   
                } 
                $scope.pagination.pages = $scope.pagination.steps;
                if($scope.pagination.steps > 10){
                    $scope.pagination.steps = 8
                }                
                recalculateFilteredCards();
            })

        };

        $scope.selectPubCategory = function (selectedPubCategory) {
            $scope.selectedPubCategory = selectedPubCategory;
            $scope.loading = true;
            $scope.pagination.steps = 0;
            $scope.pagination.pages = 0;
            api.getPubCategory(selectedPubCategory.id).then(function (pubcategory) {
                                resetPagination();
                $scope.selectedPubCategory.cards = pubcategory.cards;
                $scope.pubcategories.map(function (pubcategory) {
                    pubcategory.selected = false;
                });
                $scope.selectedPubCategory.selected = true;
                $scope.loading = false;
                $scope.pagination.totalItems = $scope.selectedPubCategory.cards.length;
                $scope.pagination.steps = parseInt($scope.pagination.totalItems % $scope.pagination.pageSize);    
                if($scope.pagination.steps == 0) {
                    $scope.pagination.steps = parseInt($scope.pagination.totalItems / $scope.pagination.pageSize);   
                }else{
                    $scope.pagination.steps = parseInt($scope.pagination.totalItems / $scope.pagination.pageSize) + 1;   
                }          
                $scope.pagination.pages = $scope.pagination.steps;
                /* console.log("$scope.pagination.steps",$scope.pagination.steps) */
                if($scope.pagination.steps > 10){
                    $scope.pagination.steps = 8
                }
                recalculateFilteredCards();
            })
        };

        $scope.isDefaultCategorySelected = function () {
            var selectedCategories = $scope.selectedCategories();
            for (i = 0; i < selectedCategories.length; i++) {
                if (selectedCategories[i].name === 'Default') {
                    return true;
                }
            }
            return false;
        };
        $scope.testMode = function(){
            $state.go('test-settings');
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

            /* var confirm = $mdDialog.confirm()
            .title('Would you like to delete your debt?')
            .textContent('All of the banks have agreed to forgive you your debts.')
            .ariaLabel('Lucky day')
            .targetEvent(dialogName)
            .ok('Please do it!')
            .cancel('Sounds like a scam');
    
            $mdDialog.show(confirm).then(function() {
                $scope.status = 'You decided to get rid of your debt.';
            }, function() {
                $scope.status = 'You decided to keep your debt.';
            }); */

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
            if ($scope.selectedCategory && $scope.selectedCategory.cards) {
                return $scope.selectedCategory.cards.filter(function (card) {
                    return card.selected;
                });
            }
            return [];
        };

        $scope.selectedPubCards = function () {
            if ($scope.selectedPubCategory && $scope.selectedPubCategory.cards) {
                return $scope.selectedPubCategory.cards.filter(function (card) {
                    return card.selected;
                });
            }
            return [];
        };

        $scope.removeFromList = function (category, word_ids) {
            api.removeWordsFromList(category, word_ids).then(function (result) {
                category.cards = result.cards;
                $scope.pagination.filteredCards = category.cards;
                $scope.pagination.filteredCards =  $filter('limitTo')
                ($scope.pagination.filteredCards, $scope.pagination.pageSize, $scope.pagination.beginPage());
                $scope.selectedCategory.cards_count = category.cards.length;
            });

        };

        $scope.copyToList = function (source, destination, word_ids) {
            api.copyWordsToList(source, destination, word_ids).then(function (data) {
                destination.cards_count = destination.cards_count + data.cards.length;
                $scope.copyDestination.cards_count = destination.cards_count;
                $scope.pagination.filteredCards.forEach(function(element, index, array) {
                    element.selected = false;
                })
            });

        };

        $scope.copyPubToList = function (source, destination, word_ids) {
            api.copyPubWordsToList(source, destination, word_ids).then(function (data) {
                // destination.cards = destination.cards.concat(data.cards);
                destination.cards_count = destination.cards_count + data.cards.length;
            });
        };

        $scope.moveToList = function (source, destination, word_ids) {
            api.moveWordsToList(source, destination, word_ids).then(function (data) {
                destination.cards = data.destination_cards || [];
                source.cards = data.source_cards || [];
                $scope.pagination.filteredCards = source.cards;
                $scope.pagination.filteredCards =  $filter('limitTo')
                ($scope.pagination.filteredCards, $scope.pagination.pageSize, $scope.pagination.beginPage());
                $scope.selectedCategory.cards_count = source.cards.length;
                $scope.moveDestination.cards_count = destination.cards.length;
            })

        };

        $scope.cardsDelete = function () {
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    var selectedCardsIds = [];
                    category.cards.forEach(function (card) {
                        if (card.selected) {
                            selectedCardsIds.push(card.word.id);
                        }
                    });
                    $scope.removeFromList(category, selectedCardsIds);
                }
            });
            $scope.changePage();
        };

        $scope.cardsCopy = function () {
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
            $scope.pagination.filteredCards.forEach(function(element, index, array) {
                    element.selected = false;
                })
        };


        $scope.cardsMove = function () {
            var selectedCards = [];
            $scope.categories.forEach(function (category) {
                if (category.selected) {
                    var selectedCardsIds = [];
                    category.cards.forEach(function (card) {
                        if (card.selected) {
                            selectedCardsIds.push(card.word.id);
                        }
                    });
                    $scope.moveToList(category, $scope.moveDestination, selectedCardsIds);
                }
            });
            $scope.dialogs.cardsMove.close();
            $scope.changePage();
        };

        $scope.categoriesDelete = function () {
            api.deleteCategories($scope.selectedCategories()).then(function (data) {

                api.getCategoriesFast().then(function (categories) {
                    $scope.categories = categories;
                    $scope.copyDestination = $scope.categories[0];
                    $scope.moveDestination = $scope.categories[0];
                });
                resetPagination();
            });

            $scope.dialogs.categoriesDelete.close();
        };

        $scope.categoriesCopy = function () {
            var categoriesNames = $scope.selectedCategories().map(function (category) {
                return category.name;
            });

            api.copyCategories(categoriesNames).then(function (data) {
                // $scope.categories = $scope.categories.concat(data.categories);
                api.getCategoriesFast().then(function (categories) {
                    $scope.categories = categories;
                    $scope.copyDestination = $scope.categories[0];
                    $scope.moveDestination = $scope.categories[0];
                });
            });

            $scope.dialogs.categoriesCopy.close();
        };

        $scope.pubcategoriesSave = function () {
            var categoriesNames = $scope.selectedPubCategories().map(function (pubcategory) {
                return pubcategory.name;
            });
            api.copyPubCategories(categoriesNames).then(function (data) {
                // api.getCategories().then(function (categories) {
                //     $scope.categories = categories;
                //     $scope.showPublicLists = false;
                // });

                api.getCategoriesFast().then(function (categories) {
                    $scope.categories = categories;
                    $scope.copyDestination = $scope.categories[0];
                    $scope.moveDestination = $scope.categories[0];
                    //$scope.showPublicLists = false;
                });
            });

            $scope.dialogs.pubcategoriesSave.close();
        };


        $scope.categoriesNew = function (name) {
            api.createCategory(name)
                .then(function (data) {
                    
                    api.getCategoriesFast().then(function (categories) {
                        
                        $scope.categories = categories;
                        $scope.copyDestination = $scope.categories[0];
                        $scope.moveDestination = $scope.categories[0];
                    });
                });

            $scope.dialogs.categoriesNew.close();
        };

        $scope.categoryRename = function (newName) {
            api.renameCategory($scope.selectedCategory, newName)
                .then(function (data) {
                    api.getCategoriesFast().then(function (categories) {
                        $scope.categories = categories;
                        $scope.copyDestination = $scope.categories[0];
                        $scope.moveDestination = $scope.categories[0];
                    });
                });
            $scope.dialogs.categoriesRename.close();
        };
    })
;
