### global describe, beforeEach, it ###
'use strict'
{ requireCoverage } = require('../helpers')

assert    = require('assert')
app       = requireCoverage("app")
connector = requireCoverage("connector")
model     = requireCoverage("model")
test      = requireCoverage("test")

describe 'node-cafe generator', () ->
  it 'can be imported without blowing up', () ->
    assert(app?)

describe 'node-cafe:connector generator', () ->
  it 'can be imported without blowing up', () ->
    assert(connector?)

describe 'node-cafe:model generator', () ->
  it 'can be imported without blowing up', () ->
    assert(model?)

describe 'node-cafe:test generator', () ->
  it 'can be imported without blowing up', () ->
    assert(test?)
