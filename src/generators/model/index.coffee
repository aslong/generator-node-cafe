'use strict';
chalk    = require('chalk')
execSync = require('exec-sync')
path     = require('path')
util     = require('util')
yeoman   = require('yeoman-generator')
yosay    = require('yosay')
_        = require('underscore')

helper = "../../"
helper += "coverage-" if process.env.JSCOV
{ runGenerator } = require("#{helper}helpers")

module.exports = NodeCafeGenerator = yeoman.generators.Base.extend(
  constructor: () ->
    yeoman.generators.Base.apply(this, arguments)
    this.option('all-tests', {
      desc: "Generate all tests for this model file"
      type: Boolean
      defaults: false
      banner: ""
      hide: false
    })

    this.option('unit-test', {
      desc: "Generate unit test for this model file"
      type: Boolean
      defaults: false
      banner: ""
      hide: false
    })

    this.argument('name', {
      desc: "The name of the model to create."
      required: true
      optional: false
      type: String
      defaults: undefined
    })

  initializing: () =>
    @pkg = require('../../package.json')

  prompting: () ->
    # Have Yeoman greet the user.
    @log(yosay("NodeCafe is generating your #{@name} model!"))


  configuring:
    projectConfigFiles: () ->
      @modelConfig = @config.getAll()

  #default:

  writing:
    model: () ->
      @mkdir('src/models')
      @template('_index.coffee', "src/models/#{@name}.coffee", _.extend(@modelConfig, { name: @name }))

    tests: () ->
      done = @async()

      if @options['all-tests']
        runGenerator('test', "model #{ @name }", {
          integration: true
          perf: true
        }, {}, done)
      else if @options['unit-test']
        runGenerator('test', "model #{ @name }", {}, {}, done)
      else
        done()

  #install:
    #installDependencies: () ->
      #if not @options['skip-install']
        #@installDependencies()

  #end:
)
