Create DOM Elements with nestable arrays that reflect the structure of HTML.

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
))
```

Results in...

```html
<div id="content">
	<h1 class="prominent">Blogs</h1>
	<ul>
		<li><a href="http://functionsource.com">FunctionSource</a></li>
		<li><a href="http://javascriptweblog.wordpress.com">Javascript, Javascript</a></li>
		<li><a href="http://ejohn.org/category/blog">John Resig</a></li>
	</ul>
</div>
```

It all happens with one function: **create**

```javascript
create([TAGNAME, ATTRIBUTES, CHILDREN/CONTENT]) // returns a native DOM element
create(["a", { href: "http://google.com" }, "Google"]);
```

Why?
===========
* Templating languages are awkward. Stay in the language you know and love instead of switching back-and-worth between HTML, Javascript, and your templating language.
* Properly formatted arguments reflect the actual structure of HTML.
* Implement view composition using familiar structures (functions!)
* Leverage existing Javascript skills directly in the view.

Features
===========

Specify ids and classes with css-syntax
-----------

```javascript
create(["div#footer", [
	["p.fine-print", "Don't forget to read this!"]
]])
```

```html
<div id="footer">
	<p class="fine-print">Don't forget to read this!</p>
</div>
```

Document Fragments
-----------

```javascript
create(["fragment", [
	["p", "First paragraph!!!"],
	["p", "Second paragraph!!!"],
	["p", "Third paragraph I'm bored"]
]]);
```

```html
<p>First paragraph!!!"</p>
<p>Second paragraph!!!"</p>
<p>Third paragraph I'm bored</p>
```

Highly compatible with underscore and functional programming
-----------

```javascript
var links = [
	{ url: "http://functionsource.com", label: "FunctionSource" },
	{ url: "http://javascriptweblog.wordpress.com", label: "Javascript, Javascript" },
	{ url: "http://ejohn.org/category/blog", label: "John Resig" }
];

var buildLinkItem = function(model) {
	return ["li", [
		["a", { href: model.url }, model.label]
	]];
};

create(["ul", _.map(links, buildLinkItem)])
```

```html
<ul>
	<li><a href="http://functionsource.com">FunctionSource</a></li>
	<li><a href="http://javascriptweblog.wordpress.com">Javascript, Javascript</a></li>
	<li><a href="http://ejohn.org/category/blog">John Resig</a></li>
</ul>
```

Unit Tests
-----------

**creatable** has full unit test coverage using qunit.

Installation
-----------

Include creatable.1.0.js in your HTML:

```html
<script src="creatable.1.0.js"></script>
```

If you want to avoid conflicts with the global 'create' function, comment out the last line of the source and use the namespaced version:

```javascript
Creatable.create(["input", { type: "button", value: "Go!" }])
```

