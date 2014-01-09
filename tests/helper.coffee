document.write '
<div id="ember-app"></div>
<div id="ember-testing-container">
  <div id="ember-testing"></div>
</div>'
Ember.testing = true
DSMCode.rootElement = '#ember-testing'
DSMCode.setupForTesting()
DSMCode.injectTestHelpers()

jQuery.mockjaxSettings.logging = false
jQuery.mockjaxSettings.responseTime = 0

stub_ajax = (verb, url, json, status=200) ->
  jQuery.mockjax
    type: verb
    url: url
    status: status
    dataType: "json"
    responseText: json

module 'DSMCodeTests',
  setup: ->
    Ember.run ->
      DSMCode.reset()
  teardown: ->
    $.mockjaxClear()
