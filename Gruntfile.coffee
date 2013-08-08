module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-ember-template-compiler'
  grunt.loadNpmTasks 'grunt-karma'

  grunt.initConfig
    karma:
      unit:
        configFile: 'karma.conf.js'
    connect:
      server:
        options:
          port: 9000
          base: '.'
          keepalive: true
    coffee:
      options:
        bare: true
      compile:
        files:
          'src/lib/app.min.js': 'src/*.coffee'
          'src/lib/tests.min.js': 'tests/*.coffee'
    emberhandlebars:
      compile:
        options:
          templateName: (sourceFile) ->
            newSource = sourceFile.replace 'src/templates/', ''
            newSource.replace '.handlebars', ''
        files: [
          'src/templates/*.handlebars'
        ]
        dest: 'src/lib/tmpl.min.js'
    concat:
      dist:
        src: [
          'src/jquery-1.9.1.js'
          'src/handlebars-1.0.0-rc.4.js'
          'src/ember.js'
          'src/ember-data.js'
        ]
        dest: 'src/lib/deps.min.js'
      test:
        src: [
          'src/jquery-1.9.1.js'
          'src/handlebars-1.0.0-rc.4.js'
          'src/ember.js'
          'src/ember-data.js'
        ]
        dest: 'src/lib/deps.min.js'

  grunt.task.registerTask 'builddist', ['concat:dist', 'coffee', 'emberhandlebars']
  grunt.task.registerTask 'buildtest', ['concat:test', 'coffee', 'emberhandlebars']
  grunt.task.registerTask 'local', ['builddist', 'connect']
  grunt.task.registerTask 'test', ['buildtest', 'karma']
  grunt.task.registerTask 'travis', ['test']
