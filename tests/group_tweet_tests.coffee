test "shows tweets on group details page", ->
  group_one =
    group:
      id: 1
      name: "Group One"
      tweets: [1, 2, 3, 4]

  stub_ajax 'GET', '/groups', groups: [ group_one ]
  stub_ajax 'GET', '/groups/1', group_one

  expected = [
    { id: 1, content: "tweet one", group_id: 1 }
    { id: 2, content: "tweet two", group_id: 1 }
    { id: 3, content: "tweet three", group_id: 1 }
    { id: 4, content: "tweet four", group_id: 1 }
  ]
  stub_ajax 'GET', '/tweets',
    tweets: expected

  visit('/group/1/').then ->
    for tweet, index in expected
      content = find(".tweets td:eq(#{index})").text()
      equal content, tweet.content, "'#{tweet.content}' != '#{content}'"
