#global describe, beforeEach, it
'use strict'
assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

describe 'node-cafe generator', () ->
  before (done) ->
    helpers.run(path.join(__dirname, '../../generators/app'))
    .inDir(path.join(__dirname, '../../temp'))
    .withOptions({
      'skip-install': true
    })
    .withPrompt({
      'someOption': true
    })
    .onEnd(() -> done())

  it 'creates the expected config files', (done) ->
    assert.file([
      '.jshintrc',
      '.editorconfig',
      '.gitignore',
      'Gruntfile.coffee',
      'package.json',
      'Dockerfile',
      'bower.json',
    ])
    done()

  it 'creates the expected test files', (done) ->
    assert.file([
      'test/mocha.opts',
      'test/unit/index.coffee',
      'test/perf/index.coffee',
    ])
    done()

  it 'creates the expected source files', (done) ->
    assert.file([
      'src/index.coffee'
    ])
    done()

  it 'creates expected project files', (done) ->
    assert.file([
      'README.md'
    ])
    done()
