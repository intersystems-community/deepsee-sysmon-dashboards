'use strict';

let isWin = /^win/.test(process.platform);

const gulp = require('gulp'),
    del = require('del'),
    autoprefixer = require('gulp-autoprefixer'),
    gulpIf = require('gulp-if'),
    uglify = require('gulp-uglify'),
    useref = require('gulp-useref'),
    jshint = require('gulp-jshint'),
    cssmin = require('gulp-cssmin'),
    concat = require('gulp-concat'),
    htmlmin = require('gulp-minify-html-2'),
    templateCache = require('gulp-angular-templatecache'),
    replace = require('gulp-replace'),
    through = require('through2'),
    traceur = require('gulp-traceur-compiler'),
    debug = require('gulp-debug'),
    gulpIgnore = require('gulp-ignore'),
    fs = require("fs"),
    p = require('./package.json');

gulp.task('lint', function () {
    return gulp.src(['./csp-data/csp/src/app.js','./csp-data/csp/src/controller/*.js'])
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
});

gulp.task('minify:js', function () {
    return gulp.src('./csp-data/csp/index.html')
        .pipe(useref())
        .pipe(gulpIf("*.js",replace('\'{{package.json.version}}\'', '"' + p.version + '"')))
        .pipe(gulpIf("*.js",traceur()))
        .pipe(gulpIf("*.js",uglify()))
        .pipe(gulpIf("*.html",htmlmin({empty: false})))
        .pipe(gulp.dest('build'));
});

gulp.task('minify:css', function () {
    return gulp.src('./csp-data/csp/lib/css/style.css')
        .pipe(autoprefixer())
        .pipe(cssmin())
        .pipe(gulp.dest('build/lib/css'))
});

gulp.task('minify:template', function () {
    return gulp.src('./csp-data/csp/src/views/*.html')
        .pipe(htmlmin({empty: false}))
        .pipe(templateCache({root:"src/views"}))
        .pipe(gulp.dest('build/'))
});

gulp.task('concat-with-templates', function () {
    return gulp.src(['build/app.js', 'build/templates.js'])
        .pipe(concat('app.js'))
        .pipe(gulp.dest('build'))
});

gulp.task('copy:csslibs', function () {
    return gulp.src('./csp-data/csp/lib/css/*.min.css')
        .pipe(gulp.dest('build/lib/css'));
});

gulp.task('copy:jslibs', function () {
    return gulp.src('./csp-data/csp/lib/js/*.*')
        .pipe(gulp.dest('build/lib/js'))
});

gulp.task('copy:fonts', function () {
    return gulp.src('./csp-data/csp/lib/fonts/*.*')
        .pipe(gulp.dest('build/lib/fonts'))
});

gulp.task('cleanup:before-build',function () {
    return new Promise((resolve,reject)=>{
        del('./build');
        resolve();
    });
});

gulp.task('cleanup:after-build',function () {
    return new Promise((resolve,reject)=>{
        del('./build/templates.js');
        resolve();
    });
});

let FILE_LISTCSP;
gulp.task('enum-files:csp', function() {
    FILE_LISTCSP = [];
    return gulp.src('build/**/*.*',{read: false})
        .pipe(gulpIgnore.exclude('*.xml'))
        .pipe(through.obj(function (chunk, enc, cb) {
            if (!chunk.isDirectory()) FILE_LISTCSP.push(chunk.relative);
            cb(null, chunk);
        }));
});

let FILE_LISTCLS;
gulp.task('enum-files:cls', function() {
    FILE_LISTCLS = [];
    return gulp.src('./cls/**/*.*',{read: false})
        .pipe(gulpIgnore.exclude('*.xml'))
        .pipe(through.obj(function (chunk, enc, cb) {
            if (!chunk.isDirectory()) FILE_LISTCLS.push(chunk.relative);
            cb(null, chunk)
        }));
});

let FILE_LISTDFI;
gulp.task('enum-files:dfi', function() {
    FILE_LISTDFI = [];
    return gulp.src('dfi/*.*',{read: false})
        .pipe(gulpIgnore.exclude('*.xml'))
        .pipe(through.obj(function (chunk, enc, cb) {
            if (!chunk.isDirectory()) FILE_LISTDFI.push(chunk.relative);
            cb(null, chunk)
        }));
});

gulp.task('create-xml-package:csp', function () {
    return new Promise((resolve, reject)=>{
        if (!FILE_LISTCSP || !Array.isArray(FILE_LISTCSP) || FILE_LISTCSP.length === 0)
            reject(new Error('Please, build project before create package.'));

        let append = '';

        for (let i = 0; i < FILE_LISTCSP.length; i++) {

            console.log('CSP: Adding file:', FILE_LISTCSP[i]);
            let content = fs.readFileSync('./build/' + FILE_LISTCSP[i], 'binary');
            content = new Buffer(content, 'binary').toString('base64');

            let step = 32767;
            let k = step;

            while (k < content.length) {
                content = content.substring(0,k) + '\r\n' + content.substring(k, content.length);
                k += step;
            }

            append +=

`<XData name="File${i}">
    <Description>${FILE_LISTCSP[i]}</Description>
    <MimeType>text/plain</MimeType>
    <Data><![CDATA[${content}]]></Data>
</XData>`;

        }

        append = '<Class name="SYSMON.CSPData">' + append + '</Class>';
        fs.writeFileSync('./build/SYSMON.CSPData.xml', append);

        FILE_LISTCSP.length = 0;
        resolve();
    });
});

