'use strict';
chalk    = require('chalk')
execSync = require('exec-sync')
path     = require('path')
util     = require('util')
yeoman   = require('yeoman-generator')
yosay    = require('yosay')

module.exports = NodeCafeGenerator = yeoman.generators.Base.extend(
  constructor: () ->
    yeoman.generators.Base.apply(this, arguments)
    @addStatusToReadme = true

    this.argument('name', {
      desc: "The name of the project to create."
      required: false
      optional: true
      type: String
      defaults: undefined
    })

    try
      @authorEmail = execSync('git config --global --get user.email')
      @authorName = execSync('git config --global --get user.name')
    catch e
      @authorEmail = ''
      @authorName = ''

  initializing: () =>
    @pkg = require("../../package.json")

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
      config =
        projectEnvName: @projectEnvName
        keywords: @keywords
        projectDescription: @projectDescription,
        projectName: @projectName
        authorEmail: @authorEmail
        authorName: @authorName
        gitAccount: @gitAccount
        addStatusToReadme: @addStatusToReadme

      @config.set(config)
      @config.save()

      @copy('editorconfig', '.editorconfig')
      @copy('jshintrc', '.jshintrc')
      @copy('gitignore', '.gitignore')
      @copy('dockerignore', '.dockerignore')
      @copy('bowerrc', '.bowerrc')
      @copy('travis.yml', '.travis.yml')
      @template('_README.md', 'README.md', config)

      @template('_package.json', 'package.json', config)
      @template('_bower.json', 'bower.json', config)
      @template('_Gruntfile.coffee', 'Gruntfile.coffee', config)
      @template('_Dockerfile', 'Dockerfile', config)

  #default:

  writing:
    app: () ->
      @mkdir('src')
      @copy('_index.coffee', 'src/index.coffee')
      @mkdir('src/static/css')
      @copy('_main.css', 'src/static/css/main.css')

    test: () ->
      @mkdir('test')
      @copy('_mocha.opts', 'test/mocha.opts')
      @mkdir('test/unit')
      @copy('_unit_test_index.coffee', 'test/unit/index.coffee')
      @mkdir('test/perf')
      @copy('_perf_test_index.coffee', 'test/perf/index.coffee')

  install:
    installDependencies: () ->
      if not @options['skip-install']
        @installDependencies()

  #end:
)
