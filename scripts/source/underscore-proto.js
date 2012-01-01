/** Installs array, collection, and function methods from UndescoreJS to the Array prototype for more elegant syntax. 
	@see		http://documentcloud.github.com/underscore
	@requires	rjs-2.0.js, underscore.js
	@remarks	Includes all array and collection functions except: intersection, union, zip, range, toArray
*/

RJS.install(Array, _, ["first", "rest", "last", "compact", "flatten", "without", "difference", "uniq", "indexOf", "lastIndexOf", "each", "map", "reduce", "reduceRight", "detect", "select", "reject", "all", "any", "include", "invoke", "pluck", "max", "min", "sortBy", "groupBy", "sortedIndex", "size", "head", "tail", "unique", "forEach", "inject", "foldl", "foldr", "filter", "every", "some", "contains"]);
RJS.install(Function, _, ["bind", "memoize", "delay", "defer", "throttle", "debounce", "once", "wrap", "compose"]);
RJS.install(Function, _, ["after"], -1);

