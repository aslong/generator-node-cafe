### global describe, beforeEach, it ###
'use strict'
assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

describe 'node-cafe:connector generator', () ->
  before (done) ->
    helpers.run(path.join(__dirname, '../../generators/connector'))
    .inDir(path.join(__dirname, '../../temp'))
    .withArguments('hi')
    .withOptions({
      'skip-install': true
    })
    .withPrompt({
      'name': 'myProject'
    })
    .onEnd(() -> done())

  it 'creates the expected source files', (done) ->
    assert.file([
      'src/connector/index.coffee'
    ])
    done()
