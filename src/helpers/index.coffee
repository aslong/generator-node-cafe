helpers = require('yeoman-generator').test
path    = require('path')

module.exports =
  runGenerator: (generator, args, options, prompts, cb) ->
    helpers.run(path.join(__dirname, "../generators/#{generator}"))
    .withArguments(args)
    .withOptions(options)
    .withPrompt(prompts)
    .on('end', () ->
      cb() if cb?
    )
