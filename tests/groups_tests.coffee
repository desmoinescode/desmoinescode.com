test "shows list of user groups", ->
  expected = [
    { id: 1, name: "Group One", },
    { id: 2, name: "Group Two", },
    { id: 3, name: "Group Three"}
  ]
  stub_ajax 'GET', '/groups',
    groups: expected

  visit('/').then ->
    for group, index in expected
      group_one  = find(".groups li:eq(#{index})").text()
      equal group_one, group.name, "'#{group_one}' != '#{group.name}'"

test "shows correct title", ->
  stub_ajax 'GET', '/groups',
    groups: []

  visit('/').then ->
    value = find('.brand').text()
    equal value, 'Des Moines Code', "'#{value}' is wrong"
    value = find('.groups li:eq(0)').text()
    equal value, '', "Element should not have existed but was '#{value}'"

test "has links to each group", ->
  stub_ajax 'GET', '/groups',
    groups: [
      { id: 1, name: "Group One", }
      { id: 2, name: "Group Two", }
    ]

  visit('/').then ->
    equal 2, find('.group-link').length, "Missing group links"

    group_one_text = find('.group-link[href*="/group/1"]').text()
    equal "Group One", group_one_text, "Group One link text missing, found '#{group_one_text}'"

    group_two_text = find('.group-link[href*="/group/2"]').text()
    equal "Group Two", group_two_text, "Group Two link text missing, found '#{group_two_text}'"
