'use strict';
var util   = require('util');
var path   = require('path');
var yeoman = require('yeoman-generator');
var yosay  = require('yosay');
var chalk  = require('chalk');

var NodeCafeGenerator = yeoman.generators.Base.extend({
  initializing: {
    init: function () {
      this.pkg = require('../../package.json');
    }
  },

  prompting: {
    askFor: function () {
      var done = this.async();

      // Have Yeoman greet the user.
      this.log(yosay('Welcome to the marvelous NodeCafe generator!'));

      var prompts = [{
        type: 'confirm',
        name: 'someOption',
        message: 'Would you like to enable this option?',
        default: true
      }];

      this.prompt(prompts, function (props) {
        this.someOption = props.someOption;

        done();
      }.bind(this));
    }
  },

  configuring: {
    projectConfigFiles: function () {
      this.copy('editorconfig', '.editorconfig');
      this.copy('jshintrc', '.jshintrc');
      this.copy('gitignore', '.gitignore');
      this.copy('_README.md', 'README.md');

      this.copy('_package.json', 'package.json');
      this.copy('_bower.json', 'bower.json');
      this.copy('_Gruntfile.coffee', 'Gruntfile.coffee');
      this.copy('_Dockerfile', 'Dockerfile');
    }
  },

  //default: {
  //},

  writing: {
    app: function () {
      this.mkdir('src');
      this.copy('_index.coffee', 'src/index.coffee');
    },

    test: function () {
      this.mkdir('test');
      this.copy('_mocha.opts', 'test/mocha.opts');
      this.mkdir('test/unit');
      this.copy('_unit_test_index.coffee', 'test/unit/index.coffee');
      this.mkdir('test/perf');
      this.copy('_perf_test_index.coffee', 'test/perf/index.coffee');
    }
  },

  install: {
    installDependencies: function () {
      if (!this.options['skip-install']) {
        this.installDependencies();
      }
    }
  }

  //end: {
  //}

});

module.exports = NodeCafeGenerator;
