Stylish reporter for gulp-scss-lint, following the visual style of ESLint stylish reporter

[![dependencies](https://david-dm.org/jsek/gulp-scss-lint-stylish2.png)](https://david-dm.org/jsek/gulp-scss-lint-stylish2) 
[![licence](https://img.shields.io/npm/l/gulp-scss-lint-stylish2.svg)](https://github.com/jsek/gulp-scss-lint-stylish2/blob/master/LICENSE)
[![npm version](http://img.shields.io/npm/v/gulp-scss-lint-stylish2.svg)](https://npmjs.org/package/gulp-scss-lint-stylish2) 
[![downloads](https://img.shields.io/npm/dm/gulp-scss-lint-stylish2.svg)](https://npmjs.org/package/gulp-scss-lint-stylish2) 

* [Overview](#overview)
* [Installation](#installation)
* [Usage](#usage)

## Overview

Example console output:

![screenshot](images/screenshot_2.0.0.png)

## Installation

```
npm install --save gulp-scss-lint-stylish2
```

## Usage

``` javascript
var gulp     = require('gulp'),
    scssLint = require('gulp-scss-lint'),
    stylish  = require('gulp-scss-lint-stylish2');
 
gulp.task('scss-lint', function()
{
    var reporter = stylish();

    gulp.src('/scss/*.scss')
        .pipe( scssLint({ customReport: reporter.issues }) )
        .pipe( reporter.printSummary );
});
```

Use `errorsOnly` parameter to filter out warnings:

``` javascript
    var reporter = stylish({ errorsOnly: true });
```

![screenshot](images/screenshot_2.0.0-errors.png)

You can list just the files:

``` javascript
        .pipe( scssLint({ customReport: reporter.files }) )
        .pipe( reporter.printSummary );
```

![screenshot](images/screenshot_2.0.0-files.png)

... or suppress output and print just the summary:

``` javascript
        .pipe( scssLint({ customReport: reporter.silent }) )
        .pipe( reporter.printSummary );
```

![screenshot](images/screenshot_2.0.0-silent.png)