Write HTML in Javascript:

	document.body.appendChild(create(
		["#content", [
			["h1.prominent", "Blogs"],
			["ul", [
				["li", [
					["a", { href: "http://google.com" }, "FunctionSource"],
					["a", { href: "http://google.com" }, "Javascript, Javascript"],
					["a", { href: "http://google.com" }, "jQuery"],
					["a", { href: "http://google.com" }, "John Resig"]
				]]
			]]
		]]
	));
