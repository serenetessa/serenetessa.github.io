'use strict';

var watchify = require('watchify');
var browserify = require('browserify');
var gulp = require('gulp');
var uglify = require('gulp-uglify');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var cache = require('gulp-cached');
var gutil = require('gulp-util');
var sourcemaps = require('gulp-sourcemaps');
var less = require('gulp-less');
var replace = require('gulp-replace');
var argv = require('yargs').argv;
var browserSync = require('browser-sync').create();
var nodeResolve = require('resolve');
var _ = require('lodash');

var buildPath = './dist/src/';

var customOpts = {
    entries: ['./src/initialize'],
    debug: true,
    paths: ['./src'],
    extensions: ['.coffee']
};
var opts = customOpts;
var b = browserify(opts);

var packageManifest = require('./package.json');

getNPMPackageIds().forEach(function (id) {
    b.external(id);
});
getVendorDepend().forEach(function (id) {
    b.external(id);
});

gulp.task('less', function () {
    return gulp.src('./src/style/theme.less')
        .pipe(sourcemaps.init())
        .pipe(less())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(buildPath + 'style'))
        .pipe(browserSync.reload({stream: true}));
});


gulp.task('watch-less', function(){
    gulp.watch('**/*.less', ['less']);
});

function getNPMPackageIds() {
    return _.keys(packageManifest.dependencies) || [];
}

function getVendorDepend() {
    return _.keys(packageManifest.vendorDependencies) || [];
}

gulp.task('build-vendor', function(){
    var br = browserify({
        debug: true,
        extensions: ['.coffee']
    });

    getVendorDepend().forEach(function (id) {
        br.require(packageManifest.vendorDependencies[id], {expose: id});
    });

    getNPMPackageIds().forEach(function (id) {
        try {
            if (!packageManifest.vendorDependencies[id])
                br.require(nodeResolve.sync(id), {expose: id});
        } catch (err){
            console.log(err);
        }
    });

    return br.bundle()
        .on('error', gutil.log.bind(gutil, 'Browserify Error'))
        .pipe(source('vendor.min.js'))
        .pipe(buffer())
        .pipe(sourcemaps.init({loadMaps: true}))
        //.pipe(uglify())
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest(buildPath + 'js'));
});

gulp.task('js', bundle);

function bundle() {
    return b.bundle()
        .on('error', gutil.log.bind(gutil, 'Browserify Error'))
        .pipe(source('main.min.js'))
        .pipe(buffer())
        .pipe(sourcemaps.init({loadMaps: true}))
        //.pipe(uglify())
        .pipe(sourcemaps.write('./', {sourceRoot: '../../../'}))
        .pipe(gulp.dest(buildPath+'js'))
        .pipe(browserSync.stream({once: true}));
}

gulp.task('copyfonts', function() {

});

gulp.task('copyindex', function() {
    var t = gulp.src('./src/index.html');
    if (argv.planName || argv.build)
        t.pipe(replace(/window.domain = '.*';/,"window.domain = '';"));
    if (argv.suffixUri)
        t.pipe(replace(/window.suffixUri = '.*';/,"window.suffixUri = '"+argv.suffixUri+"';"));
    t.pipe(replace('MAIN.JS','./dist/src/js/main.min.js?version='+argv.planName+'#'+argv.build));
    t.pipe(replace('VENDOR.JS','./dist/src/js/vendor.min.js?version='+argv.planName+'#'+argv.build))
        .pipe(replace('THEME.CSS','./dist/src/style/theme.css?version='+argv.planName+'#'+argv.build))
        .pipe(gulp.dest("./"));
});

gulp.task('copyimgs', function() {
    gulp.src('./src/img/**/*.*')
        .pipe(gulp.dest(buildPath + 'img'));
});

gulp.task('default', ['copyfonts','copyimgs', 'copyindex','build-vendor','js','less']);

gulp.task('start-server',function(){
    browserSync.init({
        server: "./"
    });
});

gulp.task('watch',['start-server','watch-less'], function () {
    b =watchify(b);
    b.on('update', bundle);
    b.on('log', gutil.log);
    b.bundle()
        .on('error', gutil.log.bind(gutil, 'Browserify Error'))
        .pipe(source('main.min.js'));
});

gulp.task('w',['watch']);
gulp.task('build-watch',['default'],function(){
    gulp.run('watch');
});
gulp.task('bw',['build-watch']);