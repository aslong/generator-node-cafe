(function() {
  'use strict';
  var NodeCafeGenerator, chalk, path, util, yeoman, yosay,
    _this = this;

  chalk = require('chalk');

  path = require('path');

  util = require('util');

  yeoman = require('yeoman-generator');

  yosay = require('yosay');

  module.exports = NodeCafeGenerator = yeoman.generators.Base.extend({
    initializing: {
      init: function() {
        return _this.pkg = require('../../package.json');
      }
    },
    prompting: {
      askFor: function() {
        var done, prompts,
          _this = this;
        done = this.async();
        this.log(yosay('Welcome to the marvelous NodeCafe generator!'));
        prompts = [
          {
            type: 'confirm',
            name: 'someOption',
            message: 'Would you like to enable this option?',
            "default": true
          }
        ];
        return this.prompt(prompts, function(props) {
          _this.someOption = props.someOption;
          return done();
        });
      }
    },
    configuring: {
      projectConfigFiles: function() {
        this.copy('editorconfig', '.editorconfig');
        this.copy('jshintrc', '.jshintrc');
        this.copy('gitignore', '.gitignore');
        this.copy('_README.md', 'README.md');
        this.copy('_package.json', 'package.json');
        this.copy('_bower.json', 'bower.json');
        this.copy('_Gruntfile.coffee', 'Gruntfile.coffee');
        return this.copy('_Dockerfile', 'Dockerfile');
      }
    },
    writing: {
      app: function() {
        this.mkdir('src');
        return this.copy('_index.coffee', 'src/index.coffee');
      },
      test: function() {
        this.mkdir('test');
        this.copy('_mocha.opts', 'test/mocha.opts');
        this.mkdir('test/unit');
        this.copy('_unit_test_index.coffee', 'test/unit/index.coffee');
        this.mkdir('test/perf');
        return this.copy('_perf_test_index.coffee', 'test/perf/index.coffee');
      }
    },
    install: {
      installDependencies: function() {
        if (!this.options['skip-install']) {
          return this.installDependencies();
        }
      }
    }
  });

}).call(this);
