/*global describe, beforeEach, it */
'use strict';
var path = require('path');
var assert = require('yeoman-generator').assert;
var helpers = require('yeoman-generator').test;

describe('node-cafe generator', function () {
  before(function (done) {
    helpers.run(path.join(__dirname, '../generators/app'))
    .inDir(path.join(__dirname, './temp'))
    .withOptions({
      'skip-install': true
    })
    .withPrompt({
      'someOption': true
    })
    .onEnd(function () { done(); });
  });

  it('creates the expected config files', function (done) {
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
  });

  it('creates the expected test files', function (done) {
    assert.file([
      'test/mocha.opts',
      'test/unit/index.coffee',
      'test/perf/index.coffee',
    ])
    done()
  });

  it('creates the expected source files', function (done) {
    assert.file([
      'src/index.coffee'
    ])
    done()
  });

  it('creates expected project files', function (done) {
    assert.file([
      'README.md'
    ]);
    done()
  });
});
