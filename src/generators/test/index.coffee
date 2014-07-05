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
    this.option('no-unit', {
      desc: "Don't generate a unit test"
      type: Boolean
      defaults: false
      banner: ""
      hide: false
    })

    this.option('perf', {
      desc: "Generate a perf test"
      type: Boolean
      defaults: false
      banner: ""
      hide: false
    })

    this.option('integration', {
      desc: "Generate a integration test"
      type: Boolean
      defaults: false
      banner: ""
      hide: false
    })

    this.argument('componentTesting', {
      desc: "The component to test (connector/model/transport/...)"
      required: true
      optional: false
      type: String
      defaults: undefined
    })

    this.argument('name', {
      desc: "The name of the test to create."
      required: true
      optional: false
      type: String
      defaults: undefined
    })

  initializing: () ->
    @pkg = require('../../package.json')
    @testTypes = []

    if not @options['unit']?
      @testTypes.push('unit')

    if @options['perf']
      @testTypes.push('perf')

    if @options['integration']
      @testTypes.push('integration')

  prompting: () ->
    # Have Yeoman greet the user.
    @log(yosay('NodeCafe is generating your test!'))

  configuring:
    projectConfigFiles: () ->
      @testConfig = @config.getAll()
      @testConfig = _.extend(@testConfig, {
        name: @name
        componentTesting: @componentTesting
      })

  #default:

  writing:
    connector: () ->
      for testType in @testTypes
        testConfig = _.extend(@testConfig, { testType: testType })
        @template('_test.coffee', "test/#{testConfig.testType}/#{@componentTesting}/#{@name}.coffee", testConfig)

  #install:
    #installDependencies: () ->
      #if not @options['skip-install']
        #@installDependencies()

  #end:
)
