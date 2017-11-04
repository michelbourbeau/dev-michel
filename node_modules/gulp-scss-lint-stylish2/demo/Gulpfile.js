var gulp     = require('gulp'),
    scssLint = require('gulp-scss-lint'),
    stylish  = require('gulp-scss-lint-stylish2');

gulp.task('scsslint', function() {
    var reporter = stylish();
    
    gulp.src(['./**/*.scss'])
        .pipe(scssLint({
            config: './scsslint.config.yml',
            customReport: reporter.issues
        }))
        .pipe(reporter.printSummary);
    });

gulp.task('scsslint_errors', function() {
    var reporter = stylish({ errorsOnly: true });
    
    gulp.src(['./**/*.scss'])
        .pipe(scssLint({
            config: './scsslint.config.yml',
            customReport: reporter.issues
        }))
        .pipe(reporter.printSummary);
    });

gulp.task('scsslint_files', function() {
    var reporter = stylish();
    
    gulp.src(['./**/*.scss'])
        .pipe(scssLint({
            config: './scsslint.config.yml',
            customReport: reporter.files
        }))
        .pipe(reporter.printSummary);
    });


gulp.task('scsslint_silent', function() {
    var reporter = stylish();
    
    gulp.src(['./**/*.scss'])
        .pipe(scssLint({
            config: './scsslint.config.yml',
            customReport: reporter.silent
        }))
        .pipe(reporter.printSummary);
    });
