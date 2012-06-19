/** Returns a function that returns 0 the first time it is called, then 1, 2, 3, etc. */
var iter = function() { 
	var count = 0; 
	return function() { 
		return count++; 
	} 
};

var renderPluginKey = "creatable-plugin-render-";
var renderPluginIter = iter();

Creatable.plugins.render = function(el, f) {
	var id = renderPluginKey + renderPluginIter();
	Creatable.addClass(el, id);
	$("." + id).livequery(function() { typeof f == "string" ? f.lambda()(this) : f(this); });
};
