### global describe, beforeEach, it ###
'use strict'
useCoverage = "/"
useCoverage = "/bin/coverage-" if process.env.JSCOV

app    = require("../..#{useCoverage}generators/app")
assert = require('assert')

describe 'node-cafe generator', () ->
  it 'can be imported without blowing up', () ->
    assert(app?)
