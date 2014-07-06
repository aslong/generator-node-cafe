module.exports =
  getCoveragePath: () ->
    useCoverage = "/"
    useCoverage = "/bin/coverage/" if process.env.JSCOV
    return "../../#{useCoverage}/"

  requireCoverage: (moduleName) ->
    return require("#{module.exports.getCoveragePath()}#{moduleName}")
