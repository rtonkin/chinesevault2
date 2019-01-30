/**
 * Created by svfat on 4/5/16.
 */
// A dummy controller for static pages
angular.module('putonghua').controller('StaticController', ['$scope', '$http', '$state', 'Restangular', '$sce', 'api', function ($scope, $http, $state, Restangular, $sce, api) {

	$scope.dynamicPopover = {
        content: 'Hello, World!',
        templateUrl: 'myPopoverTemplate.html',
        title: 'Title'
    };

    api.getChineseNames().then(function(data){
       $scope.chineseNames = data;
    });


    $scope.getNames = function(letter) {
        $scope.activeLetter = letter;
    }
    
    $scope.activeLetter = "A";
    $scope.alphabet = "abcdefghijklmnopqrstuvwxyz".toUpperCase().split("");

    $scope.tones = [];
    $scope.callingAudio = function(tone) {
        
        $(".popover").not(":last-child").remove();
        
        Restangular.all('tones').post({tone: tone}).then(function(response) {  
            $scope.tones = response.tones;
        });
    }
    $scope.playSound = function (tone) {
        // console.log('nihao1')
        // var audio = new Audio(tone);
        // console.log('nihao2')
        // audio.play();
        document.getElementsByTagName('audio')[tone].play();
    }

	if ($state.current.name == 'resources_pinyin_chart') {
		document.title = "Free Pinyin Chart with Audio – ChineseVault.com";

        var allMetaElements = document.getElementsByTagName('meta');
        
        for (var i = 0; i < allMetaElements.length; i++) { 
            if (allMetaElements[i].getAttribute("name") == "description") { 
                allMetaElements[i].setAttribute('content', "Free Chinese Pinyin chart containing all 1,300+ pinyin sounds, with audio for every sound. Practice your pronunciation today."); 
            } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                allMetaElements[i].setAttribute('content', "free pinyin chart, chinese pinyin chart, pinyin audio, pinyin chart with audio, pinyin explanation"); 
            }
        }
	} else if ($state.current.name == 'resources_char_freq') {
		document.title = "Simplified Chinese Character Frequency List – ChineseVault.com";

        var allMetaElements = document.getElementsByTagName('meta');
        
        for (var i = 0; i < allMetaElements.length; i++) { 
            if (allMetaElements[i].getAttribute("name") == "description") { 
                allMetaElements[i].setAttribute('content', "Chart containing the most common 5,000 characters sorted by frequency. Test your character knowledge and find new characters to learn."); 
            } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                allMetaElements[i].setAttribute('content', "chinese character frequency, chinese character frequency chart"); 
            }
        }
	} else if ($state.current.name == 'resources_word_freq') {
		document.title = "Chinese Word Frequency List – ChineseVault.com";

        var allMetaElements = document.getElementsByTagName('meta');
        
        for (var i = 0; i < allMetaElements.length; i++) { 
            if (allMetaElements[i].getAttribute("name") == "description") { 
                allMetaElements[i].setAttribute('content', "Chart containing the most common 20,000 Chinese words sorted by frequency. Test your word knowledge and find new words to learn."); 
            } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                allMetaElements[i].setAttribute('content', "chinese word frequency, chinese word frequency chart"); 
            }
        }
	} else if ($state.current.name == 'resources_word_chart') {
		document.title = "Chinese Measure Word List – ChineseVault.com";

        var allMetaElements = document.getElementsByTagName('meta');
        
        for (var i = 0; i < allMetaElements.length; i++) { 
            if (allMetaElements[i].getAttribute("name") == "description") { 
                allMetaElements[i].setAttribute('content', "List containing hundreds of Chinese Measure words sorted from beginner to expert. Brush up on your measure words today."); 
            } else if (allMetaElements[i].getAttribute("name") == "keywords") {
                allMetaElements[i].setAttribute('content', "chinese measure words, chinese measure word chart, chinese counter words, chinese counter words chart"); 
            }
        }names
	}else if ($state.current.name == 'about') {
        document.title = "About Us – ChineseVault.com";
    }else if ($state.current.name == 'terms-of-use') {
        document.title = "Terms Of Use – ChineseVault.com";
    }else if ($state.current.name == 'privacy-policy') {
        document.title = "Privacy Policy – ChineseVault.com";
    }else if ($state.current.name == 'contact') {
        document.title = "Contact Us – ChineseVault.com";
    }else if ($state.current.name == 'names') {
        document.title = "Chinese Names – ChineseVault.com";
    }else if ($state.current.name == 'pinyintool') {
        document.title = "Pinyin Keyboard – ChineseVault.com";
    }  
}])
.filter('firstLetter', function () {
    return function (input, letter) {
        input = input || [];
        var out = [];
        input.forEach(function (item) {
            if(item.english.charAt(0) === letter) {
                out.push(item);
            }
        });
        return out;
    }
});