module.exports = (grunt) ->
  grunt.task.registerTask('test', ['shell:broccoli_test', 'karma'])
