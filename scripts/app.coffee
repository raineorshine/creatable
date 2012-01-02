log = (msg) ->
	console.log(msg)
	msg

converter = new Markdown.Converter

# Convert Github Flavored Markdown to normal markdown
convertGFM = (mkd) ->
	indentMode = false
	lines = mkd.split("\n")
	newLines = for line in lines
		if line.startsWith("```")
			indentMode = !indentMode
			""
		else if indentMode
			"\t#{line}"
		else
			line
	newLines.join("\n")


build = () ->
	["#page", [
		["a#fork", { href: "https://github.com/RaineOrShine/creatable" }, [
			["img", { src: "https://a248.e.akamai.net/assets.github.com/img/7afbc8b248c68eb468279e8c17986ad46549fb71/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" }]
		]],
		["header", [
			["h1", "Creatable"],
			["h2.subtitle", "Pure Javascript client-side templating."]
		]],
		["#main", [
			buildAjaxModule({
				url:		"text/README.md"
				build:		(content) -> ["div", { html: true }, converter.makeHtml(convertGFM(content))]
				postBuild:	prettify
			})
		]],
		["footer ul", [
			["li", "Author: Raine Lourie"],
			["li", [
				"Github: ", ["a", { href: "http://github.com/RaineOrShine" }, "RaineOrShine"]
			]]
		]]
	]]

prettify = (el) ->
	$("code", el).wrap(create(["pre.prettyprint"]))
	prettyPrint()

$ ->
	Creatable.render(build())
