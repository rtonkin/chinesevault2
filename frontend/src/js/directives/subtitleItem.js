angular.module('putonghua')
    .directive('subtitleItem', ['$q', '$sce', 'api', '$rootScope', 'PhuaAudio', function($q, $sce, api, $rootScope, PhuaAudio, $attrs) {
      return {
        restrict: 'E',
        templateUrl: '/static/templates/studyContent/subtitleItem.html',
        transclude: true,
        scope: {
          id: "=id",
          contentType: "=contentType"
        },
        link: function(scope) {
            // add from texttool
              scope.controlLanguage = 'chinese';
              scope.changeType = function(type){
                scope.controlLanguage = type;
                 scope.finWordById(scope.controlLanguage, scope.currentTextId)
              };
              scope.finWordById = function (controlLanguage, currentTextId) {
                  var   srtContainer = {},
                        box_height = 0;
                   switch(controlLanguage) {
                       case 'chinese':
                           srtContainer = angular.element('.srt_container_chinese');
                           box_height = srtContainer.height();
                           break;
                       case 'pinyin':
                           srtContainer = angular.element('.srt_container_pinyin');
                           box_height = srtContainer.height();
                           break;
                       case 'pin1yin1':
                           srtContainer = angular.element('.srt_container_pin1yin1');
                           box_height = srtContainer.height();
                           break;
                   }
                   setTimeout(function () {
                      var elem  = srtContainer.find('#'+currentTextId);
                      var row = elem.parent().parent();
                      var positionScroll = srtContainer.height();
                      var topElement = elem.position().top;
                      var heightElement = elem.height();
                      if (row.length > 0 && positionScroll < ( topElement + heightElement )){
                          var scrollTo = topElement + heightElement / 2 - positionScroll / 2;
                          srtContainer.animate({scrollTop: scrollTo }, 200  );
                      }
                   },0);
              };


              var videogularAPI = null;

              scope.onPlayerReady = function(API) {
                videogularAPI = API;
                videogularAPI.setVolume(1);
              };

            scope.playSound = PhuaAudio.playSound;

            scope.soundIsPlaying = false;

            scope.$on('word-audio.play', function (event, data) {
                scope.soundIsPlaying = true;
                scope.$apply();
            });
            scope.$on('word-audio.ended', function (event, data) {
                scope.soundIsPlaying = false;
                scope.$apply();
            });

              var cnvTime = function(s) {
                /*
                  Convert given time from '00:00:00,000' format to milliseconds
                */
                var tmp1 = s.split(",");
                var ms = parseInt(tmp1[1]);
                var tmp2 = tmp1[0].split(':');
                var hours = parseInt(tmp2[0]);
                var minutes = parseInt(tmp2[1]);
                var seconds = parseInt(tmp2[2]);
                var result = ms + seconds*1000 + minutes*60*1000 + hours*60*60*1000;
                return result;
              };


              scope.onUpdateTime = function(currentTime, totalTime) {
                  scope.currentTime = currentTime;
                  scope.totalTime = totalTime;
                  var arr = scope.item.srt;
                  var t = currentTime*1000;
                  for (var i = 0; i < arr.length; i++) {
                    var row = arr[i];
                    for (var j=0; j < row.length; j++) {
                      if (t >= cnvTime(row[j].startTime) && t <= cnvTime(row[j].endTime)) {
                         scope.currentText = row[j].text;
                         scope.currentTextId = row[j].id;
                      }
                    }
                   }

              };

              scope.playWord = function(word) {
                  api.searchChineseWord(word).then(function(word) {
                      scope.playSound('word', word.id);
                  });
              };

              scope.selectedWord = null;

              scope.searchWord = function(query) {
                api.searchChineseWord(query).then(function(word) {
                  $rootScope.globals.SelectedWord = word;
                  scope.selectedWord = word;
                });
              };

              scope.currentText = "None";
              scope.currentTextId = null;

              scope.$watch('currentTextId', function(newValue, oldValue) {
                scope.$broadcast('srt-update', newValue);
              });

              scope.item = {
                name: "",
                filename: "",
                srt: {}
              };
              scope.mediaconfig = {
                sources: [
                ],
                theme: {
                  url: "/static/css/videogular.css"
                },
                playbackSpeeds: ['0.7', '0.8',  '0.9', '1', '1.1', '1.2', '1.3']
              };

              var subtitled;
              var t = scope.contentType;
              if (scope.contentType == 'audio') {
                subtitled = api.getAudioStudyItem(scope.id);
              }
              else if (scope.contentType == 'video') {
                subtitled = api.getVideoStudyItem(scope.id);
              }
              subtitled.then(function (item) {
                scope.item.name = item.name;

                scope.item.keywords = [];
                if(item.keywords) {
                  var chinese = item.keywords.split('・');
                }
                var meaning = item.keywords_pinyin.split('・');
                var description = item.keywords_description.split('・');
                var arr_description = [];
                angular.forEach(description, function(desc,index){
                arr_description[index] = desc.split(',');
                });
                if(chinese) {
                  angular.forEach(chinese, function(keyword, index){
                    if(keyword !== "") {
                      scope.item.keywords.push({keyword:keyword, meaning:meaning[index], description:arr_description[index]});
                    }
                  });
                }

                if (scope.contentType == 'audio') {
                  document.title = scope.item.name + " - Chinese Audio Content – ChineseVault.com";

                  var allMetaElements = document.getElementsByTagName('meta');

                  for (var i = 0; i < allMetaElements.length; i++) {
                      if (allMetaElements[i].getAttribute("name") == "description") {
                          allMetaElements[i].setAttribute('content', item.description);
                      } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                          allMetaElements[i].setAttribute('content', "chinese audio study content, learn chinese with audio, learn chinese free, chinese audio");
                      }
                  }
                }
                else if (scope.contentType == 'video') {
                  document.title = scope.item.name + " - Chinese Video Content – ChineseVault.com";

                  var allMetaElements = document.getElementsByTagName('meta');

                  for (var i = 0; i < allMetaElements.length; i++) {
                      if (allMetaElements[i].getAttribute("name") == "description") {
                          allMetaElements[i].setAttribute('content', item.description);
                      } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                          allMetaElements[i].setAttribute('content', "chinese video study content, learn chinese with videos, learn chinese free, chinese videos");
                      }
                  }
                }


                var fn = item.filename;
                var extension = item.filename.substr(item.filename.length - 3);
                var mediaType = null;
                if (extension == 'mp3') {
                  scope.item.type = 'audio';
                  mediaType = 'audio/mpeg';
                }
                else if (extension == 'mp4') {
                  scope.item.type = 'video';
                  mediaType = 'video/mp4';
                }
                else {
                  throw new Error("Media type error!");
                }
                var sources = [{
                                src: $sce.trustAsResourceUrl(fn), type: mediaType
                            }];
                var that = this;
                var data = parser.fromSrt(item.srt, false);
                var pinyin_data = parser.fromSrt(item.srt_pinyin, false);
                var pinyin_data_number = parser.fromSrt(item.srt_pinyin_number, false);
                scope.item.srt = [];
                var convertedWords = [];
                var promise_array = [];

                function callbackCreator(id, startTime, endTime) {
                  return function(result) {
                    var words = result.words;
                    var resultArr = [];
                    convertedWords.push({text:words, id:parseInt(id), startTime:startTime, endTime:endTime})
                  };
                }
                for (var i = 0; i < data.length; i++) {
                  var callback = callbackCreator(data[i].id, data[i].startTime, data[i].endTime);
                  promise_array.push(api.textToolSplitChinese(data[i].text).then(callback));
                }

                function rowCharsLength(row) {
                  // total count of characters in row
                  var result = 0;
                  for (var i = 0; i < row.length; i++) {
                    result = result + row[i].text.length;
                  }
                  return result;
                }


                $q.all(promise_array)
                  .then(
                      function() {
                          // after fetching all data from API, convert in to rows ~30 chars length
                          var row = [],
                              tmp = [];

                          // sort
                          convertedWords.sort(function(a, b){
                              var keyA = a.id,
                                  keyB = b.id;
                              if(keyA < keyB) return -1;
                              if(keyA > keyB) return 1;
                              return 0;
                          });
                          // make flat
                          for (var i = 0; i < convertedWords.length; i++) {
                            var r = convertedWords[i];
                            for (var j = 0; j < r.text.length; j++) {
                                tmp.push({text:r.text[j], id:parseInt(r.id), startTime:r.startTime, endTime:r.endTime});
                            }
                          }
                          // get flat pinyin
                          var pinyinData = [];
                          for (var i = 0; i < pinyin_data.length; i++) {
                            var pd = pinyin_data[i].text.split(' ');
                            for (var j = 0; j < pd.length; j++) {
                              pinyinData.push(pd[j]);
                            }
                          }
                          // get flat pin1yin1
                          var pin1yin1 = [];
                          for (var i = 0; i < pinyin_data_number.length; i++) {
                            var pn = pinyin_data_number[i].text.split(' ');
                            for (var j = 0; j < pn.length; j++) {
                              pin1yin1.push(pn[j]);
                            }
                          }
                          // add pinyin and pin1yin1 to the object
                          for (var i = 0; i < pinyinData.length; i++) {
                              if(tmp[i]){
                                  tmp[i].pinyin_text = pinyinData[i];
                              }
                              if(tmp[i]){
                                  tmp[i].pinyin_num = pin1yin1[i];
                              }
                          }

                          convertedWords = tmp;
                          angular.forEach(convertedWords, function(word, index){
                            if(convertedWords[index].text !== '・' && convertedWords[index].text !== '\n'){
                              row.push(convertedWords[index]);
                            }else if(convertedWords[index].text === '・'){
                              scope.item.srt.push(row);
                              row = [];
                            }
                          });
                          scope.item.srt.push(row);
                      }
                  );
                scope.mediaconfig.sources = sources;
              });
            }
      };
    }]);
angular.module('putonghua')
.directive('scrollOnUpdate', function() {
  function link(scope, element, attrs) {


      scope.$on('srt-update', function (event, mass) {

          var row = element.parent().parent(),
              srtContainer = {},
              box_height = 0;
          switch (attrs.container) {
              case 'chinese':
                  srtContainer = angular.element('.srt_container_chinese');
                  box_height = srtContainer.height();
                  break;
              case 'pinyin':
                  srtContainer = angular.element('.srt_container_pinyin');
                  box_height = srtContainer.height();
                  break;
              case 'pin1yin1':
                  srtContainer = angular.element('.srt_container_pin1yin1');
                  box_height = srtContainer.height();
                  break;
          }
          var topElement = element.position().top;
          var heightElement = element.height();
          var positionScroll = srtContainer.height();
          if (scope.wordId == mass && positionScroll < ( topElement + heightElement )) {
              var scrollTo = topElement + heightElement / 2 - positionScroll / 2;
              srtContainer.animate({scrollTop: scrollTo }, 200  );
          }
      });
  }

  return {
    scope: {
      wordId: '=scrollOnUpdate'
    },
    link: link
  };
});
