var lambdinate = function(oldMappingFunction) {
	return function(list, iterator, context) {
		return oldMappingFunction(list, typeof iterator == "string" ? iterator.lambda() : iterator, context);
	};
};

_.map = lambdinate(_.map);
_.each = lambdinate(_.each);
