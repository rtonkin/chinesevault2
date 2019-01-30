angular.module('putonghua')
    .factory('api', ['Restangular', '$cacheFactory', function(Restangular, $cacheFactory){

    var service = {
        getCountries: getCountries,
        getCountry: getCountry,
        getProfile: getProfile,
        getSubtitleds: getSubtitleds,
        getSubtitled: getSubtitled,
        getCategories: getCategories,
        getCategory: getCategory,
        getSentenceCategories: getSentenceCategories,
        getSentenceCategory: getSentenceCategory,
        getPubCategories: getPubCategories,
        getPubCategoriesFast: getPubCategoriesFast,
        getPubCategory: getPubCategory,
        getWord: getWord,
        getLatestSearches: getLatestSearches, // cache: false
        getRandomWords: getRandomWords, // cache: false
        getRandomTitles: getRandomTitles, // cache: false
        searchWord: searchWord,
        searchChineseWord: searchChineseWord,
        getLesson: getLesson,
        getLessons: getLessons,
        getPopularLessons: getPopularLessons,
        getStudyContent: getStudyContent,
        getStudyContents: getStudyContents,
        getSentenceVoice: getSentenceVoice,
        getWordVoice: getWordVoice,
        switchLessonStatus: switchLessonStatus,
        addSentenceToList: addSentenceToList,
        addWordToList: addWordToList,
        createCategory: createCategory,
        renameCategory: renameCategory,
        removeWordsFromList: removeWordsFromList,
        copyWordsToList: copyWordsToList,
        copyPubWordsToList: copyPubWordsToList,
        moveWordsToList: moveWordsToList,
        copyCategories: copyCategories,
        copyPubCategories: copyPubCategories,
        renameCategory : renameCategory,
        deleteCategories : deleteCategories,
        markCategoryTested : markCategoryTested,
        markSentenceCategoryTested: markSentenceCategoryTested,
        markWordTested : markWordTested,
        getCategoriesFast: getCategoriesFast,
        getCategoryFast: getCategoryFast,
        textToolSplitChinese: textToolSplitChinese,
        getVideoStudyItems: getVideoStudyItems,
        getAudioStudyItems: getAudioStudyItems,
        getAudioStudyItem: getAudioStudyItem,
        getVideoStudyItem: getVideoStudyItem,
        getSubscription: getSubscription,
        createSubscription: createSubscription,
        deleteSubscription: deleteSubscription,
        completeLesson: completeLesson,
        postReason: postReason,
        getVoices: getVoices,
        getVoice: getVoice,
        getChineseNames: getChineseNames,
        addWords: addWords,
        renewSubscription: renewSubscription,
        getWordofTheDay: getWordofTheDay,
        getFeaturedcontent: getFeaturedcontent
    };

        var cache;

       // Creates the cache
        service.init = function() {
            cache = $cacheFactory('http');
            Restangular.setDefaultHttpFields({cache: cache});

            Restangular.setResponseInterceptor(function(response, operation) {
                cache.removeAll();
               // if (operation === 'put' || operation === 'post' || operation === 'remove' || operation ==="get") {
               //     cache.removeAll();
               // }
               return response;
           })

        };

    function gList(resourceName, params, httpConfig) {
        params = typeof params !== 'undefined' ? params : {};
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
       /*  console.log('gList', resourceName, 'params', params, 'http', httpConfig); */
        return Restangular.all(resourceName)
                          .withHttpConfig(httpConfig)
                          .getList(params);
    }

    function gOne(resourceName, id, params, httpConfig) {
        params = typeof params !== 'undefined' ? params : {};
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        /* console.log('gOne', resourceName, id, params, httpConfig); */
        if (typeof id == 'undefined') {
            return Restangular.one(resourceName)
                              .withHttpConfig(httpConfig)
                              .get(params);
                      }
        else {
            return Restangular.one(resourceName, id)
                      .withHttpConfig(httpConfig)
                      .get(params);
        }
    }

    
    function getCountries(params, httpConfig){
        return gList('country', params, httpConfig);
    }

    function getCountry(id, params, httpConfig){
        return gOne('country', id, params, httpConfig);
    }

    function getSubtitleds(params, httpConfig){
        return gList('subtitled', params, httpConfig);
    }

    function getSubtitled(id, params, httpConfig){
        return gOne('subtitled', id, params, httpConfig);
    }

    function getCategories(params, httpConfig){
        return gList('category', params, httpConfig);
    }

    function getCategoriesFast(params, httpConfig) {
        return gList('category/nocategories', params, httpConfig);
    }


    function getPubCategoriesFast(params, httpConfig) {
        return gList('pubcategory/nocategories', params, httpConfig);
    }



    function getCategory(id, params, httpConfig){
        return gOne('category', id, params, httpConfig);
    }

    function getCategoryFast(id, params, httpConfig) {
        params = typeof params !== 'undefined' ? params : {};
        params.nocategories = 1;
        return getCategory(id, params, httpConfig);
    }


    function getSentenceCategories(params, httpConfig){
        return gList('sentencecategory', params, httpConfig);
    }

    function getSentenceCategory(id, params, httpConfig){
        return gOne('sentencecategory', id, params, httpConfig);
    }

    function getPubCategories(params, httpConfig){
        return gList('pubcategory', params, httpConfig);
    }

    function getPubCategory(id, params, httpConfig){
        return gOne('pubcategory', id, params, httpConfig);
    }

    function getWord(id, params, httpConfig){
        return gOne('word', id, params, httpConfig);
    }

    function getLatestSearches(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = false;
        return gOne('search/latest', undefined, params, httpConfig);
    }

    function getProfile(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = false;
        return gOne('profile', undefined, params, httpConfig);
    }

    function getRandomWords(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = false;
        return gOne('word/random', undefined, params, httpConfig);
    }


    function getRandomTitles(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = false;
        return gOne('random_titles', undefined, params, httpConfig);
    }

    function getWordofTheDay(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = false;
        return gOne('wordoftheday', undefined, params, httpConfig);
    }

    /* http://localhost:8000/api/1.0/wordoftheday/?format=json */

    function getFeaturedcontent(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = false;
        return gOne('featuredcontent', undefined, params, httpConfig);
    }

    function getPopularLessons(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        return gOne('lesson/popular', undefined, params, httpConfig);
    }

    function getSubscription(params, httpConfig){
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = false;
        return gOne('subscription', undefined, params, httpConfig);
    }

    function createSubscription(stripe_token, username){
        result = Restangular.all('subscription')
                    .withHttpConfig({withCredentials: true})
                    .post({
                        stripe_token: stripe_token,
                        username: username
                    });
       /*  console.log('result', result); */
        return result
    }


    function deleteSubscription(){
        return Restangular.all('subscription')
                          .remove()
    }

    function renewSubscription(){
        result = Restangular.all('retrivew_subsciption')
                          .withHttpConfig({withCredentials: true})
                          .post({});
         return result
    }

    function searchWord(query, page, target, log, httpConfig) {
        return gOne('word/search', undefined, {
                q: query,
                page: page,
                target: target,
                log: log
            }, httpConfig);
    }

    function searchChineseWord(query, httpConfig) {
        httpConfig = typeof httpConfig !== 'undefined' ? httpConfig : {};
        httpConfig.cache = true;
        var page = null;
        var target = 'chinese';
        var log = false;
        return searchWord('='+query, page, target, log).then(function(result){
            var arr = result.chinese;
            var word = arr[0];
            if (word) {
                arr_remove(arr, 0);
                word.another_meanings_references = [];
                arr.forEach(function(item, i, arr) {
                        word.another_meanings_references = word.another_meanings_references.concat(item.meanings_references);
                    });
                word.pinyinSortedMeanings = result.pinyin_sorted_meaning_reference;
                return word;
            }
            else {
               return null;
             }
        });
        }

    function getLesson(id, params, httpConfig) {
        return gOne('lesson', id, params, httpConfig);
    }

      function getChineseNames(id, params, httpConfig) {
        return gList('chinesenames', {limit: 0}, httpConfig);
    }

    function addWords(chinese, english, pinyin) {
        return Restangular.all('/suggestwords/add')
                          .withHttpConfig({withCredentials: true})
                          .post({
                                    chinese: chinese,
                                    english: english,
                                    pinyin: pinyin
                                 });
    }
    
    function getLessons(id, params, httpConfig) {
        return gList('lesson', params, httpConfig);
    }

    function getStudyContent(id, params, httpConfig) {
        return gOne('studycontent', id, params, httpConfig);
    }

    function getStudyContents(id, params, httpConfig) {
        return gList('studycontent', params, httpConfig);
    }

    function getSentenceVoice(id, params, httpConfig) {
        return gOne('sentence/'+id+'/voice/', params, httpConfig);
    }

    function getWordVoice(id, params, httpConfig) {
        return gOne('word/'+id+'/voice/', params, httpConfig);
    }

    function switchLessonStatus(id, params, httpConfig) {
        if (id===undefined) {
            throw new Error('Undefined id in switchLessonStatus');
        }
        return Restangular.all('lesson/'+id+'/switch_learned_status').post();
    }


    function completeLesson(id, params, httpConfig) {
        if (id===undefined) {
            throw new Error('Undefined id in completeLesson');
        }
        return Restangular.all('lesson/'+id+'/complete').post();
    }

    function addSentenceToList(category, sentence) {
        return Restangular.all('sentencecategory/sentence/add')
                .withHttpConfig({withCredentials: true})
                .post({
                    name: category.name,
                    sentence_id: sentence.id
                });
    }

    function addWordToList(category, word) {
        return Restangular.all('category/word/add')
                          .withHttpConfig({withCredentials: true})
                          .post({
                                    name: category,
                                    word_id:word.id
                                 });
    }


    function createCategory(category) {
        return Restangular.all('category')
                          .withHttpConfig({withCredentials: true})
                          .post({name: category});
    }


    function removeWordsFromList(category, word_ids) {
        return Restangular.all('category/word/delete')
                          .withHttpConfig({withCredentials: true})
                          .post({list_id: category.id, word_id: word_ids});
    }


    function copyWordsToList(source, destination, word_ids) {
        return Restangular.all('category/word/copy')
                          .withHttpConfig({withCredentials: true})
                          .post({
                                source_list_id: source.id,
                                destination_list_id: destination.id,
                                word_id: word_ids
                            });
    }

    function copyPubWordsToList(source, destination, word_ids) {
        return Restangular.all('pubcategory/word/copy')
                          .withHttpConfig({withCredentials: true})
                          .post({
                                source_list_id: source.id,
                                destination_list_id: destination.id,
                                word_id: word_ids
                            });
    }


    function moveWordsToList(source, destination, word_ids) {
        return Restangular.all('category/word/move')
                          .withHttpConfig({withCredentials: true})
                          .post({
                                source_list_id: source.id,
                                destination_list_id: destination.id,
                                word_id: word_ids
                            });
    }

    function copyCategories(categoriesNames) {
        return Restangular.all('category/copy')
                          .withHttpConfig({withCredentials: true})
                          .post({categories_names: categoriesNames});
    }

    function copyPubCategories(categoriesNames) {
        return Restangular.all('pubcategory/copy')
                          .withHttpConfig({withCredentials: true})
                          .post({categories_names: categoriesNames});
    }


    function renameCategory(category, newName) {
        return Restangular.one('category')
                          .withHttpConfig({withCredentials: true})
                          .customPUT({
                                    id: category.id,
                                    name: newName
                                }, category.id);
    }

    function deleteCategories(categories) {
        var categoriesUris = categories.map(function (category) {
            // category's URI (not ID alone)
            // FIX
            return '/api/1.0/category/' + category.id + '/';
        });

        return Restangular.all('category')
                          .withHttpConfig({withCredentials: true})
                          .patch({
                                'objects': [],
                                'deleted_objects': categoriesUris
                            });
    }

    function markCategoryTested(category, lastPracticed) {
        return Restangular.one('category')
                          .withHttpConfig({withCredentials: true})
                          .customPUT({
                                'id': category.id,
                                'last_practiced': lastPracticed
                            }, category.id);
    }

    function markSentenceCategoryTested(category, lastPracticed) {
        return Restangular.one('sentencecategory')
                          .withHttpConfig({withCredentials: true})
                          .customPUT({
                                'id': category.id,
                                'last_practiced': lastPracticed
                            }, category.id);
    }

    function markWordTested(word, lastPracticed, score, timesTested) {
        return Restangular.one('card')
                          .withHttpConfig({withCredentials: true})
                          .customPUT({
                                'id': word.id,
                                'last_practiced': lastPracticed,
                                'score': score,
                                'times_tested': timesTested
                            }, word.id);
    }


    function textToolSplitChinese(text) {
        return Restangular.all('texttool').post({text:text})
    }


    function getAudioStudyItems(params, httpConfig){
        return gList('audiostudyitem', params, httpConfig);
    }

    function getAudioStudyItem(id, params, httpConfig){
        return gOne('audiostudyitem', id, params, httpConfig);
    }

    function getVideoStudyItems(params, httpConfig){
        /*return gList('videostudyitem', params, httpConfig);*/
    }

    function getVideoStudyItem(id, params, httpConfig){
        /*return gOne('videostudyitem', id, params, httpConfig);*/
    }

    function postReason(params) {
       return Restangular.all('reason').post({reason: params})
    }

    function getVoices(params) {
        return Restangular.all('voices').post({count: params})
    }

    function getVoice(id) {
        return Restangular.one('voices', id).get()
    }


    return service;

}])
.factory('HTTPCache', ['Restangular', '$cacheFactory',
  function(Restangular, $cacheFactory) {
   return {};
}]);
