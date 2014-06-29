module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    bgShell:
      _defaults:
        bg: false
        stdout: true
        stderr: true
        execOpts:
          maxBuffer: false
      test_coveralls:
        cmd: "JSCOV=1 NODE_ENV=test istanbul cover ./node_modules/mocha/bin/_mocha --report lcovonly -- -R spec test && cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js && rm -rf ./coverage"
      test_coverage:
        cmd: "JSCOV=1 mocha --reporter html-cov test > coverage.html && open coverage.html"
      start_service_local:
        cmd: "DEBUG=* APP_ENV=local node ./bin/src/index.js"
      start_service_production:
        cmd: "DEBUG=* APP_ENV=production node ./bin/src/index.js"
      build_bin:
        cmd: "mkdir bin"

    clean:
      build: ['bin/']
      release: ['bin/']

    coffee:
      compile:
        expand: true
        flatten: false
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'bin/src/'
        ext: '.js'

    jscoverage:
      src:
        expand: true,
        cwd:'bin/'
        src: ['**/*.js']
        dest: 'bin/coverage/'
        ext: '.js'

    mochacli:
      options:
        reporter: 'spec'
        bail: true
        #env:
      unit: ['test/unit/**/*.coffee']
      perf: ['test/perf/**/*.coffee']

    watch:
      tdd:
        files: ['test/unit/**/*.coffee', 'test/perf/**/*.coffee', 'src/**/*.coffee']
        tasks: 'test'
      unit:
        files: ['test/unit/**/*.coffee', 'src/**/*.coffee']
        tasks: 'test:unit'
      perf:
        files: ['test/perf/**/*.coffee', 'src/**/*.coffee']
        tasks: 'test:perf'

  grunt.loadNpmTasks('grunt-bg-shell')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-jscoverage')
  grunt.loadNpmTasks('grunt-mocha-cli')

  grunt.registerTask('compile', ['clean', 'bgShell:build_bin', 'coffee:compile'])
  grunt.registerTask('build', ['compile'])

  grunt.registerTask('test', ['build', 'mochacli'])
  grunt.registerTask('test:unit', ['build', 'mochacli:unit'])
  grunt.registerTask('test:perf', ['build', 'mochacli:perf'])
  grunt.registerTask('test:coveralls', ['build', 'jscoverage', 'bgShell:test_coveralls'])
  grunt.registerTask('test:coverage', ['build', 'jscoverage', 'bgShell:test_coverage'])

  grunt.registerTask('start', ['build', 'bgShell:start_service_local'])
  grunt.registerTask('start:local', ['build', 'bgShell:start_service_local'])
  grunt.registerTask('start:production', ['build', 'bgShell:start_service_production'])

  grunt.registerTask('prepublish', ['build'])
  grunt.registerTask('default', ['start'])
