(function() {

	var reluctantArray = function() {
		var output = [];
		for(var i=0; i<arguments.length; i++) {
			if(arguments[i] !== undefined) {
				output.push(arguments[i]);
			}
		}
		return output;
	};

	Array.prototype.hasClass = function(className) {
		var selectorClassString = Creatable.parseSelectorAttributes(this[0])["class"];
		return (!!this[1] && this[1]["class"] && Creatable.containsClass(this[1]["class"], className) ||
				Creatable.containsClass(selectorClassString, className));
	};


	Array.prototype.addClass = function(className) {

		// copy the attributes to a new object
		var attrs = {};
		for(var name in (this[1] || {})) {
			attrs[name] = this[1][name];
		}

		// add the class if it doesn't exist
		if(!this.hasClass(className)) {
			attrs["class"] = !attrs["class"] ? 
				className : 
				attrs["class"] + " " + className;
		}

		return reluctantArray(this[0], attrs, this[2]);
	};

	Array.prototype.removeClass = function(className) {

		// copy the attributes to a new object
		var attrs = {};
		for(var name in (this[1] || {})) {
			attrs[name] = this[1][name];
		}

		// remove the class if it exists
		if(Creatable.containsClass(attrs["class"], className)) {
			attrs["class"] = (" " + attrs["class"] + " ").replace(" " + className + " ", " ").trim();
		}

		// delete class attribute if empty
		if(attrs["class"] === "") {
			delete attrs["class"];
		}

		return reluctantArray(this[0], attrs, this[2]);
	};

	Array.prototype.markFirst = function() {
		return reluctantArray(this[0], this[1], 
			this[2] === undefined ? undefined : 
			this[2].length === 0 ? [] : 
				[].concat(
					[this[2][0].addClass("first")],
					this[2].slice(1)
				));
	};

	Array.prototype.markLast = function() {
		return reluctantArray(this[0], this[1], 
			this[2] === undefined ? undefined : 
			this[2].length === 0 ? [] : 
				[].concat(
					this[2].slice(0, this[2].length-1),
					[this[2][this[2].length-1].addClass("last")]
				));
	};

	Array.prototype.markFirstLast = function() {
		return this.markFirst().markLast();
	};

})();
