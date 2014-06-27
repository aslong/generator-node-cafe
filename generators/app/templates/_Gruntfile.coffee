module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    clean:
      build: 'bin/'

    coffee:
      compile:
        expand: true
        flatten: false
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'bin/src/'
        ext: '.js'

    bgShell:
      _defaults:
        bg: false
      start_service_local:
        cmd: "DEBUG=* APP_ENV=local node ./bin/src/index.js"
        options:
          stdout: true
          stderr: true
          execOpts:
            maxBuffer: false
      start_service_production:
        cmd: "DEBUG=* APP_ENV=production node ./bin/src/index.js"
        options:
          stdout: true
          stderr: true
          execOpts:
            maxBuffer: false

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
  grunt.loadNpmTasks('grunt-mocha-cli')

  grunt.registerTask('test', ['mochacli'])
  grunt.registerTask('test:unit', ['mochacli:unit'])
  grunt.registerTask('test:perf', ['mochacli:perf'])

  grunt.registerTask('start', ['coffee:compile', 'bgShell:start_service_local'])
  grunt.registerTask('start:local', ['coffee:compile', 'bgShell:start_service_local'])
  grunt.registerTask('start:production', ['coffee:compile', 'bgShell:start_service_production'])
  grunt.registerTask('restart', ['clean', 'coffee:compile', 'bgShell:start_service_local'])
  grunt.registerTask('restart:local', ['clean', 'coffee:compile', 'bgShell:start_service_local'])
  grunt.registerTask('restart:production', ['clean', 'coffee:compile', 'bgShell:start_service_production'])
  grunt.registerTask('default', ['start'])
