require('es6-promise').polyfill();
var gulp = require('gulp');
var inject = require('gulp-inject');
var replace = require('gulp-replace');
var angularFilesort = require('gulp-angular-filesort')
var jshint = require('gulp-jshint');
var notify = require("gulp-notify");
var useref = require('gulp-useref');
var gulpif = require('gulp-if');
var uglify = require('gulp-uglify');
var nano = require('gulp-cssnano');
var ngAnnotate = require('gulp-ng-annotate');
var gcopy = require('gulp-copy')
var watch = require('gulp-watch');
var clean = require('gulp-clean')
var sourcemaps = require('gulp-sourcemaps');
var sloc = require('gulp-sloc');
var del = require('del');
var gulpUtil = require('gulp-util');

var rand = function() {
    return Math.random().toString(36).substr(2); // remove `0.`
};

var token = function() {
    return rand() + rand(); // to make it longer
};

var not = function(s) {
  return "!"+s
}

var config = {
  distDir: "./frontend/dist/",
  tmpDir: "./frontend/tmp/",
  srcDir: "./frontend/src/"
}

gulp.task('clean', function(cb) {
  return del([config.distDir, config.tmpDir], cb);
});

gulp.task('inject', function () {
  var target = gulp.src('./frontend/src/base.html');
  var sourcesJs = gulp.src([config.srcDir+'js/**/*.js'])
                .pipe(angularFilesort())
  var sourcesCss = gulp.src([config.srcDir+'css/**/*.css', not(config.srcDir+'css/videogular.css')], {read: false})
  return target.pipe(inject(sourcesJs))
  .pipe(inject(sourcesCss))
  .pipe(gulp.dest(config.tmpDir))
});

gulp.task('compress', ['inject'], function() {
    return gulp.src([config.tmpDir+'base.html'])
        .pipe(useref({
            transformPath: function(filePath) {
                return filePath.replace('/frontend/src/','../../frontend/src/') // hack for tmp dir
            }
        }))
        .pipe(gulpif('*.js', ngAnnotate()))
        .pipe(gulpif('*.js', sourcemaps.init({loadMaps: true})))
        .pipe(gulpif('*.js', uglify().on('error', gulpUtil.log))) // notice the error event here
        .pipe(gulpif('*.js', sourcemaps.write('./')))
        .pipe(gulpif('*.css', nano()))
        .pipe(gulp.dest(config.tmpDir));
});


gulp.task('build', ['compress', 'copy:templates', 'copy:images', 'copy:fonts', 'copy:flatpages', 'copy:videogularcss', 'copy:other'], function() {
    gulp.src([config.tmpDir+'base.html', config.tmpDir+'/{css,js}/**/*'])
    .pipe(gulpif('*.html', replace(/\/frontend\/src\//g, '\/static\/')))
    .pipe(gulpif('*.html', replace('<script src="js/minified.js"></script>', '<script src="/static/js/minified.js?rev='+token()+'"></script>')))
    .pipe(gulpif('*.html', replace('<link rel="stylesheet" href="css/minified.css">', '<link rel="stylesheet" href="/static/css/minified.css?rev='+token()+'">')))
    .pipe(gulp.dest(config.distDir));
  });


gulp.task('copy:templates', function() {
        return gulp.src([config.srcDir+'js/components/**/*.html', config.srcDir+'js/shared/**/*.html'])
        .pipe(gulp.dest(config.distDir+'templates/'));
});

gulp.task('copy:images', function() {
        return gulp.src([config.srcDir+"images/**/*"])
        .pipe(gulp.dest(config.distDir+'images/'));
});

gulp.task('copy:fonts', function() {
        return gulp.src([config.srcDir+"css/fonts/**/*"])
        .pipe(gulp.dest(config.distDir+'fonts/'));
});

gulp.task('copy:videogularcss', function() {
        return gulp.src([config.srcDir+"css/videogular.css"])
        .pipe(gulp.dest(config.distDir+'css/'));
});

gulp.task('copy:flatpages', function() {
        return gulp.src([config.srcDir+"flatpages/**/*"])
        .pipe(gulp.dest(config.distDir+'flatpages/'));
});


gulp.task('copy:other', function() {
        return gulp.src([config.srcDir+"index.html", config.srcDir+"robots.txt", config.srcDir+"*.xml", config.srcDir+"favicon.ico"])
        .pipe(gulp.dest(config.distDir));
});

gulp.task('default', ['build'], function (event) {
  gulp.watch(config.srcDir+'**/*', ['build']);
});
