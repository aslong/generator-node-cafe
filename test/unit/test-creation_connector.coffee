### global describe, beforeEach, it ###
'use strict'
assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

describe 'node-cafe:connector generator', () ->
  before (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      helpers.run(path.join(__dirname, '../../generators/connector'))
      .withArguments('hi')
      .withOptions({
        'skip-install': true
      })
      .withPrompt({
        'name': 'myProject'
      })
      .on('end', () -> done())
    )

  it 'creates the expected source files', (done) ->
    assert.file([
      'src/connector/index.coffee'
    ])
    done()
