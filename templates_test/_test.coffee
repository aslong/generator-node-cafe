### global describe, beforeEach, it ###
'use strict'
{ requireCoverage } = require("../../helpers")

debug       = require('debug')('<%= projectName %>:test:<%= testType %>:<%= name %>')
<%= name %> = requireCoverage("src/<%= componentTesting %>/<%= name %>")

describe '<%= name %>', () ->
  it 'passes', (done) ->
    done()
