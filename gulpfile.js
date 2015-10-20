var gulp = require('gulp');
var browserify = require('browserify');
var watch = require('watchify');
var source = require('vinyl-source-stream');
var browserSync = require('browser-sync');
var changed = require('gulp-changed');
var less = require('gulp-less');

var bundleLogger = require('./gulp/bundle-logger');
var errorHandler = require('./gulp/error-handler');

gulp.task('browserify', function() {
  var dest = './build';

  var bundler = browserify({
    cache: {}, packageCache: {}, fullPath: true,
    entries: './client/javascript/app.coffee',
    extensions: ['.coffee', '.cjsx'],
    debug: true
  });

  var bundle = function() {
    bundleLogger.start();

    return bundler.bundle()
      .on('error', errorHandler)
      .pipe(source('app.js'))
      .pipe(gulp.dest(dest))
      .on('end', bundleLogger.end);
  };

  bundler = watch(bundler);

  bundler.on('update', bundle);

  return bundle();
});

gulp.task('browserSync', ['browserify'], function() {
  browserSync.init(['build/**'], {server: {baseDir: 'build'}});
});

gulp.task('less', function() {
  var dest = './build';

  return gulp.src('./client/less/app.less')
    .pipe(changed(dest))
    .pipe(less())
    .on('error', errorHandler)
    .pipe(gulp.dest(dest));
});

gulp.task('watchLess', function() {
  gulp.watch('./client/less/*', ['less']);
});

gulp.task('default', ['browserSync', 'watchLess']);
