angular.module('putonghua')
    .controller('DictionaryController', function ($document, blockUI, $rootScope, $scope, $timeout, $q, $stateParams, $location, api, ngDialog, Auth, $state, WordList, AppConfig) {

        document.title = "Free Chinese / English Dictionary - ChineseVault.com";
        var allMetaElements = document.getElementsByTagName('meta');
        for (var i = 0; i < allMetaElements.length; i++) {
            if (allMetaElements[i].getAttribute("name") == "description") {
                allMetaElements[i].setAttribute('content', "Completely free Chinese / English dictionary with over 100,000 entries and full audio. Search in Chinese, English or Pinyin, and see example sentences.");
            } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                allMetaElements[i].setAttribute('content', "chinese english dictionary, free chinese dictionary, online dictionary, chinese definitions, chinese characters");
            }
        }
        $scope.features = AppConfig.features;
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
        $scope.resetQuery = function () {
            $scope.chinese_page = 0;
            $scope.english_page = 0;
            // clear search results on new query
            $scope.searchResults = {
                chinese: [],
                chinese_visible: [],
                chinese_total_count: 0,
                english: [],
                english_visible: [],
                english_total_count: 0
            };
            $scope.search($scope.query);
        };
        $scope.search = function (query, page, language) {
            if (!query || query.trim().length <= 0) {
                return;
            }
            if (angular.isDefined($scope.canceler)) {
                // cancel all previous ajax requests
                $scope.canceler.resolve();
            }
            $scope.canceler = $q.defer();
            if (!page) {
                $scope[language + '_page'] = page = 0;
            }
            var page = page;
            var log = 1;
            var target = '';
            if (language) {
                target = language;
            }
            httpConfig = { timeout: $scope.canceler.promise };
            localStorage.setItem('querystring', $scope.query);
            api.searchWord(query, page, target, log, httpConfig).then(function (data) {
                // update chinese results if language is 'chinese' or not provided
                if (language !== 'english') {
                    $scope.searchResults.chinese = $scope.searchResults.chinese.concat(data.chinese);
                    $scope.searchResults.chinese_visible = $scope.searchResults.chinese_visible.concat(data.chinese);
                    $scope.searchResults.chinese_total_count = data.chinese_total_count;
                }
                // update english results if language is 'english' or not provided
                if (language !== 'chinese') {
                    $scope.searchResults.english = $scope.searchResults.english.concat(data.english);
                    $scope.searchResults.english_visible = $scope.searchResults.english_visible.concat(data.english);
                    $scope.searchResults.english_total_count = data.english_total_count;
                }
                $scope.loadedFlag = true;
            },
            function () {
                $scope.loadedFlag = false;
            });
        };
        $scope.collapseResults = function (language) {
            $scope.searchResults[language + '_visible'] = $scope.searchResults[language].slice(0, $scope.results_per_page);
            $scope[language + '_page'] = 0;
        };
        $scope.addResults = function (language) {
            $scope.addResultsPage(language);
        };
        $scope.addResultsPage = function (language) {
            $scope[language + '_page'] += 1;
            $scope.search($scope.query, $scope[language + '_page'], language);
        };
        $scope.categories = [];
        $scope.destinationCategory = $scope.categories[0];
        api.getCategoriesFast().then(function (items) {
            $scope.categories = items;
            $scope.destinationCategory = items[0];
        });
        $scope.openAddToListDialog = WordList.openAddToListDialog;
        // Event Listeners
        var timeoutPromise;
        var delayInMs = 1500;
        $scope.$watch('query', function () {
            $scope.searchResults.chinese = [];
            $scope.searchResults.english = [];
            $timeout.cancel(timeoutPromise);  //does nothing, if timeout alrdy done
            timeoutPromise = $timeout(function () {   //Set timeout
                $location.search('q', $scope.query);
            }, delayInMs);
        });
        $scope.$on('$locationChangeSuccess', function () {
             /* angular.element('#queryField').trigger('focus');
             $scope.query = $stateParams.q; */
             $scope.resetQuery();
        }); 
        $scope.chinese_page = 0;
        $scope.english_page = 0;
        $scope.results_per_page = 10;
        $scope.searchResults = {
            chinese: [],
            chinese_visible: [],
            chinese_total_count: 0,
            english: [],
            english_visible: [],
            english_total_count: 0
        };
        $scope.options = {
            results: 'both',
            characters: 'simplified'
        };
        $scope.isEmpty = function (obj) {
            for (var key in obj) {
                if (obj.hasOwnProperty(key))
                    return false;
            }
            return true;
        }
         $scope.$emit('$locationChangeSuccess');
        /* console.log("qqqqqq",$location.search()) */
        if ($scope.isEmpty($location.search())) {
            localStorage.removeItem('querystring');
        } else{
            localStorage.setItem('querystring',$location.search().q);
        }
        var querystring = localStorage.getItem('querystring');
        if (typeof querystring != 'undefined') {
            $scope.query = querystring;
            $scope.resetQuery();
        }
    });