### global describe, beforeEach, it ###
'use strict'
{ requireCoverage } = require("../../helpers")

debug       = require('debug')('<%= projectName %>:test:<%= testType %>:<%= componentTestingPath %>:<%= name %>')
<%= name %> = requireCoverage("src/<%= componentTestingPath %>/<%= name %>")

describe '<%= name %> <%= componentTesting %>', () ->
  it 'passes', (done) ->
    done()
