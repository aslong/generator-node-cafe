### global describe, beforeEach, it ###
'use strict'

assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

{ runGenerator } = require('../helpers')

describe 'node-cafe:connector generator', () ->
  before (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      runGenerator('connector', 'hi', {
        'skip-install': true
      }, {
        'name': 'myProject'
      }, done)
    )

  it 'creates the expected source files', (done) ->
    assert.file([
      'src/connector/index.coffee'
    ])
    done()
