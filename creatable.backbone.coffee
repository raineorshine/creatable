###
Add support for Backbone Views to Creatable's rendering pipeline.
###

###
Extend Backbone.View with a default render function that relies on build() to produce an s-exp representing the view.
###
Backbone.View = Backbone.View.extend(
  render: ->
    that = this
    el = $(Creatable.create(@build()))
    $(@el).empty().append(el).fadeIn()
    setTimeout (->
      that.trigger "render", el
    ), 0
    this

  build: ->
    null
)

###
Extend Creatable to support Backbone Views.
###
Creatable.types.push
  isOfType: (o) -> o instanceof Backbone.View
  build: (o) -> o.render().el
