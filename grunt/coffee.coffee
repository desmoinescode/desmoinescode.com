module.exports =
  options:
    bare: true
  compile:
    files:
      'build/app.js': 'src/**/*.coffee'
      'build/localdata.js': 'local/fixture_data.coffee'
      'tests/build/tests.js': [
         'tests/helper.coffee',
         'tests/*tests.coffee'
      ]
