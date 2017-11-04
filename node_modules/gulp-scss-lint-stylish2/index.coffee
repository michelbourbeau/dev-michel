###
 * @fileoverview Custom stylish reporter for gulp-scss-lint
 * @author J-Sek
###

gutil   = require('gulp-util')
table   = require('text-table')
through = require('through2')

lastFailingFile = null
cl = gutil.colors

severityColor = 
    warning : cl.yellow
    error   : cl.red 

#------------------------------------------------------------------------------
# Helpers
#------------------------------------------------------------------------------

printPath     = (path) -> 
    filename = path.match(new RegExp("([^\\\\]+)\\.[a-zA-Z]+$"))[1]
    extension = path.match(new RegExp("\\.([a-zA-Z]+)$"))[1]
    dir = path.slice(0, path.length - filename.length - extension.length - 1)
    return '\n' + cl.magenta(dir) + cl.yellow(filename) + cl.magenta('.' + extension)
    
printPlaceRaw = (issue) -> "(#{issue.line},#{issue.column})"
printSeverity = (issue) -> severityColor[issue.severity](issue.severity)
printLinter   = (issue) -> cl.gray(issue.linter)
pluralize     = (word, count) -> if count > 1 then word + 's' else word
passThrough   = (file, enc, cb) -> cb(null, file)

printPathLine = (file) ->
    if (lastFailingFile != file.path)
        lastFailingFile = file.path
        console.log printPath(lastFailingFile)

logStylish    = (issues) ->
    data = for issue in issues
        [
            ""
            issue.line
            issue.column
            printSeverity issue
            issue.reason
            printLinter issue
        ]
        
    tableOptions = 
        align: ["", "r", "l"],
        stringLength: (str) -> cl.stripColor(str).length

    results = table(data, tableOptions)
        .split '\n'
        .map (x) -> x.replace /(\d+)\s+(\d+)/, (m, p1, p2) -> cl.gray(p1 + ':' + p2)
        .map (x) -> x.replace /`([^`]*)`/g, (m, p1) -> "`#{cl.cyan(p1)}`"
        .join '\n'

    results

#------------------------------------------------------------------------------
# Reporters
#------------------------------------------------------------------------------

###
 * Inspired by 'stylish' ESLint reporter
 * Usage: stream element, like for ESLint
###

stylishPrintFile = (file) ->
    if !file.scsslint.success
        printPathLine file
        logStylish file.scsslint.issues

stylishPrintErrorsInFile = (file) ->
    if file.scsslint.errors > 0
        printPathLine file
        logStylish file.scsslint.issues.filter((x) -> x.severity is 'error')
    
stylishSummary = (total, errors, warnings) ->
    if total > 0
        console.log cl.red.bold "\n\u2716  #{total} #{pluralize('problem', total)} (#{errors} #{pluralize('error', errors)}, #{warnings} #{pluralize('warning', warnings)})\n"
    
stylishErrorsSummary = (total, errors, warnings) ->
    if total > 0
        console.log cl.red.bold "\n\u2716  #{errors} #{pluralize('error', errors)}!\n"

writeSuccess = ->
    console.log cl.green.bold "\n\u2714 Success! No issues found\n"

writeStylishResults = (results, summaryFormatter) ->
    total = errors = warnings = 0
    
    for result in results
        total += result.scsslint.issues.length
        errors += result.scsslint.errors
        warnings += result.scsslint.warnings
        
    if total > 0 then summaryFormatter(total, errors, warnings)

reportWithSummary = (fileFormatter, summaryFormatter) ->
    results = []
    return {
        issues: (file, stream) ->
            unless file.scsslint.success
                results.push file
                fileIssues = fileFormatter(file)
                if fileIssues
                    process.stderr.write(fileIssues + '\n')
        
        silent: (file, stream) ->
            unless file.scsslint.success
                results.push file
            
        files: (file, stream) ->
            unless file.scsslint.success
                results.push file
                process.stderr.write printPath(file.path)
        
        printSummary: through.obj passThrough, ->
            if results.length > 0
                writeStylishResults(results, summaryFormatter);
            else
                writeSuccess();
            results = []
    }

stylishReporter = (opts) ->
    opts = opts or {}
    if opts.errorsOnly
        reportWithSummary stylishPrintErrorsInFile, stylishErrorsSummary
    else
        reportWithSummary stylishPrintFile, stylishSummary

#------------------------------------------------------------------------------

module.exports = stylishReporter