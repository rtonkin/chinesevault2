/**
 * Created by Neha on 12/4/17.
 */
angular.module('putonghua')
    .directive('phuaAudioItemsList', function(api) {
      return {
        restrict: 'E',
        scope: {},
        template:   '<div class="row">'+
                        '<div class="col-xs-12 content_item text-center">'+
                            '<h4>Top Audio</h4>' +
                            '<!--<span class="gray-text" ui-sref="study_content_audio_list">Showing {{objects.length}} of {{allObjects.length}} audio. See All</span>-->'+
                        '</div>'+
                    '</div>'+
                    '<div class="brd-right pr15px">' +
                        '<md-list-item class="md-3-line mtb10px" layout-align="center" layout="row" ng-repeat="obj in objects" >' +
                            '<div class="md-list-item-text text-center" flex="20">' +
                                '<md-icon aria-hidden="true" class="fa fa-volume-up fa-2x"> </md-icon>' +
                            '</div>'+
                            '<div class="md-list-item-text" flex="80" ui-sref="study_content_audio_item({id:obj.id})" ng-click="setPageId(obj.id)">'+
                                '<h3 ui-sref="study_content_audio_item({id:obj.id})">' +
                                    '{{obj.name}}'+
                                '</h3>' +
                                '<span class="level">{{obj.level}}</span>' +
                            '</div>' +
                        '</md-list-item>' +
                    '</div>',
        link: function (scope) {
            scope.objects = [];

            api.getAudioStudyItems().then(function (objects) {
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