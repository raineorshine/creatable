Create DOM Elements with nestable arrays that reflect the structure of HTML:

```javascript
document.body.appendChild(create(
	["#content", [
		["h1.prominent", "Blogs"],
		["ul", [
			["li a", { href: "http://functionsource.com" }, "FunctionSource"],
			["li a", { href: "http://javascriptweblog.wordpress.com" }, "Javascript, Javascript"],
			["li a", { href: "http://ejohn.org/category/blog" }, "John Resig"]
		]]
	]]
))
```

Results in:

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
create([TAGNAME, ATTRIBUTES, CHILDREN|CONTENT]) // returns a native DOM element
create(["a", { href: "http://google.com" }, "Google"]);
```

Why?
===========
* Switching in and out of Javascript and whatever templating language you use is ugly.
* No special templating language syntax. 100% pure Javascript.
* Implement view composition using plain, old functions.
* Properly formatted input still reflects the actual structure of HTML for readability.

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

Arguments that resolve to null or undefined are ignored
-----------

```javascript
var showOptions = false;
create(["div", [
	showOptions ? ["a", { href: "/options" }, "Options"] : null,
	["p", "I think you've run out of options."]
]]);
```

```html
<div>
	<p>I think you've run out of options.</p>
</div>
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

Built-in support for jQuery elements
-----------
```javascript
create(["#myModule", [
	["h1", "This is a header"],
	"Some text.",
	$("<div><p>Go, Go jQuery</p></div>")
]])
```

```html
<div id="myModule">
	<h1>This is a header</h1>
	Some text.
	<div><p>Go, Go jQuery</p></div>
</div>
```

Unit Tests
===========

**creatable** has full [unit test coverage](https://github.com/RaineOrShine/creatable/tree/master/test) using qunit.

Installation
===========

Just include creatable.js in your HTML:

```html
<script src="creatable.js"></script>
```

Todo
===========
* Make it easy to sub out the rendering function to return a string of HTML instead of DOM nodes

