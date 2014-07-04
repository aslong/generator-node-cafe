'use strict';
chalk  = require('chalk')
path   = require('path')
util   = require('util')
yeoman = require('yeoman-generator')
yosay  = require('yosay')

module.exports = NodeCafeGenerator = yeoman.generators.Base.extend(
  constructor: () ->
    yeoman.generators.Base.apply(this, arguments)
    @addStatusToReadme = true

    this.option('--no-coffee', {
      desc: "Don't enable this option. It will make you sleepy."
      type: Boolean
      defaults: false
      banner: "Don't enable this option. It will make you sleepy."
      hide: false
    })
    this.argument('name', {
      desc: "The name of the project to create."
      required: false
      optional: true
      type: String
      defaults: undefined
    })

  initializing:
    init: () =>
      @pkg = require('../../package.json')

  prompting:
    askFor: () ->
      finishedPrompting = @async()

      # Have Yeoman greet the user.
      @log(yosay('Welcome to the marvelous NodeCafe generator!'))

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
        type: 'confirm',
        name: 'addCodeStatus',
        message: 'Enable code status badges?',
        default: true
      }]

      @prompt(prompts, (answers) =>
        @log(answers.name)
        @projectName = answers.name

        @log(answers.gitAccount)
        @gitAccount = answers.gitAccount

        if answers.addCodeStatus
          @log('codesStatus Enabled')
        else
          @log('codesStatus Disabled')

        @addStatusToReadme = answers.addCodeStatus
        finishedPrompting()
      )


  configuring:
    projectConfigFiles: () ->
      @config.save()
      @copy('editorconfig', '.editorconfig')
      @copy('jshintrc', '.jshintrc')
      @copy('gitignore', '.gitignore')
      @copy('bowerrc', '.bowerrc')
      @copy('travis.yml', '.travis.yml')
      @template('_README.md', 'README.md', { 'projectName': @projectName, 'gitAccount': @gitAccount, 'addStatusToReadme': @addStatusToReadme })

      @template('_package.json', 'package.json', { 'projectName': @projectName, 'gitAccount': @gitAccount })
      @copy('_bower.json', 'bower.json')
      @copy('_Gruntfile.coffee', 'Gruntfile.coffee')
      @copy('_Dockerfile', 'Dockerfile')

  #default:

  writing:
    app: () ->
      @mkdir('src')
      @copy('_index.coffee', 'src/index.coffee')

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
