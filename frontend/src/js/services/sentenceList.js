angular.module('putonghua')
    .factory('SentenceList', function (Auth, api, ngDialog) {
        var SentenceList = {};

        var addToList = function(sentence, category) {
            api.addSentenceToList(category, sentence).then(function (data) {
                    sentence.added = true;
                    if (!(category.name in sentence.categories)) {
                        sentence.categories.push(category.name);
                    }
                })
        };

        SentenceList.openAddToListDialog = function (sentence) {
              /*   console.log(sentence) */
                if (!Auth.isLoggedIn()) {
                    Auth.requireLogin('/');
                }
                else {
                    api.getSentenceCategories().then(function(categories) {
                        var destinationCategory = categories[0];
                        var result = {};
                        result.sentence = sentence;
                        result.addToListDialog = ngDialog.open({
                            template: '/static/templates/dialogs/add_to_list.html',
                            className: 'ngdialog-theme-default ngdialog-theme-custom',
                            data: {'item':sentence,
                                   'itemName':'sentence',
                                   'categories':categories,
                                   'addToList':addToList,
                                   'destinationCategory':destinationCategory}
                        });
                        return result;
                    });
                }
            };

        return SentenceList;
    });
