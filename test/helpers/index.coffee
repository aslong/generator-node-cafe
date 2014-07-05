useCoverage = "/"
useCoverage = "/bin/coverage-" if process.env.JSCOV

helpers = require('yeoman-generator').test
path    = require('path')

module.exports =
  getCoveragePath: () ->
    return "../../#{useCoverage}generators/"

  requireCoverage: (moduleName) ->
    return require("#{module.exports.getCoveragePath()}#{moduleName}")

  runGenerator: (generator, args, options, prompts, cb) ->
    helpers.run(path.join(__dirname, "#{module.exports.getCoveragePath()}#{generator}"))
    .withArguments(args)
    .withOptions(options)
    .withPrompt(prompts)
    .on('end', () ->
      cb()
    )

  runDefaultGenerator: (cb) ->
    module.exports.runGenerator('app', 'hi', {
      'skip-install': true
    }, {
      'name': 'myProject'
      'keywords': 'project, my, test'
    }, cb)
