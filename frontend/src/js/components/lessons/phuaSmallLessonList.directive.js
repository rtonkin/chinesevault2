/**
 * Created by svfat on 5/29/16.
 */
angular.module('putonghua')
    .directive('phuaSmallLessonList', function (api) {
        return {
            restrict:   'E',
            template:   '<div layout="row" layout-xs="column" layout-sm="column">'+
                            '<div flex="40" flex-xs="100" flex-sm="100">'+
                                '<div class="tab-cont-block">'+
                                    '<h3 class="md-display-2">Latest</h3>' +
                                    '<ul>'+
                                        '<li ng-repeat="lesson in latestLessons">' +
                                            '<a ui-sref="lesson_detail({lessonNumber: lesson.number})">' +
                                                '<span>Lesson {$ lesson.number $}: {$ lesson.name $}</span>' +
                                            '</a>' +
                                            '<span class="fr">{$ lesson.new_words.length $}&nbsp;Words</span>' +
                                        '</li>' +
                                    '<ul>'+
                                '</div>'+
                            '</div>'+
                            '<div flex="40" flex-xs="100" flex-sm="100">'+
                                '<div class="tab-cont-block">'+
                                    '<h3 class="md-display-2">Popular</h3>' +
                                    '<ul class="popular">'+
                                        '<li ng-repeat="lesson in popularLessons">' +
                                            '<a ui-sref="lesson_detail({lessonNumber: lesson.number})">' +
                                            'Lesson {$ lesson.number $}: {$ lesson.name $}' +
                                            '</a>' +
                                            '<span>{$ lesson.new_words.length $}&nbsp;Words</span>' +
                                        '</li>' +
                                    '</ul>'+
                                '</div>'+
                            '</div>'+
                            '<div flex="30" flex-xs="100" flex-sm="100">'+
                                '<div class="tab-cont-block no-br">'+
                                    '<md-button class="next-btn" ui-sref="lesson" aria-label="see all lessons">'+
                                        '<span>See all <strong>Lessons</strong></span>'+
                                        '<md-icon class="fa fa-arrow-circle-o-right fa-3x"></md-icon>'+
                                    '</md-button>'+
                                '</div>'+
                            '<div>'+
                        '</div>',
            link: function (scope) {
                scope.latestLessons = [];
                scope.popularLessons = [];
                api.getLessons().then(function (lessons) {
                    scope.latestLessons = lessons.reverse().slice(0, 3);
                });
                api.getPopularLessons().then(function (lessons) {
                    scope.popularLessons = lessons.objects.slice(0, 3);
                });
            }
        };
    });