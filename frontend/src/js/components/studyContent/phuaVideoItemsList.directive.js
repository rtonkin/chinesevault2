/**
 * Created by svfat on 5/29/16.
 */
angular.module('putonghua')
    .directive('phuaVideoItemsList', function(api) {
      return {
        restrict: 'E',
        scope: {},
        template:   '<div class="row">'+
                    '<div class="col-xs-12 content_item text-center">'+
                    '<span class="gray-text" ui-sref="study_content_video_list">Showing {{objects.length}} of {{allObjects.length}} videos. See All</span>'+
                    '</div>'+
                    '</div>'+
                    '<div class="row content_item" ng-repeat="obj in objects">' +
                    '<a ui-sref="study_content_video_item({id:obj.id})">'+
                    '<div class="col-xs-2">' +
                    '<i class="fa fa-video-camera fa-2x orange" aria-hidden="true"></i>' +
                    '</div>'+
                    '<div class="col-xs-10">'+
                    '<h5 ui-sref="study_content_video_item({id:obj.id})">' +
                    '{{obj.name}}'+
                    '</h5>' +
                    '<h5 class="gray-text">{{obj.level}}</h5>'+
                    '</div>' +
                    '</a>'+
                    '</div>',
        link: function (scope) {
            scope.objects = [];
            api.getVideoStudyItems().then(function (objects) {
                scope.allObjects = objects;
                scope.objects = objects.slice(0,7);
                scope.objects.forEach(function(el) {
                    if(el.study_level == 10) {
                        el.level = 'Beginner'
                    } else if(el.study_level == 20) {
                        el.level = 'Intermediate'
                    } else if (el.study_level == 30) {
                        el.level = 'Advanced'
                    }
                })
            });
        }
      };
    });