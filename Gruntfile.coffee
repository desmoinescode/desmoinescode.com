module.exports = (grunt) ->

  require("load-grunt-config")(grunt)

  grunt.task.registerTask 'test', ['buildtest', 'karma']
  grunt.task.registerTask 'local', ['builddist', 'clean:local', 'concat:test', 'recess:bootstrap', 'connect']
  grunt.task.registerTask 'ci', ['test_coverage', 'test_uglified', 'coffeelint']

  grunt.task.registerTask 'basebuild', ['coffee', 'emberhandlebars', 'concat:dsmcode', 'concat:deps']
  grunt.task.registerTask 'builddist', ['clean:build', 'basebuild', 'uglify:deps', 'uglify:app']
  grunt.task.registerTask 'buildtest', ['clean:build', 'basebuild', 'concat:test']
  grunt.task.registerTask 'test_uglified', ['clean', 'builddist', 'concat:test', 'clean:ci', 'karma']
  grunt.task.registerTask 'test_coverage', ['test', 'coveralls']
