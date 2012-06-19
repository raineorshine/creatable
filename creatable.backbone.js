/** Backbone extension to Creatable. 
	@requires BackboneJS
	@requires jquery.livequery.js
	@requires functional
*/

/** Extend Backbone.View with some base functionality. */
Backbone.View = Backbone.View.extend({
	// Override render to use build() to produce a markup array that Creatable can consume.
	render: function() {
		el = $(create(this.build()));
		el.fadeIn();
		$(this.el).empty().append(el);
		this.trigger("rendered");
		return this;
	},

	build: function() {
		return null;
	},
});

/** Extend Creatable to support Backbone Views. */
Creatable.types.push({
	isOfType: function(obj) { return obj instanceof Backbone.View; },
	build: function(obj) { return obj.render().el; }
});
