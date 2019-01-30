angular.module('putonghua')
    .directive('animateChinese', function() {
      return {
        restrict: 'E',
        template:     '',
        link: function($scope, element, attrs) {
          var count=0,
              t;
          var WIDTH = 80;
          var HEIGHT = 80;
          $scope.wordList = [];
          $scope.$watch('word', function(value) {
            if ($scope.word.simplified) {
              var char = $scope.word.simplified.split('');

              angular.forEach(char, function (val, key) {
                  $scope.wordList[key] = {};
                  $scope.wordList[key].word = val;

                   CdlUtils.getSvgPathStrings($scope.wordList[key].word, {
                    width: WIDTH,
                    height: HEIGHT,
                    apiKey: 'y5PiH9p4jUJfzfHrBUXGP5f1'
                  }).then(function(pathStrings) {
                      $scope.wordList[key].svg = pathStrings;
                        count++;
                       if (count === char.length){
                           var list = $scope.wordList[0];
                           $scope.wordList[0] = $scope.wordList[1];
                           $scope.wordList[1] = list;
                            $scope.wordList = listFilter($scope.wordList, char);
                            showPinyin($scope.wordList, char);
                       }
                  });
              });
              function listFilter(wordList, char) {
                    var obj = {};
                    wordList.forEach(function(el) {
                      if(el){
                        obj[el.word] = el;
                      }
                    });
                    wordList = char.map(function(word) {
                        return obj[word];
                    });
                    return wordList;
              }
              function showPinyin(wordList, char) {
                    angular.forEach(wordList, function (list, key) {
                      var row = angular.element("<div>"),
                          animatedDiv = angular.element("<div>"),
                          animatedChar = angular.element("<div>"),
                          fanningDiv = angular.element("<div>"),
                          fanningChar = angular.element("<div>");
                          strokes = angular.element("<p>"),
                      row.addClass('char-info');
                      animatedDiv.addClass('circle-char');
                      animatedChar.addClass('animated-char');
                      fanningDiv.addClass('stroke-detail');
                      fanningChar.addClass('fanning-char');

                      animatedDiv.append(animatedChar);                      
                      fanningDiv.append(fanningChar);
                      row.append(fanningDiv);
                      row.append(animatedDiv);
                      row.append(strokes);
                      row.append(fanningDiv);

                      strokes.text(list.svg.length + " Strokes");

                      var svgWidth = list.svg.length * WIDTH;
                      element.append(row);

                      $scope.drawFannedChar(fanningChar[0], list.svg);

                      CdlUtils.Animator.animateCharacter(animatedChar[0], list.word, {
                            width: 68, // px
                            height: 68, // px
                            apiKey: 'y5PiH9p4jUJfzfHrBUXGP5f1',
                            loopAnimation: true,
                            animateStyles: {
                                start: {
                                    fill: '#a1cbf5'
                                },
                                end: {
                                    fill: '#5092d5'
                                }
                            }
                        });
                    });
              }
              $scope.drawFannedChar = function(targetId, pathStrings) {
                  var svgWidth = pathStrings.length * WIDTH;
                  var svg = SVG(targetId).size(svgWidth, 80);

                  var pathStringsUpToNow = [];
                  pathStrings.forEach(function (pathString, i) {
                      pathStringsUpToNow.push(pathString);
                      var group = svg.group();
                      group.rect(WIDTH, HEIGHT).fill('none').stroke('#00aff0');
                      pathStringsUpToNow.forEach(function (currentPathString) {
                          group.path(currentPathString).fill('#5d5d5d');
                      });
                      group.translate(i * WIDTH, 0);
                  });
              };
            }
          });

          $scope.$watch('isOpenCharInfo', function(value){
            if(value && t) {
              // console.log(element.word);
            }
          });
        }
      };
    });