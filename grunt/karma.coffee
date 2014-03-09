module.exports =
  unit:
    options:
      basePath: '.'
      frameworks: ['qunit']
      files: [
        "dist/vendor.min.js"
        "dist/app.js"
        "dist/templates.js"
        "dist/data.js"
        "dist/tests.js"
      ]
      port: 9876
      runnerPort: 9100
      colors: true
      browsers: ['PhantomJS']
      captureTimeout: 60000
      singleRun: true
      autoWatch: false
      reporters: ['coverage', 'progress']
      preprocessors:
        "dist/*.js": "coverage"
      coverageReporter:
        type: "lcov"
        dir: 'coverage/'
      plugins: [
        'karma-coverage'
        'karma-qunit'
        'karma-chrome-launcher'
        'karma-phantomjs-launcher'
      ]
