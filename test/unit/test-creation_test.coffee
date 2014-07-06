### global describe, beforeEach, it ###
'use strict'

assert  = require('yeoman-generator').assert
path    = require('path')
helpers = require('yeoman-generator').test

cafeHelpers = require('../helpers')

describe 'node-cafe:test generator', () ->
  it 'creates a unit test for a model', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('test', 'model Account', { }, {}, () ->
          assert.file([
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );

  it 'creates a perf test for a model', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('test', 'model Account', { 'unit': false, 'perf': true }, {}, () ->
          assert.file([
            'test/perf/models/Account.coffee'
          ])
          assert.noFile([
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );

  it 'creates an integration test for a model', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('test', 'model Account', { 'unit': false, 'integration': true }, {}, () ->
          assert.file([
            'test/integration/models/Account.coffee'
          ])
          assert.noFile([
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );

  it 'creates all tests for a model', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('test', 'model Account', { 'perf': true, 'integration': true }, {}, () ->
          assert.file([
            'test/integration/models/Account.coffee'
            'test/perf/models/Account.coffee'
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );

  it 'creates all tests for a model when the test type is plural', (done) ->
    helpers.testDirectory(path.join(__dirname, '../../bin/test/temp'), () ->
      cafeHelpers.runDefaultGenerator () ->
        cafeHelpers.runGenerator('test', 'models Account', { 'perf': true, 'integration': true }, {}, () ->
          assert.file([
            'test/integration/models/Account.coffee'
            'test/perf/models/Account.coffee'
            'test/unit/models/Account.coffee'
          ])
          done()
        )
    );
