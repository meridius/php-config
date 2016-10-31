'use strict';

var watchify = require('watchify');
var browserify = require('browserify');
var gulp = require('gulp');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var gutil = require('gulp-util');
var sourcemaps = require('gulp-sourcemaps');
var assign = require('lodash.assign');
var coffeeify = require('coffeeify');

// add custom browserify options here
var customOpts = {
    basedir: "./src/js/coffee",
    extensions: ['.coffee'],
    entries: ['./index.coffee'],
    debug: true
};
var opts = assign({}, watchify.args, customOpts);
var b = watchify(browserify(opts));

// add transformations here
b.transform(coffeeify);

gulp.task('default', bundle); // so you can run `gulp js` to build the file
b.on('update', bundle); // on any dep update, runs the bundler
b.on('log', gutil.log); // output build logs to terminal

function bundle() {
    return b.bundle()
        .on('error', gutil.log.bind(gutil, 'Browserify Error')) // log errors if they happen
        .pipe(source('bundle.js'))
        .pipe(buffer()) // optional, remove if you don't need to buffer file contents
        .pipe( // optional, remove if you dont want sourcemaps
            sourcemaps.init({loadMaps: true})  // loads map from browserify file
        )
        // Add transformation tasks to the pipeline here.
        .pipe(sourcemaps.write('./')) // writes .map file
        .pipe(gulp.dest('./src/js'));
}
