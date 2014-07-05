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
    ###
    this.option('--no-coffee', {
      desc: "Don't enable this option. It will make you sleepy."
      type: Boolean
      defaults: false
      banner: "Don't enable this option. It will make you sleepy."
      hide: false
    })
    ###
    this.argument('name', {
      desc: "The name of the project to create."
      required: false
      optional: true
      type: String
      defaults: undefined
    })

  initializing: () =>
    @pkg = require('../../package.json')

  prompting: () ->
    # Have Yeoman greet the user.
    @log(yosay('NodeCafe is generating your connector!'))


  configuring:
    projectConfigFiles: () ->
      @config.save()

  #default:

  writing:
    connector: () ->
      @mkdir('src/connector')
      @copy('_index.coffee', 'src/connector/index.coffee')

  #install:
    #installDependencies: () ->
      #if not @options['skip-install']
        #@installDependencies()

  #end:
)
