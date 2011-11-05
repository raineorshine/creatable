Write HTML in Javascript:
```javascript
document.body.appendChild(create(
	["#content", [
		["h1.prominent", "Blogs"],
		["ul", [
			["li", [
				["a", { href: "http://functionsource.com" }, "FunctionSource"]
			]],
			["li", [
				["a", { href: "http://javascriptweblog.wordpress.com" }, "Javascript, Javascript"]
			]],
			["li", [
				["a", { href: "http://ejohn.org/category/blog" }, "John Resig"]
			]]
		]]
	]]
));
```
