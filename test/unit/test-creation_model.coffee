### global describe, beforeEach, it ###
'use strict'

assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

cafeHelpers = require('../helpers')

describe 'node-cafe:model generator', () ->
  it 'creates a model', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('model', 'Account', {}, {}, () ->
          assert.file([
            'src/models/Account.coffee'
          ])
          done()
        )
    );

  it 'creates a model with all tests', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('model', 'Account', { 'all-tests': true }, {}, () ->
          assert.file([
            'src/models/Account.coffee'
            'test/integration/models/Account.coffee'
            'test/perf/models/Account.coffee'
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );

  it 'creates a model with a unit test', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('model', 'Account', { 'unit-test': true }, {}, () ->
          assert.file([
            'src/models/Account.coffee'
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );
