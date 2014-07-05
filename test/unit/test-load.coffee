### global describe, beforeEach, it ###
'use strict'
{ requireCoverage } = require('../helpers')

assert    = require('assert')
app       = requireCoverage("app")
connector = requireCoverage("connector")
test      = requireCoverage("test")

describe 'node-cafe generator', () ->
  it 'can be imported without blowing up', () ->
    assert(app?)

describe 'node-cafe:connector generator', () ->
  it 'can be imported without blowing up', () ->
    assert(connector?)

describe 'node-cafe:test generator', () ->
  it 'can be imported without blowing up', () ->
    assert(test?)
