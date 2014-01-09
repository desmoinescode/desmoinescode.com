test "shows 10 most recent messages from the mailing list on group details page", ->
  group_one =
    group:
      id: 1
      name: "Group One"
      posts: [1..10]

  stub_ajax 'GET', '/groups',
    groups: [
      group_one
    ]
  stub_ajax 'GET', '/groups/1', group_one

  expected = [
    { id: 1, title: "message one" }
    { id: 2, title: "message two" }
    { id: 3, title: "message three" }
    { id: 4, title: "message four" }
    { id: 5, title: "message five" }
    { id: 6, title: "message six" }
    { id: 7, title: "message seven" }
    { id: 8, title: "message eight" }
    { id: 9, title: "message nine" }
    { id: 10, title: "message ten" }
    { id: 11, title: "message eleven" }
  ]
  stub_ajax 'GET', '/posts',
    posts: expected

  Ember.run DSMCode, 'advanceReadiness'

  visit('/group/1/').then ->
    for post, index in expected
      if index < 10
        content = find(".posts td:eq(#{index})").text()
        equal content, post.title, "'#{content}' != '#{post.title}'"
