var gulp        = require('gulp');
var postcss     = require('gulp-postcss');
var reporter    = require('postcss-reporter');
var syntax_scss = require('postcss-scss');
var stylelint   = require('stylelint');

gulp.task("scss-lint", function() {

  // Stylelint config rules
  var stylelintConfig = {
	"extends": "stylelint-config-recommended"
  }

  var processors = [
    stylelint(stylelintConfig),
    reporter({
      clearMessages: true,
      throwError: true
    })
  ];

  return gulp.src(
      ['app/css/**/*.scss',
      // Ignore linting vendor assets
      // Useful if you have bower components
      '!app/assets/css/**/*.scss']
    )
    .pipe(postcss(processors, {syntax: syntax_scss}));
});

var concat = require('gulp-concat');
// Concatenate JS Files
gulp.task('scripts', function() {
   return gulp.src('app/js/components/*.js')
	.pipe(concat('script.js'))
	.pipe(gulp.dest('app/js'));
});

  gulp.task('sass', function () {
	gulp.src('app/css/sass/*.scss')
	  .pipe(sass.sync().on('error', sass.logError))
	  .pipe(gulp.dest('./app/css'));
  });

  gulp.task('watch', function () {
	gulp.watch('app/css/sass/*.scss', ['sass']);
	gulp.watch('app/js/components/*.js', ['scripts']);
  });