### global describe, beforeEach, it ###
'use strict'
useCoverage = "/"
useCoverage = "/bin/coverage-" if process.env.JSCOV

app       = require("../..#{useCoverage}generators/app")
assert    = require('assert')
connector = require("../..#{useCoverage}generators/connector")
test      = require("../..#{useCoverage}generators/test")

describe 'node-cafe generator', () ->
  it 'can be imported without blowing up', () ->
    assert(app?)

describe 'node-cafe:connector generator', () ->
  it 'can be imported without blowing up', () ->
    assert(connector?)

describe 'node-cafe:test generator', () ->
  it 'can be imported without blowing up', () ->
    assert(test?)
