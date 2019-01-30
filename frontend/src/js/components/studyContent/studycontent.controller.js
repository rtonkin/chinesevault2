angular.module('putonghua')
    .controller(
        'StudyContentListController',
        function ($scope, api, $state) {
            document.title = "Chinese Study Content - ChineseVault.com";

            var allMetaElements = document.getElementsByTagName('meta');
            
            for (var i = 0; i < allMetaElements.length; i++) { 
                if (allMetaElements[i].getAttribute("name") == "description") { 
                    allMetaElements[i].setAttribute('content', "Learn Chinese with real study content. Find Text, Audio and Video for listening and reading practice and teach yourself with our advanced"); 
                } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                    allMetaElements[i].setAttribute('content', "chinese study content, learn chinese, chinese videos, chinese audio, chinese text, learn to read chinese"); 
                }
            }

            if ($state.current.name == 'study_content_text_list') {
                document.title = "Chinese Text Study Content - ChineseVault.com";

                var allMetaElements = document.getElementsByTagName('meta');
                
                for (var i = 0; i < allMetaElements.length; i++) { 
                    if (allMetaElements[i].getAttribute("name") == "description") { 
                        allMetaElements[i].setAttribute('content', "Learn Chinese with real text study content. Improve your reading skills by reading real Chinese stories, news, songs and poems, with a complete transcript to help you learn."); 
                    } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                        allMetaElements[i].setAttribute('content', "chinese text study content, learn chinese by reading, learn chinese free, chinese text, chinese poems, chinese news, chinese songs"); 
                    }
                }
            }

            $scope.content = {
                'articles':[],
                'poems':[],
                'songs':[]
            };
            $scope.studyContentText = function(){
                $state.go('study_content_text_list');
            }
            $scope.studyContentAudio = function(){
                $state.go('study_content_audio_list');
            }

            api.getStudyContents().then(function (contents) {
                contents.forEach(function(item, i, contents) {
                    switch (item.content_type) {
                        /*
                            ARTICLE_CONTENT_TYPE = 1
                            POEM_CONTENT_TYPE = 2
                            SONG_CONTENT_TYPE = 3
                        */
                        case 1:
                            $scope.content.articles.push({
                                'number':item.number,
                                'chineseName':item.chinese_name,
                                'englishName':item.english_name,
                                'study_level':item.study_level
                            });
                            break;
                        case 2:
                            $scope.content.poems.push({
                                'number':item.number,
                                'chineseName':item.chinese_name,
                                'englishName':item.english_name,
                                'chineseAuthor':item.chinese_artist,
                                'englishAuthor':item.english_artist,
                                'study_level':item.study_level
                            });
                            break;
                        case 3:
                            $scope.content.songs.push({
                                'number':item.number,
                                'chineseName':item.chinese_name,
                                'englishName':item.english_name,
                                'chineseArtist':item.chinese_artist,
                                'englishArtist':item.english_artist,
                                'study_level':item.study_level
                            });
                            break;
                    }
                    });
            });
        }
        )
    .controller(
        'StudyContentDetailController',
        function ($scope, api, $stateParams, WordList, searchcacheService) {
            $scope.item = {
                           'number':$stateParams.id,
                           'header':'',
                           'text':''
                          };
            
            api.getStudyContent($scope.item.number).then(function (content) {

                document.title = content.english_name + " - Chinese Text Content - ChineseVault.com";

                var allMetaElements = document.getElementsByTagName('meta');
                
                for (var i = 0; i < allMetaElements.length; i++) { 
                    if (allMetaElements[i].getAttribute("name") == "description") { 
                        allMetaElements[i].setAttribute('content', content.description); 
                    } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                        allMetaElements[i].setAttribute('content', "chinese text study content, learn chinese by reading, learn chinese free, chinese text, chinese poems, chinese news, chinese songs"); 
                    }
                }
                // we have some chinese text now, and we want to add some angular bindings
                // to work with it
                var convertToAngular = function (html) {
                    var template_1 = '<span class=\"texttool-span-no-space chinese-hoverable\" ng-click=\"selectWord($event)\">';
                    var template_2 = '</span>';
                    return html.replace(/<chinese>/g, template_1).replace(/<\/chinese>/g, template_2); };

                $scope.item.text = convertToAngular(content.text);
                $scope.item.header = (content.chinese_name+' - '+content.chinese_artist+' - ('+content.english_name+' - '+content.english_artist+')');
                $scope.item.sourceUrl = content.source_url;
                }).catch(function () {
                        $state.go('study_content');
                    });
            $scope.selectWord = function selectWord(event) {

                $($scope.oldTarget).removeClass('texttool-hgltd');
                $scope.oldTarget = event.target;
                $(event.target).addClass('texttool-hgltd');
                var promise = searchcacheService.getData(event.target.innerText);
                  promise.then(function(result) {  // this is only run after $http completes
                       if (result) {
                                $scope.globals.SelectedWord = result;
                            }
                    });
            };
            $scope.setPageId= function(content){
                localStorage.setItem('s_page_id', content);                
            }
            $scope.openAddToListDialog = WordList.openAddToListDialog;

            });

