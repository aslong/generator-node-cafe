### global describe, beforeEach, it ###
'use strict'
assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

describe 'node-cafe generator', () ->
  before (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      helpers.run(path.join(__dirname, '../../generators/test'))
      .withArguments('hi')
      .withOptions({
        'skip-install': true
      })
      .withPrompt({
        'name': 'myProject'
      })
      .on('end', () -> done())
    );

  it 'passes', (done) ->
    done()
