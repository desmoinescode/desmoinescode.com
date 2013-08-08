DSMCode = Ember.Application.create
  rootElement: '#ember-app'

DSMCode.Store = DS.Store.extend
    adapter: 'DS.FixtureAdapter'

DSMCode.Router.map ->
  this.resource("groups", { path: "/"})

DSMCode.Group = DS.Model.extend
  name: DS.attr('string')

DSMCode.GroupsRoute = Ember.Route.extend
  model: ->
    DSMCode.Group.find()

DSMCode.Group.FIXTURES = [{id: 1, name: 'first'}, {id: 2, name: 'last'}]
