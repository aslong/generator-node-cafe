'use strict';
chalk    = require('chalk')
execSync = require('exec-sync')
path     = require('path')
util     = require('util')
yeoman   = require('yeoman-generator')
yosay    = require('yosay')
_        = require('underscore')

module.exports = NodeCafeGenerator = yeoman.generators.Base.extend(
  constructor: () ->
    yeoman.generators.Base.apply(this, arguments)

    this.argument('name', {
      desc: "The name of the project to create."
      required: false
      optional: true
      type: String
      defaults: undefined
    })

  initializing: () =>
    @pkg = require("../../package.json")
    @addStatusToReadme = true

    try
      @authorEmail = execSync('git config --global --get user.email')
      @authorName = execSync('git config --global --get user.name')
    catch e
      @authorEmail = ''
      @authorName = ''

  prompting: () ->
    finishedPrompting = @async()

    # Have Yeoman greet the user.
    @log(yosay('Welcome to NodeCafe!'))

    prompts = [{
      type: 'input',
      name: 'name',
      message: 'Please name your new node cafe project',
      default: @name || @appname # Default to current folder name
    }, {
      type: 'input',
      name: 'gitAccount',
      message: 'Enter the git account this repo will be under',
      default: @gitAccount
    }, {
      type: 'input',
      name: 'projectDescription',
      message: 'Enter a project description',
      default: ''
    }, {
      type: 'input',
      name: 'keywords',
      message: 'Enter keywords for project',
      default: ''
    }, {
      type: 'confirm',
      name: 'addCodeStatus',
      message: 'Enable code status badges?',
      default: true
    }]

    @prompt(prompts, (answers) =>
      @projectName = answers.name.replace(new RegExp(" ", "g"), "_")

      @projectEnvName = @projectName.replace(new RegExp("-", "g"), "_").toUpperCase() + "_ENV"

      @gitAccount = answers.gitAccount

      @projectDescription = answers.projectDescription

      splitKeywords = answers.keywords.split(',')
      @keywords = []
      for i in [0...splitKeywords.length]
        splitKeyword = splitKeywords[i].trim()
        @keywords.push(splitKeyword) if splitKeyword.length > 0

      @addStatusToReadme = answers.addCodeStatus

      finishedPrompting()
    )

  configuring:
    projectConfigFiles: () ->
      @currentConfig =
        projectEnvName: @projectEnvName
        keywords: @keywords
        projectDescription: @projectDescription,
        projectName: @projectName
        authorEmail: @authorEmail
        authorName: @authorName
        gitAccount: @gitAccount
        addStatusToReadme: @addStatusToReadme

      @config.set(@currentConfig)
      @config.save()

      @copy('editorconfig', '.editorconfig')
      @copy('jshintrc', '.jshintrc')
      @copy('gitignore', '.gitignore')
      @copy('dockerignore', '.dockerignore')
      @copy('bowerrc', '.bowerrc')
      @copy('travis.yml', '.travis.yml')
      @template('_README.md', 'README.md', @currentConfig)

      @template('_package.json', 'package.json', @currentConfig)
      @template('_bower.json', 'bower.json', @currentConfig)
      @template('_Gruntfile.coffee', 'Gruntfile.coffee', @currentConfig)
      @template('_Dockerfile', 'Dockerfile', @currentConfig)

  #default:

  writing:
    app: () ->
      @mkdir('src')
      @template('_index.coffee', 'src/index.coffee', @currentConfig)

    staticApp: () ->
      @mkdir('src/static/css')
      @copy('_main.css', 'src/static/css/main.css')

    test: () ->
      @mkdir('test')
      @copy('_mocha.opts', 'test/mocha.opts')
      @mkdir('test/helpers')
      @copy('_test_helpers_index.coffee', 'test/helpers/index.coffee')
      @mkdir('test/unit')
      @template('_test_index.coffee', 'test/unit/index.coffee', _.extend(@currentConfig, { testType: 'unit' }))
      @mkdir('test/perf')
      @template('_test_index.coffee', 'test/perf/index.coffee', _.extend(@currentConfig, { testType: 'perf' }))
      @mkdir('test/integration')
      @template('_test_index.coffee', 'test/integration/index.coffee', _.extend(@currentConfig, { testType: 'integration' }))

  install:
    installDependencies: () ->
      if not @options['skip-install']
        @installDependencies()

  #end:
)
