module.exports = function(broccoli){
  var concat = require('broccoli-concat');
  var templateCompiler = require('broccoli-template-compiler');
  var pickFiles = require('broccoli-static-compiler');
  var filterCoffeeScript = require('broccoli-coffee');
  var lessCompiler = require('broccoli-less');

  var sourceTree = broccoli.makeTree('src');

  var testTree = broccoli.makeTree('local');

  var xJs = concat(filterCoffeeScript(pickFiles(testTree, {
    srcDir: '',
    destDir: 'local',
    files: ['**/fixture*.coffee']
  }), {
    bare: true
  }), {
    inputFiles: ['**/*.js'],
    outputFile: '/data.js'
  });

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

  var templates = concat(templateCompiler(pickFiles(sourceTree, {
    srcDir: '/templates',
    destDir: '/templates'
  })), {
    inputFiles: ['templates/*.js'],
    outputFile: '/templates.js'
  });

  var bowerTree = broccoli.makeTree('bower_components');
  var vendorJs = concat(bowerTree, {
    inputFiles: [
      'jquery/jquery.min.js',
      'handlebars/handlebars.js',
      'ember/ember.js',
      'ember-data-shim/ember-data.js',
      'bootstrap/js/bootstrap-collapse.js',
      'bootstrap/js/bootstrap-dropdown.js'
    ],
    outputFile: '/vendor.min.js'
  });

  var cssTree = broccoli.makeTree('src/style')
  var allCSS = lessCompiler(cssTree, {
    paths: ['bower_components/bootstrap/less']
  });

  return [vendorJs, appJs, templates, xJs, allCSS];
};
