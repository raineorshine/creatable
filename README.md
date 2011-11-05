Write HTML in pure Javascript:

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

Produces this:

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

It all happens with one function: create

```javascript
create(TAGNAME, ATTRIBUTES, CHILDREN/CONTENT)
```
