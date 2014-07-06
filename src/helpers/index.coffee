useCoverage = "/"
useCoverage = "/bin/coverage-" if process.env.JSCOV

helpers = require('yeoman-generator').test
path    = require('path')

module.exports =
  getCoveragePath: () ->
    return "../#{useCoverage}generators/"

  runGenerator: (generator, args, options, prompts, cb) ->
    helpers.run(path.join(__dirname, "#{module.exports.getCoveragePath()}#{generator}"))
    .withArguments(args)
    .withOptions(options)
    .withPrompt(prompts)
    .on('end', cb)
