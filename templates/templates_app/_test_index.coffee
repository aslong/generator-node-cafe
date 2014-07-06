{ requireCoverage } = require("../helpers")

debug = require('debug')('<%= projectName %>:test:<%= testType %>:index', 'DEBUG')
index = requireCoverage("src/index")

describe 'test', () ->
  it 'passes', (done) ->
    done()
