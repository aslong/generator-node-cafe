### global describe, beforeEach, it ###
'use strict'

assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

cafeHelpers = require('../helpers')

describe 'node-cafe test generator', () ->
  it 'creates a unit test for a model', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('test', 'model Account', {}, {}, () ->
          assert.file([
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );
