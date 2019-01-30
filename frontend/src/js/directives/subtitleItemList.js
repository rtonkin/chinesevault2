angular.module('putonghua')
    .directive('subtitleItemList', function(api, $state, $http) {
      return {
        restrict: 'E',
        templateUrl: '/static/templates/studyContent/subtitleItemList.html',
        scope: {
          contentType: '@'
        },
        link: function (scope, element, attrs) {
            scope.level='';
            scope.theme = '';

            scope.defaultUrl = "/api/1.0/audiostudyitem/?";

            scope.dataLevel = {
                data:  [

                    {
                        levelName:'All Levels',
                        levelUrl:''
                    },

                    {
                    levelName: 'Beginner',
                    levelUrl: '&study_level=10'
                },
                    {
                        levelName:'Intermediate',
                        levelUrl:'&study_level=20'
                    },
                    {
                        levelName:'Advanced',
                        levelUrl:'&study_level=30'
                    }
                ]
            };


            scope.dataTheme = {
                data: [
                    {
                     themeName: 'All Themes',
                       themeUrl:''
                    },
                    {
                        themeName:'Education',
                        themeUrl:'&themes=1'
                    },
                    {
                        themeName:'Hobbies',
                        themeUrl:'&themes=2'
                    },
                    {
                        themeName:'People',
                        themeUrl:'&themes=3'
                    },
                    {
                        themeName:'Society',
                        themeUrl:'&themes=4'
                    },
                    {
                        themeName:'Technology',
                        themeUrl:'&themes=5'
                    }
                ]
            };


            function getAudioItems (level, theme){
                    return $http({
                        method:'GET',
                        cache: false,
                        url:scope.defaultUrl + level + theme
                    })
            }

            if (scope.contentType == 'audio') {
              /*  api.getAudioStudyItems().then(function (items) { //old api from restAngular
                    scope.items1 = items;
                });*/
                getAudioItems(scope.level, scope.theme).then(function (data) {
                    scope.items = data.data.objects
                })


            scope.selectFunction = function (selectLevel,selectTheme) {
                /* console.log("level "+ selectLevel);
                console.log("selectTheme "+ selectTheme); */
                
                scope.level = selectLevel.levelUrl;
                scope.theme = selectTheme.themeUrl;
                getAudioItems(scope.level, scope.theme).then(function (data) {
                    scope.items = data.data.objects
                })
            }



                document.title = "Chinese Audio Study Content - ChineseVault.com";

                var allMetaElements = document.getElementsByTagName('meta');
                
                for (var i = 0; i < allMetaElements.length; i++) { 
                    if (allMetaElements[i].getAttribute("name") == "description") { 
                        allMetaElements[i].setAttribute('content', "Learn Chinese with real audio study content. Improve your listening and reading skills by listening to real Chinese audio, with a complete transcript to help you learn."); 
                    } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                        allMetaElements[i].setAttribute('content', "chinese audio study content, learn chinese with audio, learn chinese free, chinese audio"); 
                    }
                }
            }


            else if (scope.contentType == 'video') {
                api.getVideoStudyItems().then(function (items) {
                    scope.items = items;
                });

                document.title = "Chinese Video Study Content - ChineseVault.com";

                var allMetaElements = document.getElementsByTagName('meta');
                
                for (var i = 0; i < allMetaElements.length; i++) { 
                    if (allMetaElements[i].getAttribute("name") == "description") { 
                        allMetaElements[i].setAttribute('content', "Learn Chinese with real video study content. Improve your listening and reading skills by watching real Chinese videos, with a complete transcript to help you learn."); 
                    } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                        allMetaElements[i].setAttribute('content', "chinese video study content, learn chinese with videos, learn chinese free, chinese videos"); 
                    }
                }
            }
            else {
                throw new Error('Item type is not declared in directive <subtitle-item-list>');
            }
            scope.go = function (state, params) {
               $state.go(state, params);
        };
        }
      };
    });
