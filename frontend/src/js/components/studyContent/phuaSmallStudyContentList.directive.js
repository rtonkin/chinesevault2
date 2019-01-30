/**
 * Created by svfat on 5/29/16.
 */
angular.module('putonghua')
    .directive('phuaSmallStudyContentList', function (api, $timeout) {
        return {
            restrict: 'E',
            template:   '<ul class="studycontent">'+
                            '<li ng-repeat="object in titles ">' +
                                '<span ng-if="object.type == \'text\'"><i class="fa fa-file-text-o content-list-icon" aria-hidden="true"></i></span>' +
                                '<span ng-if="object.type == \'audio\'"><i class="fa fa-volume-up content-list-icon" aria-hidden="true"></i></span>' +
                            /* '<span ng-if="object.type == \'video\'"><i class="fa fa-video-camera content-list-icon" aria-hidden="true"></i></span>' +*/
                                '<a ng-if="object.type == \'text\'" ui-sref="study_content_text_item({id:object.id})" >' +
                                    '{$ object.name $}' +
                                '</a>' +
                                '<a ng-if="object.type == \'audio\'" ui-sref="study_content_audio_item({id:object.id})" ng-click="setPageId(object.id)">' +
                                    '{$ object.name $}' +
                                '</a>' +
                                /*'<a ng-if="object.type == \'video\'" ui-sref="study_content_video_item({id:object.id})">' +
                                    '{$ object.name $}' +*/
                                '</a>' + 
                                '<span class="capitalize" ng-if="object.type == \'text\'">{$ object.type $}</span>' +
                                '<span class="capitalize" ng-if="object.type == \'audio\'">{$ object.type $}</span>' +
                            '</li>' +
                        '</ul>'+
                        '<a ui-sref="study_content_list" class="more">More content...</a>',
            link: function (scope, element) {

                scope.titles = [];
                api.getRandomTitles().then(function (data) {
                    
                    scope.titles = data;
                    setTimeout(removeElement,0);

                    function removeElement() {
                        var height = angular.element('.studycontent .panel-body').height();
                        var panelBody_height = angular.element('.resources .panel-body').height();
                        if (height > panelBody_height) {
                            scope.titles.splice(scope.titles - 1, 1);
                            scope.$apply();
                            setTimeout(removeElement,0);
                        }else{
                            return null;
                        }

                    }
                });
            }
        };
    });