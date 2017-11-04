// including plugins
var gulp = require('gulp'), 
    sass = require("gulp-sass"),
    jshint = require("gulp-jshint"),
    minifyCss = require("gulp-minify-css"),
    uglify = require("gulp-uglify");
 
// Comile SASS
gulp.task('compile-sass', function () {
    gulp.src('./app/css/sass/style.scss') // path to your file
    .pipe(sass())
    .pipe(gulp.dest('app/css/'));
});
 
// Js Lint
gulp.task('jsLint', function () {
    gulp.src('./app/js/components/*.js') // path to your files
    .pipe(jshint())
    .pipe(jshint.reporter()); // Dump results
});

// Minify CSS
gulp.task('minify-js', function () {
  gulp.src('./app/js/*.js') // path to your files
  .pipe(uglify())
  .pipe(gulp.dest('app/js'));
});

gulp.task('minify-css', function () {
  gulp.src('./app/css/style.css') // path to your file
  .pipe(minifyCss())
  .pipe(gulp.dest('app/css'));
});