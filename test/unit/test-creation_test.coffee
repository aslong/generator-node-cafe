### global describe, beforeEach, it ###
'use strict'
assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

describe 'node-cafe generator', () ->
  before (done) ->
    helpers.run(path.join(__dirname, '../../generators/test'))
    .inDir(path.join(__dirname, '../../temp'))
    .withArguments('hi')
    .withOptions({
      'skip-install': true
    })
    .withPrompt({
      'name': 'myProject'
    })
    .onEnd(() -> done())

  it 'passes', (done) ->
    done()
