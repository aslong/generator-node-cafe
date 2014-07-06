### global describe, beforeEach, it ###
'use strict'
{ runGenerator, runDefaultGenerator } = require('../helpers')

assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

describe 'node-cafe generator', () ->
  before (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      runDefaultGenerator(done)
    )

  it 'creates the expected config files', (done) ->
    assert.file([
      '.bowerrc'
      '.editorconfig'
      '.dockerignore'
      '.gitignore'
      '.jshintrc'
      '.travis.yml'
      'bower.json'
      'Dockerfile'
      'Gruntfile.coffee'
      'package.json'
    ])
    done()

  it 'creates the expected test files', (done) ->
    assert.file([
      'test/mocha.opts'
      'test/helpers/index.coffee'
      'test/perf/index.coffee'
      'test/unit/index.coffee'
      'test/integration/index.coffee'
    ])
    done()

  it 'creates the expected source files', (done) ->
    assert.file([
      'src/index.coffee'
      'src/static/css/main.css'
    ])
    done()

  it 'creates expected project files', (done) ->
    assert.file([
      'README.md'
    ])
    done()
