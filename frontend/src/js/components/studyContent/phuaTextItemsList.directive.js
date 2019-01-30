/**
 * Created by svfat on 5/29/16.
 */
angular.module('putonghua')
    .directive('phuaTextItemsList', function(api) {
      return {
        restrict: 'E',
        scope: {},
        template:   '<div class="row">'+
                        '<div class="col-xs-12 content_item text-center">'+
                            '<h4>Top Text</h4>' +
                            '<!--<span class="gray-text" ui-sref="study_content_text_list">Showing {{objects.length}} of {{allObjects.length}} texts. See All</span>-->'+
                        '</div>'+
                    '</div>'+
                    '<div class="">'+
                        '<md-list-item class="md-3-line mtb10px" layout-align="center" layout="row" ng-repeat="obj in objects">' +
                            '<div class="md-list-item-text text-center" flex="20">' +
                                '<md-icon aria-hidden="true" class="fa fa-file-text-o fa-2x"></md-icon>' +
                            '</div>'+
                            '<div class="md-list-item-text" flex="80" ui-sref="study_content_text_item({id:obj.id})">'+
                                '<h3 ui-sref="study_content_text_item({id:obj.id})">' +
                                    '{{obj.english_name}}'+
                                '</h3>' +
                                '<span class="level">{{obj.level}}</span>' +
                            '</div>' +
                        '</md-list-item>'+
                    '</div>',
        link: function (scope) {
            scope.objects = [];
            api.getStudyContents().then(function (objects) {
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