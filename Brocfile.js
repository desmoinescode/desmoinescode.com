module.exports = function(broccoli){
  var concat = require('broccoli-concat');
  var templateCompiler = require('broccoli-template-compiler');
  var pickFiles = require('broccoli-static-compiler');
  var filterCoffeeScript = require('broccoli-coffee');
  var lessCompiler = require('broccoli-less');

  function getEnv () {
    return process.env.BROCCOLI_ENV || 'development';
  }
  var env = getEnv();

  function getTestFile(env){
    if (env == 'test'){
      return 'mock';
    }
    else if (env == 'local'){
      return 'fixture';
    }
    else {
      return null;
    }
  }

  var testFile = getTestFile(env);
  var testFiles;
  if (testFile){
    var testTree = broccoli.makeTree('local');
    testFiles = concat(filterCoffeeScript(pickFiles(testTree, {
      srcDir: '',
      destDir: 'local',
      files: ['**/' + testFile + '_data.coffee']
    }), {
      bare: true
    }), {
      inputFiles: ['**/*.js'],
      outputFile: '/data.js'
    });

  }

  var sourceTree = broccoli.makeTree('src');
  var appJs = concat(filterCoffeeScript(pickFiles(sourceTree, {
    srcDir: '',
    destDir: 'app',
    files: ['**/*.coffee']
  }), {
    bare: true
  }), {
    inputFiles: ['**/*.js'],
    outputFile: '/app.js'
  });

  var testTree = broccoli.makeTree('tests');
  var testJs = concat(filterCoffeeScript(pickFiles(testTree, {
    srcDir: '',
    destDir: 'tests',
    files: ['*.coffee']
  }), {
    bare: true
  }), {
    inputFiles: ['**/*.js'],
    outputFile: '/tests.js'
  });

  var templates = concat(templateCompiler(pickFiles(sourceTree, {
    srcDir: '/templates',
    destDir: '/templates'
  })), {
    inputFiles: ['templates/*.js'],
    outputFile: '/templates.js'
  });

  var vendoredFiles = [
    'jquery/jquery.min.js',
    'handlebars/handlebars.js',
    'ember/ember.js',
    'ember-data-shim/ember-data.js',
    'bootstrap/js/bootstrap-collapse.js',
    'bootstrap/js/bootstrap-dropdown.js'
  ];
  if (env == 'test'){
      vendoredFiles.push('jquery-mockjax/jquery.mockjax.js')
  }
  var bowerTree = broccoli.makeTree('bower_components');
  var vendorJs = concat(bowerTree, {
    inputFiles: vendoredFiles,
    outputFile: '/vendor.min.js'
  });

  var cssTree = broccoli.makeTree('src/style')
  var allCSS = lessCompiler(cssTree, {
    paths: ['bower_components/bootstrap/less']
  });

  var return_trees = [vendorJs, appJs, templates, allCSS, testJs];
  if (testFiles){
    return_trees.push(testFiles);
  }

  return return_trees;
};
