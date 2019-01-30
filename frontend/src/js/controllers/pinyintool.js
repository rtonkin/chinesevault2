angular.module('putonghua').controller('PinyintoolController', ['$scope', '$http', '$state', 'Restangular', '$sce', 'api', function ($scope, $http, $state, Restangular, $sce, api) {
	$scope.pinyinCharsArr = [
                {char: "ā", code: "&#257;"},
                {char: "á", code: "&#225;"},
                {char: "ǎ", code: "&#462;"},
                {char: "à", code: "&#462;"},
                {char: "ē", code: "&#275;"},
                {char: "é", code: "&#233;"},
                {char: "ě", code: "&#283;"},
                {char: "è", code: "&#232;"},
                {char: "ī", code: "&#299;"},
                {char: "í", code: "&#237;"},
                {char: "ǐ", code: "&#464;"},
                {char: "ì", code: "&#236;"},
                {char: "ō", code: "&#333;"},
                {char: "ó", code: "&#243;"},
                {char: "ǒ", code: "&#466;"},
                {char: "ò", code: "&#242;"},
                {char: "ū", code: "&#363;"},
                {char: "ú", code: "&#250;"},
                {char: "ǔ", code: "&#468;"},
                {char: "ù", code: "&#249;"},
                {char: "ǘ", code: "&#472;"},
                {char: "ǚ", code: "&#474;"},
                {char: "ǜ", code: "&#476;"},
            ];
    $scope.pinyinText = '';
    $scope.twoChar = ["ā","á","ǎ", "à","ē","ě","ō","ó","ǒ","ò","ū","ú","ǔ","ù"];

    $scope.addPinyinChar = function(char) {
                    
                    var addPos = 1;
                    var el = document.getElementsByClassName("textarea-pinyin");
                    var position = doGetCaretPosition(el[0]);
                    
                    $scope.pinyinText = editValue($scope.pinyinText, position, char.char);
                    $scope.twoChar.forEach(function(ch){
                        if(char.char == ch){
                            addPos = 2;
                        }
                    })
                    
                    setTimeout(function(){
                        setCaretPosition(el[0], position + addPos);
                    },0);
            }

            editValue = function(value, position, char) {
                var startPosition = char ? position : position-2;
                return value.substring(0, startPosition) + char + value.substring(position);
            }

            setCaretPosition = function(el, caretPos){
                if (el !== null) {
                    if (el.createTextRange) {
                        var range = el.createTextRange();
                        range.move('character', caretPos);
                        range.select();
                        return true;
                    }
                    
                    else {
                        if (el.selectionStart || el.selectionStart === 0) {
                            el.focus();
                            el.setSelectionRange(caretPos, caretPos);
                        }
                    }
                }
            }
            $scope.removeChar = function(event) {
                var position = doGetCaretPosition(event.target);
                var equalChar = '';
                if(event.key === "Backspace"){
                    var isLastChar = $scope.pinyinText.substring(position - 2, position);
                    $scope.twoChar.forEach(function(char, i){
                        if(isLastChar == char){
                            equalChar = char;
                        }
                    })
                    if(equalChar){
                        event.preventDefault();
                        $scope.pinyinText = editValue($scope.pinyinText, position, '');
                        setTimeout(function(){
                            setCaretPosition(event.target, position-2);
                        },0);
                    }
                }
            }

            doGetCaretPosition = function (oField) {
              var iCaretPos = 0;
              // IE support
              if (document.selection) {
                oField.focus();
                var oSel = document.selection.createRange();
                oSel.moveStart('character', -oField.value.length);
                iCaretPos = oSel.text.length;
              }

              // Firefox support
              else if (oField.selectionStart || oField.selectionStart == '0')
                iCaretPos = oField.selectionStart;

              // Return results
              return iCaretPos;
            }

            $scope.copyPinyinText = function(){
            	var elCopied = document.getElementsByClassName("copied");
            	elCopied[0].className = "copied copied-visible";
            	setTimeout(function(){
            		elCopied[0].className = "copied";
            	}, 2000);
            }

	
}])