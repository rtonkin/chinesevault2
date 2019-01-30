angular.module('putonghua')
    .factory('WordList', function ($http, api, Auth, ngDialog) {
        var WordList = {};

        var addToList = function(word, category) {
            //api.addWordTOList
            $http.post(
                '/api/1.0/category/word/add/',
                angular.toJson({
                    name: category.name,
                    word_id: word.id
                }),
                {
                    headers: {'Content-Type': 'application/json'},
                    withCredentials: true
                }).then(
                    function response(resp) {
                        
                            word.added = true;
                            if (!(category.name in word.categories)) {
                                word.categories.push(category.name);
                            }
                        
                    },    
                    function failure(data) {
                        alert("We had a network connection problem. Please try again later.");
                    }
                );
                /* .success(function (data) {
                    word.added = true;
                    if (!(category.name in word.categories)) {
                        word.categories.push(category.name);
                    }
                })
                .error(function () {
                }); */
        };
        WordList.openAddToListDialog = function (word) {
                if (!Auth.isLoggedIn()) {
                    Auth.requireLogin('/');
                }
                else {
                    api.getCategoriesFast().then(function(categories) {
                        /* console.log(categories) */
                        var categories = categories;
                        var destinationCategory = categories[0];
                        var result = {};
                        result.word = word;
                        result.addToListDialog = ngDialog.open({
                            template: '/static/templates/dialogs/add_to_list.html',
                            className: 'ngdialog-theme-default ngdialog-theme-custom',
                            data: {'item':word,
                                   'itemName':'word',
                                   'categories':categories,
                                   'addToList':addToList,
                                   'destinationCategory':destinationCategory}
                        });
                        return result;
                    });
                }
            };

        return WordList;
    });
