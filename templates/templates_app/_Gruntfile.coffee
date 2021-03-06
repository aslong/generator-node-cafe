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
      upgrade_boot2docker:
        cmd: "boot2docker stop && curl http://static.dockerfiles.io/boot2docker-v1.0.1-virtualbox-guest-additions-v4.3.12.iso -o boot2docker.iso && sudo mv boot2docker.iso ~/.boot2docker/boot2docker.iso && boot2docker start"
      add_shared_folder:
        cmd: "boot2docker stop && VBoxManage sharedfolder add boot2docker-vm -name '<%= projectName %>Home' -hostpath $PWD && boot2docker start"
      remove_shared_folder:
        cmd: "boot2docker stop && VBoxManage sharedfolder remove boot2docker-vm -name '<%= projectName %>Home' && boot2docker start"
      build_box:
        cmd: "docker build -t='<%= projectName %>' ."
      start_box:
        cmd: "docker run -v $PWD:/usr/src/<%= projectName %> -t -i '<%= projectName %>' /bin/bash"
      test_coveralls:
        cmd: "mkdir -p ./coverage && JSCOV=1 <%= projectEnvName %>=test ./node_modules/mocha/bin/_mocha -R mocha-lcov-reporter > ./coverage/lcov.info && cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js && rm -rf ./coverage"
      test_coverage:
        cmd: "mkdir -p ./coverage && JSCOV=1 <%= projectEnvName %>=test ./node_modules/mocha/bin/_mocha --reporter html-cov > ./coverage/coverage.html && open ./coverage/coverage.html"
      start_service_local:
        cmd: "DEBUG=* <%= projectEnvName %>=local node ./bin/src/index.js"
      start_service_production:
        cmd: "DEBUG=* <%= projectEnvName %>=production node ./bin/src/index.js"
      build_bin:
        cmd: "mkdir -p bin"
      cp_static:
        cmd: "cp -rf src/static/ bin/src/static/"

    clean:
      build: ['bin/', 'coverage/']
      release: ['bin/', 'coverage/']

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
        env:
          <%= projectEnvName %>: 'test'
      unit: ['test/unit/**/*.coffee']
      perf: ['test/perf/**/*.coffee']
      integration: ['test/integration/**/*.coffee']

    watch:
      tdd:
        files: ['test/unit/**/*.coffee', 'test/perf/**/*.coffee', 'test/integration/**/*.coffee', 'src/**/*.coffee']
        tasks: 'test'
      unit:
        files: ['test/unit/**/*.coffee', 'src/**/*.coffee']
        tasks: 'test:unit'
      perf:
        files: ['test/perf/**/*.coffee', 'src/**/*.coffee']
        tasks: 'test:perf'
      integration:
        files: ['test/integration/**/*.coffee', 'src/**/*.coffee']
        tasks: 'test:integration'

  grunt.loadNpmTasks('grunt-bg-shell')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-jscoverage')
  grunt.loadNpmTasks('grunt-mocha-cli')

  grunt.registerTask('compile', ['clean', 'bgShell:build_bin', 'coffee:compile'])
  grunt.registerTask('build', ['compile', 'bgShell:cp_static'])

  grunt.registerTask('test', ['build', 'mochacli'])
  grunt.registerTask('test:unit', ['build', 'mochacli:unit'])
  grunt.registerTask('test:perf', ['build', 'mochacli:perf'])
  grunt.registerTask('test:integration', ['build', 'mochacli:integration'])
  grunt.registerTask('test:coveralls', ['build', 'jscoverage', 'bgShell:test_coveralls'])
  grunt.registerTask('test:coverage', ['build', 'jscoverage', 'bgShell:test_coverage'])

  grunt.registerTask('start', ['build', 'bgShell:start_service_local'])
  grunt.registerTask('start:local', ['build', 'bgShell:start_service_local'])
  grunt.registerTask('start:production', ['build', 'bgShell:start_service_production'])

  grunt.registerTask('docker', ['docker:upgrade_boot2docker', 'docker:init', 'docker:run'])
  grunt.registerTask('docker:upgrade_boot2docker', ['bgShell:upgrade_boot2docker'])
  grunt.registerTask('docker:add_shared_folder', ['bgShell:add_shared_folder'])
  grunt.registerTask('docker:init', ['docker:add_shared_folder', 'bgShell:build_box'])
  grunt.registerTask('docker:run', ['bgShell:start_box'])
  grunt.registerTask('docker:remove_shared_folder', ['bgShell:remove_shared_folder'])

  grunt.registerTask('init', ['docker:init'])
  grunt.registerTask('run', ['docker:run'])

  grunt.registerTask('prepublish', ['build'])
  grunt.registerTask('default', ['start'])
