'use strict';
chalk  = require('chalk')
path   = require('path')
util   = require('util')
yeoman = require('yeoman-generator')
yosay  = require('yosay')

module.exports = NodeCafeGenerator = yeoman.generators.Base.extend(
  constructor: () ->
    yeoman.generators.Base.apply(this, arguments)

    @argument('projectName', {
      desc: "The name of the project to create."
      required: false
      optional: true
      type: String
      defaults: "MyProject"
    })

  initializing:
    init: () =>
      @pkg = require('../../package.json')

  prompting:
    askFor: () ->
      done = @async()

      # Have Yeoman greet the user.
      @log(yosay('Welcome to the marvelous NodeCafe generator!'))

      @prompt({
        type: 'input',
        name: 'name',
        message: 'Please name your new node cafe project',
        default: this.appname # Default to current folder name
      }, (answers) =>
        @log(answers.name)
        @projectName = answers.name
        done()
      )

  configuring:
    projectConfigFiles: () ->
      @copy('editorconfig', '.editorconfig')
      @copy('jshintrc', '.jshintrc')
      @copy('gitignore', '.gitignore')
      @copy('travis.yml', '.travis.yml')
      @copy('_README.md', 'README.md')

      @copy('_package.json', 'package.json')
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
