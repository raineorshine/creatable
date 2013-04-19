###
Elegant HTML generation. No templating. Just Javascript.
@author Raine Lourie
@note Created independently from JsonML (http://jsonml.org).
###

###
DOM Emulation
###

# Emulated TextNode
class TextNode
  constructor: (@textContent)->
    @nodeType = 3
  toString: -> @textContent

# Emulated Document Fragment
class DocumentFragment
  constructor: -> 
    @nodeType = 11
    @children = []

  appendChild: (child) ->
    @firstChild = child if @children.length is 0
    @children.push child

  toString: ->
    output = ""
    i = 0

    while i < @children.length
      output += @children[i].toString()
      i++
    output

# Emulated Element
class Element
  constructor: (@tagName) ->
    @attributes = {}
    @children = []
    @nodeType = 1

  hasAttribute: (attrName) ->
    attrName of @attributes

  getAttribute: (name) ->
    @attributes[name]

  setAttribute: (name, value) ->
    @attributes[name] = value
    value

  removeChild: (child) ->
    console.error "Not implemented."

  appendChild: (child) ->
    @firstChild = child  if @children.length is 0
    @children.push child

  toString: ->
    
    # opening tag
    output = "<" + @tagName
    
    # attributes
    for attr of @attributes
      output += " " + attr + "=\"" + @attributes[attr] + "\""
    
    # end opening tag
    output += ">"
    
    # children
    i = 0

    while i < @children.length
      output += @children[i].toString()
      i++
    
    # closing tag
    output += "</" + @tagName + ">"
    output

### 
A lightweight emulation of the document object. Can be used to render creatable markup as an HTML string instead of a DOM node.
###
emulatedDocument =
  createTextNode: (content) ->
    new TextNode(content)

  createDocumentFragment: ->
    new DocumentFragment()

  createElement: (tagName) ->
    new Element(tagName)

  body: new Element("body")
  toString: ->
    @body.toString()

document = @document || emulatedDocument

setDocument = (doc)->
  document = doc

setEmulatedDocument = (doc)->
  document = emulatedDocument
  

###
Regexes
###
regexIdOrClassSeparator = new RegExp("[#.]")
regexIdOrClass = new RegExp("[#.][^#.]+", "g")

###
Private
###
map = (arr, f) ->
  output = []
  i = 0

  while i < arr.length
    output.push f(arr[i], i)
    i++
  output

each = (arr, f) ->
  i = 0

  while i < arr.length
    f arr[i], i
    i++

eachObj = (o, f) ->
  i = 0
  for attr of o
    f attr, o[attr], i
    i++

filter = (arr, f) ->
  output = []
  i = 0

  while i < arr.length
    output.push arr[i]  if f(arr[i], i)
    i++
  output

find = (arr, f) ->
  i = 0

  while i < arr.length
    return arr[i]  if f(arr[i])
    i++
  null

extend = (obj, args...) ->
  each args, (source) ->
    for prop of source
      obj[prop] = source[prop] if source[prop] isnt undefined
  obj

toObject = (arr, f) ->
  extend({}, (f(x) for x in arr)...)

keyValue = (a, b) ->
  o = {}
  o[a] = b
  o

orderedGroup = (arr, propOrFunc) ->
  getGroupKey = (if typeof (propOrFunc) is "function" then propOrFunc else (item) ->
    item[propOrFunc]
  )
  results = []
  dict = {}
  i = 0

  while i < arr.length
    key = getGroupKey(arr[i])
    unless key of dict
      dict[key] = []
      results.push
        key: key
        items: dict[key]

    dict[key].push arr[i]
    i++
  results


###
Indexes into an array, supports negative indices.
###
index = (arr, i) ->
  
  # one modulus to get in range, another to eliminate negative
  arr[(i % arr.length + arr.length) % arr.length]

typeOf = (value) ->
  s = typeof value
  if s is "object"
    if value
      s = "array"  if typeof value.length is "number" and not (value.propertyIsEnumerable("length")) and typeof value.splice is "function"
    else
      s = "null"
  s

curry = (fn, args...)->
 (args2...) ->
    fn.apply this, args.concat(args2)

splitOnce = (str, delim) ->
  components = str.split(delim)
  result = [components.shift()]
  result.push components.join(delim)  if components.length
  result


###
Functional, nondestructive version of Array.prototype.splice.
###
splice = (arr, index, howMany, elements...) ->
  results = []
  len = arr.length
  
  # add starting elements
  i = 0

  while i < index and i < len
    results.push arr[i]
    i++
  
  # add inserted elements
  i = 0
  elementsLen = elements.length

  while i < elementsLen
    results.push elements[i]
    i++
  
  # add ending elements
  i = index + howMany

  while i < len
    results.push arr[i]
    i++
  results


###
Public
###

###
Creates a DOM element. Supported objects are defined in the types array.
###
create = (arg, doc=document || emulatedDocument) ->
  match = find(types, (creatable) -> creatable.isOfType arg)
  (if match then match.build(arg, doc) else error("Unbuildable create argument: " + arg, arg))

createHtml = (arg)->
  create(arg, emulatedDocument).toString()


###
A list of objects that the create function can create DOM elements from.
In order of most to least common.
###
types = [
  
  # markup array
  isOfType: (o) -> o instanceof Array and o.length and typeof(o[0]) is 'string'
  build: (o, doc) -> createFromMarkupArray o, doc
,
  
  # content
  isOfType: (o) -> typeof o is "string" or typeof o is "number"
  build: (o, doc) -> doc.createTextNode o
,
  
  # function
  isOfType: (o) -> typeof o is "function"
  build: (o, doc) -> o(doc)
,
  
  # null or undefined
  isOfType: (o) -> !o?
  build: (o) -> o
,
  
  # DOM node
  isOfType: (o) -> isDomNode o
  build: (o) -> o
,
  
  # jQuery
  isOfType: (o) -> typeof (jQuery) isnt "undefined" and o instanceof jQuery
  build: (o) -> o[0]
,

  # fragment
  isOfType: (o) -> o instanceof Array and (!o.length or o[0] instanceof Array)
  build: (o, doc) -> 
    fragment = doc.createDocumentFragment()
    fragment.appendChild(create(child, doc)) for child in o
    fragment
  
]

# insert content as unescaped HTML with { html: true }
plugins = html: (el, html) ->
  el.innerHTML = el.firstChild.nodeValue  if html and el.firstChild


###
Parsing Functions
###

###
Parses the given markup array and returns a newly created element.
###
createFromMarkupArray = (markup, doc) ->
  attrsOmitted = typeOf(markup[1]) isnt "object"
  tagInput = markup[0]
  attrs = (if not attrsOmitted then markup[1] else {})
  children = markup[(if attrsOmitted then 1 else 2)]
  
  # split the tag input by spaces to extract descendants
  tags = splitOnce(tagInput, " ")
  tagNameString = tags[0]
  descendantTags = tags[1]
  if descendantTags
    children = [[descendantTags, attrs, children]]
    attrs = {}
  
  # create the element and parse its attributes and children
  element = undefined
  try
    tagName = parseTagName(tagNameString)
    element = doc.createElement(tagName)
  catch e
    error "Invalid tag name: " + tagName, markup
  
  # queue custom attribute plugins. they aren't executed immediately because we need to remove the plugin attributes and add the children and normal attributes
  pluginActions = []
  eachObj plugins, (pluginAttr, f) ->
    if pluginAttr of attrs
      pluginActions.push curry(f, element, attrs[pluginAttr])  if attrs[pluginAttr]
      delete attrs[pluginAttr]

  selectorAttrs = parseSelectorAttributes(tagNameString)
  addAttributes element, mergeAttributes(attrs, selectorAttrs)
  if children?
    addChildren element, children, doc
  
  # exucute the attribute plugins
  each pluginActions, (f) ->
    f()

  element


###
Returns the tag name from a tag name string that could have CSS selector syntax.
###
parseTagName = (tagNameString) ->
  tagNameString.split(regexIdOrClassSeparator)[0] or "div"


###
Parses the tagName for CSS selector syntax and returns an object of attribute names and values.
###
parseSelectorAttributes = (tagNameString) ->
  attrMap =
    "#": "id"
    ".": "class"

  afterSep = tagNameString.substring(tagNameString.indexOf(regexIdOrClassSeparator))
  selectors = afterSep.match(regexIdOrClass) or []
  
  # transform the list of selector strings to a list of objects so that they can be grouped by attribute
  selObjects = map(selectors, (sel) ->
    sep: attrMap[sel[0]]
    name: sel.substring(1)
  )

  # group the same selectors together so that a final attribute value can be determined from multiples, then convert the groups into a single object to be returned as the attribute .
  toObject orderedGroup(selObjects, "sep"), (g) ->
    
    # joins duplicate classes with a space, otherwise just uses the last value
    keyValue g.key, (if g.key is "class" then (item.name for item in g.items).join(" ") else index(g.items, -1).name)

###
Parses the attributes and adds them to the element.
###
addAttributes = (element, attrs) ->
  for attr of attrs
    if attr is "checked" or attr is "disabled" or attr is "selected"
      element.setAttribute attr, attr  if attrs[attr]
    else element.setAttribute attr, attrs[attr]  if attrs[attr]?


###
Returns true if the given class value string contains the given class.
###
containsClass = (str, className) ->
  str and (" " + str + " ").indexOf(" " + className + " ") > -1


###
Adds the given children to the element.
###
addChildren = (node, children, doc) ->
  children = [children]  if typeof children is "string" or typeof children is "number"
  node.appendChild create(child, doc) for child in children when child?

###
Helper Functions
###

###
Returns true if the given object seems to be a DomNode.
###
isDomNode = (node) ->
  node and typeof node.nodeType is "number"


# omit further tests for performance.
#arr.length >= 1 && arr.length <= 3 &&  // 1, 2, or 3 items
#typeof arr[0] === "string"       // tagname is a string
mergeAttributes = (a, b) ->
  uniqueClass = (singleClass) ->
    not containsClass(a["class"], singleClass)

  output = {}
  for aProp of a
    output[aProp] = a[aProp]
  for bProp of b
    output[bProp] = b[bProp]
  
  # merge class attributes
  output["class"] = (if a["class"] and b["class"] then [].concat(a["class"], filter(b["class"].split(" "), uniqueClass)).join(" ") else a["class"] or b["class"])
  output


###
Error Handling
###

###
Abstracts the error handling for Creatable so that we can substitute a different handler if necessary.
###
error = (message, params) ->
  console.error params  if params
  throw new Error(message or "ERROR")


###
Render Helper
###
render = (markup) ->
  body = document.body
  body.removeChild body.firstChild  while body.firstChild
  body.appendChild create(markup)

# export public interface
extend (exports? and exports or @Creatable = {}), 
  emulatedDocument:       emulatedDocument
  setDocument:            setDocument
  TextNode:               TextNode
  Element:                Element
  DocumentFragment:       DocumentFragment
  create:                 create
  createHtml:             createHtml
  types:                  types
  plugins:                plugins
  createFromMarkupArray:  createFromMarkupArray
  parseTagName:           parseTagName
  parseSelectorAttributes:parseSelectorAttributes
  addAttributes:          addAttributes
  containsClass:          containsClass
  isDomNode:              isDomNode
  mergeAttributes:        mergeAttributes
  error:                  error
  render:                 render
