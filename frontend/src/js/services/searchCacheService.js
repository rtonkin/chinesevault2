angular.module('putonghua')
    .factory('searchcacheService', function($http) {
        var getData = function(item, last) {
            var url = '/api/1.0/word/search/?q==' + item + '&target=chinese'; // __exact
            return $http({method:'GET', cache: false, url:url}).then(function(result){//change cache to false
                var arr = result.data.chinese;
                var word = arr[0];
                if (word) {
                    arr_remove(arr, 0);
                    word.another_meanings_references = [];
                    arr.forEach(function(item, i, arr) {
                            word.another_meanings_references = word.another_meanings_references.concat(item.meanings_references);
                        });
                    word.pinyinSortedMeanings = result.data.pinyin_sorted_meaning_reference;
                    return word;
                }
                else {
                   return null;
                 }
            });
            };
        return { getData: getData };
    });
