angular.module('putonghua')
    .filter('showFilter', function () {
        return function (items, value) {
            var temp = [];
            var out = [];
            var show = value.show;
            var sortby = value.sortby;
            switch (sortby) {
                case '0':
                    temp = items;
                    break;
                case '1':
                    var grouped = [];
                    items.forEach(function(item, i, items) {
                        if (grouped.indexOf(item.id) == -1) {
                            grouped.push(item.id);
                            temp.push(item);
                        }
                    });
                    break;
                case '2':
                    grouped = [];
                    items.forEach(function(item, i, items) {
                        if (grouped.indexOf(item.id) == -1) {
                            grouped.push(item.id);
                            temp.push(item);
                        }
                    });
                    temp.sort(function (a,b) {
                      if (a.occurence < b.occurence)
                        return 1;
                      if (a.occurence > b.occurence)
                        return -1;
                      return 0;
                    });
                    break;
            }
            switch (show) {
                case '0':
                    out = temp;
                    break;
                case '1':
                    temp.forEach(function(item, i, temp) {
                        if (!item.added) {
                            out.push(item);
                        }
                    });
                    break;
                case '2':
                    temp.forEach(function(item, i, temp) {
                        if (item.added) {
                            out.push(item);
                        }
                    });
                    break;
            }
            return out;
        };
    });
