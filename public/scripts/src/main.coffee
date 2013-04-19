RJS.installPrototypes()

# assert the top-level namespace and add client-side namespaces
if typeof client is undefined
  console.error "Expected the client namespace to be defined. This should be boostrapped from the server."
client.views = {}
client.partials = {}

###
Returns a function that, given some data, returns a new instance of the specified Backbone View constuctor with the data as its model.
Useful for mapping array data to fully-qualified backbone views:
e.g.
###
client.viewCreator = (View) ->
  (data) ->
    View["new"] model: new Backbone.Model(data)

$ ->
  
  # make sure the bootstrapped view matches a client-side Backbone View defined in client.views
  if not client.view of client.views
    console.error "Invalid view: '{0}'. This value must exactly match the name of a view function stored on client.views.".supplant([client.view])
  
  # instantiate the appropriate view, passing the bootstrapped data as the model
  view = new client.views[client.view](model: new Backbone.Model(client.data))
  
  # render the view
  Creatable.render view
