coverage = "../../bin/"
coverage = "../../bin/coverage/" if process.env.JSCOV

debug = require('debug')('app:test:unit:index', 'DEBUG')
index = require("#{coverage}src/index")

describe 'test', () ->
  it 'passes', (done) ->
    done()