gulp.task('create-xml-package:cls', function () {
    return new Promise((resolve, reject)=>{
        if (!FILE_LISTCLS || !Array.isArray(FILE_LISTCLS) || FILE_LISTCLS.length === 0)
            reject(new Error('Please, build project before create package.'));

        let append = '';

        for (let i = 0; i < FILE_LISTCLS.length; i++) {

            console.log('CLS: Adding file:', FILE_LISTCLS[i]);
            let content = fs.readFileSync('./cls/' + FILE_LISTCLS[i], 'binary');
            content = new Buffer(content, 'binary').toString('base64');

            let step = 32767;
            let k = step;

            while (k < content.length) {
                content = content.substring(0,k) + '\r\n' + content.substring(k, content.length);
                k += step;
            }

            append +=
`<XData name="File${i}">
    <Description>${FILE_LISTCLS[i].replace(isWin ? /\\/g : /\//g,".")}</Description>
    <MimeType>text/plain</MimeType>
    <Data><![CDATA[${content}]]></Data>
</XData>`;

        }

        append = '<Class name="SYSMON.CLSData">' + append + '</Class>';
        fs.writeFileSync('./build/SYSMON.CLSData.xml', append);

        FILE_LISTCLS.length = 0;
        resolve();
    });
});

gulp.task('create-xml-package:dfi', function () {
    return new Promise((resolve, reject)=>{
        if (!FILE_LISTDFI || !Array.isArray(FILE_LISTDFI) || FILE_LISTDFI.length === 0)
            reject(new Error('Please, build project before create package.'));

        let append = '';

        for (let i = 0; i < FILE_LISTDFI.length; i++) {

            console.log('DFI: Adding file:', FILE_LISTDFI[i]);
            let content = fs.readFileSync('./dfi/' + FILE_LISTDFI[i], 'binary');
            content = new Buffer(content, 'binary').toString('base64');

            let step = 32767;
            let k = step;

            while (k < content.length) {
                content = content.substring(0,k) + '\r\n' + content.substring(k, content.length);
                k += step;
            }

            append +=

`<XData name="File${i}">
    <Description>${FILE_LISTDFI[i].replace(/_/g, " ")}</Description>
    <MimeType>text/plain</MimeType>
    <Data><![CDATA[${content}]]></Data>
</XData>`;

        }

        append = '<Class name="SYSMON.DFIData">' + append + '</Class>';
        fs.writeFileSync('./build/SYSMON.DFIData.xml', append);

        FILE_LISTDFI.length = 0;
        resolve();
    });
});

gulp.task('concat-installer-files', function () {
    return new Promise((resolve,reject)=>{
        let installer = fs.readFileSync('./Installer.xml','utf8');
        let CLSFiles = fs.readFileSync('./build/SYSMON.CLSData.xml','utf8');
        let CSPFiles = fs.readFileSync('./build/SYSMON.CSPData.xml','utf8');
        let DFIFiles = fs.readFileSync('./build/SYSMON.DFIData.xml','utf8');

        installer = installer.substring(0,installer.length-11) + CLSFiles + CSPFiles + DFIFiles + "</Export>";

        fs.writeFileSync('./build/Installer'+p.version+'.xml', installer);
        resolve();
    });
});

gulp.task('cleanup:before-creating-installer', function () {
    return new Promise((resolve,reject)=>{
        del('build/Installer*.xml');
        resolve();
    });
});

gulp.task('cleanup:after-creating-installer', function () {
    return new Promise((resolve,reject)=>{
        del('build/SYSMON.*.xml');
        resolve();
    });
});

gulp.task('minify', gulp.series(gulp.parallel('minify:js','minify:css','minify:template'), 'concat-with-templates'));
gulp.task('copy', gulp.parallel('copy:csslibs','copy:jslibs','copy:fonts'));
gulp.task('build', gulp.series('lint','cleanup:before-build',gulp.parallel('minify','copy'),'cleanup:after-build'));
gulp.task('create-package:csp', gulp.series('enum-files:csp','create-xml-package:csp'));
gulp.task('create-package:cls', gulp.series('enum-files:cls','create-xml-package:cls'));
gulp.task('create-package:dfi', gulp.series('enum-files:dfi','create-xml-package:dfi'));
gulp.task('create-package',gulp.parallel('create-package:csp','create-package:cls','create-package:dfi'));
gulp.task('create-install-file', gulp.series('cleanup:before-creating-installer', 'create-package', 'concat-installer-files', 'cleanup:after-creating-installer'));
gulp.task('default', gulp.series('build'));
