test "shows group website", ->
  stub_ajax 'GET', '/groups', groups: [
    id: 1
    name: "Group One"
    website: 'http://groupone.com'
  ]

  visit('/group/1/').then ->
    text = find(".website[href*='http://groupone.com']").text()
    equal text, "Website", "'#{text}' was website link text"

test "does not show website link when not configured", ->
  group_one =
    group:
      id: 1
      website: ''

  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  visit('/group/1/').then ->
    equal 0, !!find(".website").length, "Website link should not have existed"

test "shows group twitter handle and url", ->
  group_one =
    group:
      id: 1
      twitter_handle: 'group_one'

  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  visit('/group/1/').then ->
    text = find(".twitter[href*='http://twitter.com/group_one']").text()
    equal text, "Twitter", "'#{text}' was twitter link text"

test "does not show twitter link when not configured", ->
  group_one =
    group:
      id: 1
      twitter: ''
  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  visit('/group/1/').then ->
    equal 0, !!find(".twitter").length, "Twitter link should not have existed"

test "shows group google group link", ->
  group_one =
    group:
      id: 1
      google_group: 'group_one'
  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  visit('/group/1/').then ->
    text = find(".google-group[href*='https://groups.google.com/forum/#!/forum/group_one']").text()
    equal text, "Google Group", "'#{text}' was google group link text"

test "does not show google group link when not configured", ->
  group_one =
    group:
      id: 1
      google_group: ''
  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  visit('/group/1/').then ->
    equal 0, !!find(".google-group").length, "Google Group link should not have existed"

test "shows facebook link", ->
  group_one =
    group:
      id: 1
      facebook: 'http://facebook.com/group_one'
  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  visit('/group/1/').then ->
    text = find(".facebook[href*='http://facebook.com/group_one']").text()
    equal text, "Facebook", "'#{text}' was facebook link text"

test "does not show facebook link when not configured", ->
  group_one =
    group:
      id: 1
      facebook: ''
  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  visit('/group/1/').then ->
    equal 0, !!find(".facebook").length, "facebook link should not have existed"
