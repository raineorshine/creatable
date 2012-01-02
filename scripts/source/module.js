/* requires: underscore */

var buildAjaxModule = (function() {
	var moduleRequestCache = {};

	/** Makes an ajax request to the given module url and returns a placeholder module div. When the ajax request returns a response, the placeholder is filled with the results of the given build function (which takes the module response data). 
		@param args {
			url
			data
			build
			postBuild
			errorBuild
			loadingContent
		}
	*/
	return function(args) {

		// defaults
		args = _.extend({
			url: "/",
			data: {},
			build: function() {},
			postBuild: function() {},
			errorBuild: function() {},
			loadingContent: "Loading..."
		}, args);

		var moduleId = RJS.guid();
		var requestKey = "{0}|{1}".supplant([args.url, RJS.hash(args.data)]);

		var moduleMarkup = ["span.module", { id: moduleId }, RJS.callTillValue(args.loadingContent)];

		var fromCache = undefined;
		if(args.xhr) {
			moduleRequestCache[requestKey] = args.xhr;
		}
		else {
			fromCache = requestKey in moduleRequestCache;
			if(!fromCache) {
				moduleRequestCache[requestKey] = $.ajax({
					url: args.url,
					data: args.data
				});
			}
		}

		moduleRequestCache[requestKey].always(function(response, textStatus, jqxhr) {

			var moduleEl = $("#" + moduleId)
				.data({ args: args })
				.empty();

			var build = textStatus == "success" ? args.build : args.errorBuild;
			moduleMarkup = build(response, args.data, fromCache);

			// this is a weird line because we have closure over moduleMarkup, but if this 'complete' callback is not called immediately (that is, the response is not cached), then moduleMarkup doesn't have any other effect, but if it is called immediately, we simply return the built module instead of the placeholder
			moduleEl.html(create(moduleMarkup));

			if(textStatus == "success") {
				args.postBuild(moduleEl);
			}
		});

		return moduleMarkup;
	}
})();
