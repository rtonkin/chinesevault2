angular.module('putonghua')
    .filter('hilite', function () {
        return function (str, query) {
            query = query.replace(/\*+/g, '');

            return str.replace(
                new RegExp(query, 'gi'),
                '<span class="highlighted-match">$&</span>'
            );
        };
    })

    .filter('asChinese', function () {
        return function (str, form) {
            form =
                form !== undefined && form !== null ? form.toString().trim().toLowerCase() : ''
            ;

            switch (form) {
                case 's':
                case 'simplified':
                case 'hans':
                    form = 'zh-Hans';
                    break;
                case 't':
                case 'traditional':
                case 'hant':
                    form = 'zh-Hant';
                    break;
                default:
                    form = 'zh';
                    break;
            }
            if (str !== undefined) {
                return str.replace(
                    /([\u2E80-\u9FFF]+)/g,
                    '<span class="lang-*" lang="*">$&</span>'
                        .replace(/\*/g, form)
                );
            }
        };
    })

    .filter('asHtml', function ($sce) {
        return function (str) {
            return $sce.trustAsHtml(str);
        };
    })

    .filter('default', function () {
        return function (input, defaultValue) {
            if (!input) return defaultValue;

            return input;
        };
    })

    .filter('isAdded', function () {
        return function (word) {
            return word.categories.indexOf('Default') !== -1;
        };
    })

    .filter('startFrom', function () {
        return function (input, start) {
            start = +start; //parse to int
            return input.slice(start);
        };
    })

    .filter('nl2br', function ($sce) {
        return function (text) {
            text = text.replace(/\n/g, '<br />');
            return $sce.trustAsHtml(text);
        };
    })

    .filter('unToned', function () {
        return function (text) {
            return text.replace(/\d/g, '');
        };
    })

    .filter('truncUrl', function () {
        return function (text) {
            return text.replace(/"#/g, '"/app');
        };
    })
    .filter('split', function() {
        return function(input, splitChar, splitIndex) {
            // do some bounds checking here to ensure it has that index
            return input.split(splitChar)[splitIndex];
        }
    })
    
    .filter('cnvStudyLevel', function () {
        return function (value) {
            switch (value) {
                case 10:
                    return 'Beginner';
                    break;
                case 20:
                    return 'Intermediate';
                    break;
                case 30:
                    return 'Advanced';
                    break;
                default:
                    return 'Error'
            }
        };
    });

