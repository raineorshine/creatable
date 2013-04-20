# includes
express =     require('express')
rjs =         require('rjs').installPrototypes()
config =      require('./config.js').config
render =      require('./controller-helper.js').render
Creatable =   require('Creatable')

# create app and set middleware
app = express()
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session(secret: config.sessionSecret)
app.use express.static(__dirname + '/public')

download = ->
  [[
    ['p a.button', { href: 'https://raw.github.com/RaineOrShine/creatable/master/creatable.js' }, [
      "Download"
      ['strong', 'creatable.js']
    ]]
    ['p.de-em a', { href: 'https://github.com/RaineOrShine/creatable' }, 'View the Project on GitHub']
  ]]

# controller
app.get '/', (req, res) ->
  c = ['html', [
    ['head', [
      ['title', 'Creatable']
      ['meta', { charset: 'UTF-8'}]
      ['meta', { name: 'viewport', content: 'width=device-width, initial-scale=1.0' }]
      ['link', { rel: 'stylesheet', href: 'components/bootstrap/css/bootstrap.min.css' }]
      ['link', { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Lato:300italic,700italic,300,700' }]
      ['link', { rel: 'stylesheet', href: 'styles/main.css' }]
    ]]

    ['body', [
      ['.wrapper', [

        ['header.page-header', [
          ['h1.page-title', 'Creatable']
          ['p', 'Elegant HTML generation. No templates. Just Javascript.']
          download()
        ]]

        ['section.content-section', [
          ['pre.prettyprint code.massive-demo', "['#content p a.small.button', { href: '/checkout' }, 'Checkout']"]
          ['.center-divide .massive-symbol', { html: true }, '&rarr;']
          ['pre.prettyprint code.language-javascript.massive-demo', '''<div id="content">
            <p>
              <a class="small button" href="/checkout">Checkout</a>
            </p>
          </div>''']

          ['p.instruct', "Creatable let's you build HTML in Javascript without templates."]

          ['h2', 'Why?']

          ['ul', [
            ['li', 'Switching between Javascript and a templating language is messy.']
            ['li', '''Including logic is clean since it's all Javascript.''']
            ['li', 'Implement partial views using plain old functions.']
            ['li', 'Reflects the natural structure of HTML for readability.']
          ]]

          ['h1', 'Getting Started']

          ['p.instruct', 'Pass a simple array that represents an element to Creatable.create():']

          ['pre.prettyprint code', '''Creatable.create(["a", { href: "http://google.com" }, "Google"])''']
          #['pre.prettyprint code.instruct-code', '''Creatable.create([TAGNAME, ATTRIBUTES, CHILDREN|CONTENT])
#Creatable.create(["a", { href: "http://google.com" }, "Google"]);''']

          ['p.instruct', 'Creatable.create() returns a native DOM node. Append it to your document:']

          ['pre.prettyprint code', '''var node = Creatable.create(["a", { href: "http://google.com" }, "Google"]);
          document.body.appendChild(node);''']

          ["p.instruct", '''Attributes are optional. Pass an object of attributes as the second item in the array.''']

          ['pre.prettyprint code', '''Creatable.create(['input', { type: 'input', name: 'city', value: 'Boulder' }])''']

          ["p.instruct", '''You can easily nest child elements:''']

          ['pre.prettyprint code', '''Creatable.create(['ul', [
            ['li', 'Item 1'],
            ['li', 'Item 2'],
            ['li', 'Item 3']
          ]])''']

          ["p.instruct", '''The unique use of nested arrays results in a very intuitive structure that reflects the appearance of HTML:''']

          ['pre.prettyprint code', '''var c = ["#content", [
            ["h1.prominent", "Blogs"],
            ["ul", [
              ["li a", { href: "http://functionsource.com" }, "FunctionSource"],
              ["li a", { href: "http://javascriptweblog.wordpress.com" }, "Javascript, Javascript"],
              ["li a", { href: "http://ejohn.org/category/blog" }, "John Resig"]
            ]]
          ]];
          document.body.appendChild(Creatable.create(c));''']

          ['p', 'Result:']

          ['pre.prettyprint code', '''<div id="content">
            <h1 class="prominent">Blogs</h1>
            <ul>
              <li><a href="http://functionsource.com">FunctionSource</a></li>
              <li><a href="http://javascriptweblog.wordpress.com">Javascript, Javascript</a></li>
              <li><a href="http://ejohn.org/category/blog">John Resig</a></li>
            </ul>
          </div>''']

          ['h1', 'Documentation']

          ['h2', 'Specify ids and classes like in CSS']

          ['pre.prettyprint code', '''Creatable.create(["div#footer", [
            ["p.fine-print", "Don\'t forget to read this!"]
          ]])''']
          ['pre.prettyprint code', '''<div id="footer">
            <p class="fine-print">Don\'t forget to read this!</p>
          </div>''']

          ['h2', 'HTML is automatically escaped']

          ['pre.prettyprint code', '''Creatable.create(['p', 'Something <strong>important</strong> to say.'])''']
          ['pre.prettyprint code', '<p>Something &amp;lt;strong&amp;gt;important&amp;lt;/strong&amp;gt; to say.</p>']

          ['p', 'You can unescape HTML by adding { html: true }']

          ['pre.prettyprint code', '''Creatable.create(['p', { html: true }, 'Something <strong>important</strong> to say.'])''']
          ['pre.prettyprint code', '<p>Something <strong>important</strong> to say.</p>']

          ['h2', 'Document Fragments']

          ['pre.prettyprint code', '''Creatable.create([[
            ["p", "First paragraph!!!"],
            ["p", "Second paragraph!!!"],
            ["p", "Third paragraph I'm bored"]
          ]]);''']
          ['pre.prettyprint code', '''<p>First paragraph!!!"</p>
          <p>Second paragraph!!!"</p>
          <p>Third paragraph I'm bored</p>''']

          ['h2', 'Works great with underscore']

          ['pre.prettyprint code', '''var links = [
              { url: "http://functionsource.com", label: "FunctionSource" },
              { url: "http://javascriptweblog.wordpress.com", label: "Javascript, Javascript" },
              { url: "http://ejohn.org/category/blog", label: "John Resig" }
          ];

          var buildLinkItem = function(model) {
              return ["li", [
                  ["a", { href: model.url }, model.label]
              ]];
          };

          Creatable.create(["ul", _.map(links, buildLinkItem)])''']
          ['pre.prettyprint code', '''<ul>
              <li><a href="http://functionsource.com">FunctionSource</a></li>
              <li><a href="http://javascriptweblog.wordpress.com">Javascript, Javascript</a></li>
              <li><a href="http://ejohn.org/category/blog">John Resig</a></li>
          </ul>''']

          ['h2', 'Built-in support for jQuery elements']

          ['pre.prettyprint code', '''Creatable.create(["#myModule", [
              ["h1", "This is a header"],
              "Some text.",
              $("<div><p>Go, Go jQuery</p></div>")
          ]])''']
          ['pre.prettyprint code', '''<div id="myModule">
              <h1>This is a header</h1>
              Some text.
              <div><p>Go, Go jQuery</p></div>
          </div>''']

          ['h2', 'Render a string of HTML instead of a DOM node']

          ['pre.prettyprint code', '''var html = Creatable.createHtml(['a#go.small.button', 'test']);
          console.log(html); //<a id="go" class="small button">test</a>''']

          ['h1', 'Unit Tests']
          ['p', 'creatable has full unit test coverage using mocha.']

          ['h1', 'Installation']

          ['p', 'Client Side:']
          ['pre.prettyprint code', '<script src="creatable.js"></script>']

          ['p', 'Server Side:']
          ['pre.prettyprint code', '''var Creatable = require('creatable.js');''']
        ]]

        ['section .center-divide', [
          download()
        ]]

        ['hr']
        ['footer', [
          ['p', [
            'This project is maintained by '
            ['a', { href: 'https://github.com/RaineOrShine' }, 'RaineOrShine']
          ]]
        ]]
      ]]


      ['script', { type: 'text/javascript', src: 'https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js' }]
    ]]
  ]]
  res.send '<!doctype html>' + Creatable.create(c).toString()

# start
app.listen process.env.PORT, ->
  console.log 'Listening on port ' + process.env.PORT

# export globals
exports.app = app