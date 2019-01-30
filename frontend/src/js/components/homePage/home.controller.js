/**
 * Created by svfat on 4/5/16.
 */
angular.module('putonghua').controller('HomeController', function ($window, $scope, $state, api, AppConfig, TestSettings, $timeout, $location) {
    document.title = "ChineseVault.com – Free ChineseDictionary, Flashcards, Lessons and more";

    var allMetaElements = document.getElementsByTagName('meta');

    for (var i = 0; i < allMetaElements.length; i++) {
        if (allMetaElements[i].getAttribute("name") == "description") {
            allMetaElements[i].setAttribute('content', "With a free Chinese / English dictionary, Chinese lessons, flashcards, video and audio study content, as well as text analysis tools, we have everything you need to master the Chinese language.");
        } else if (allMetaElements[i].getAttribute("name") == "keywords") {
            allMetaElements[i].setAttribute('content', "free chinese dictionary, free chinese lessons, chinese flashcards, chinese study content, chinese tools");
        }
    }



    $scope.query = '';
    $scope.email = '';
    $scope.features = AppConfig.features; // enabled features

    $scope.lastSearches = [];
    $scope.randomCharacters = [];
    $scope.wordofTheDay = [];


    /* $scope.submitSignup = function () {
        console.log("query email....",$scope.email);
        $state.go('signup', { 'email': $scope.email });
    }; */

    $scope.submitSignup = function () {
        $state.go('signup', {'email': $scope.email});
    };

    api.getLatestSearches().then(function (searches) {
        $scope.lastSearches = searches;
        /* console.log('lastSearches............', $scope.lastSearches); */
    });

    api.getRandomWords().then(function (words) {
        $scope.randomCharacters = words;
    });
    /* $scope.mySplit = function(string, nb) {
        var array = string.split('-');
        return array[nb];
    } */
    api.getWordofTheDay().then(function (words) {
        if(words.objects != 'null'){
            $scope.wordofTheDay = words.objects;
        }
    });

    api.getFeaturedcontent().then(function (content) {
        if(content.objects != 'null'){
            $scope.featuredContent = content.objects;
        }
    });
    
    $scope.setPageId= function(content){
        localStorage.setItem('s_page_id', content);        
    }
    var searchDelay;

    $scope.submitQuery = function () {
        $scope.$watch('query', function () {
            $timeout.cancel(searchDelay);
            localStorage.setItem('querystring', $scope.query);
            searchDelay = $timeout(function () {
                $state.go('dictionary', { 'q': $scope.query });
            }, 2000);
        })
    };

    
    $scope.clickTones = function () {
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
            TestSettings.options.mode = "tonepracticewithaudio";
            TestSettings.options.number = 30;
            $state.go('test');
        });

    }

}).config(function ($mdIconProvider) {
    $mdIconProvider
        .iconSet('social', 'img/icons/sets/social-icons.svg', 24)
        .iconSet('device', 'img/icons/sets/device-icons.svg', 24)
        .iconSet('communication', 'img/icons/sets/communication-icons.svg', 24)
        .defaultIconSet('img/icons/sets/core-icons.svg', 24);
});