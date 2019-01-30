angular.module('putonghua')
    .factory('PhuaAudio', function (api, $rootScope) {
        var PhuaAudio = {};

        PhuaAudio.soundIsPlaying = false;
        PhuaAudio.playSound = function(dataType, dataId) {

            var resource, getVoice = null;
            resource = dataType;
            if (dataType == 'word') { getVoice = api.getWordVoice(dataId); }
            else if (dataType == 'sentence') { getVoice = api.getSentenceVoice(dataId); }
            getVoice.then(function (data) {
                var audio = new Audio(data.url);
                audio.play();
                audio.addEventListener('play', function(){ $rootScope.$broadcast(resource+'-audio.play', this); });
                audio.addEventListener('ended', function(){ $rootScope.$broadcast(resource+'-audio.ended', this); });
            });




        };

        PhuaAudio.playSoundd = function(dataType, dataId) {
            var resource, getVoice = null;
            resource = dataType;
            if (dataType == 'word') { getVoice = api.getWordVoice(dataId); }
            else if (dataType == 'sentence') { getVoice = api.getSentenceVoice(dataId); }
            getVoice.then(function (data) {
                var audio = new Audio(data.url);
                audio.play();
                audio.addEventListener('play', function(){ $rootScope.$broadcast(resource+'-audio.playy', this); });
                audio.addEventListener('ended', function(){ $rootScope.$broadcast(resource+'-audio.endedd', this); });
            });

        };

        return PhuaAudio;
    });
