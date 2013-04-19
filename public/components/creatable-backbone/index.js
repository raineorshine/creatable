/** Add support for Backbone Views to Creatable's rendering pipeline. */

/** Extend Backbone.View with a default render function that relies on build() to produce an s-exp representing the view. */
Backbone.View = Backbone.View.extend({

	render: function() {
		var that = this;
		var el = $(Creatable.create(this.build()));
		$(this.el)
			.empty()
			.append(el)
			.fadeIn();

		setTimeout(function() {
			that.trigger("render", el);
		}, 0);

		return this;
	},

	build: function() {
		return null;
	},
});

/** Extend Creatable to support Backbone Views. */
Creatable.types.push({
	isOfType: function(obj) { return obj instanceof Backbone.View; },
	build: 	  function(obj) { return obj.render().el; }
});
