Creatable = @Creatable ? require('../creatable.js')
chai = @chai ? require('chai')
should = chai.should()

describe "Basic", ->
  describe "passing null or undefined", ->
    it "should return null", ->
      should.not.exist Creatable.create(null)
      should.not.exist Creatable.create(undefined)

  describe 'passing a string or number', ->
    it 'should return a TextNode with the string or number as its content', ->
      Creatable.create('test').should.have.property('nodeType', 3)
      Creatable.create('test').should.have.property('textContent', 'test')

  describe 'passing a tagName in brackets', ->
    it 'should create an element with that tagName', ->
      Creatable.create(['div']).nodeName.should.equal('DIV')

  describe 'passing text as the second argument', ->
    it 'should create an element with the given text content', ->
      el = Creatable.create(['p', 'This is a test.'])
      el.nodeName.should.equal('P')
      $(el).text().should.equal('This is a test.')

  describe 'passing text as the third argument', ->
    it 'should create an element with the given text content', ->
      el = Creatable.create(['p', {}, 'This is a test.'])
      el.nodeName.should.equal('P')
      $(el).text().should.equal('This is a test.')

describe "Ids and Classes", ->
  describe 'div#myId', ->
    it 'should create a div with an id of myId', ->
      el = Creatable.create(['div#myId'])
      el.nodeName.should.equal('DIV')
      $(el).attr('id').should.equal('myId')

  describe '#myId', ->
    it 'should create a div with an id of myId', ->
      el = Creatable.create(['#myId'])
      el.nodeName.should.equal('DIV')
      $(el).attr('id').should.equal('myId')

  describe 'div.myClass', ->
    it 'should create a div with a class of myClass', ->
      el = Creatable.create(['div.myClass'])
      el.nodeName.should.equal('DIV')
      $(el).hasClass('myClass').should.be.true

  describe '.myClass', ->
    it 'should create a div with a class of myClass', ->
      el = Creatable.create(['.myClass'])
      el.nodeName.should.equal('DIV')
      $(el).hasClass('myClass').should.be.true

  describe '.class1.class2', ->
    it 'should create a div with two classes', ->
      el = Creatable.create(['.class1.class2'])
      el.nodeName.should.equal('DIV')
      $(el).hasClass('class1').should.be.true
      $(el).hasClass('class2').should.be.true

  describe '#myId.myClass', ->
    it 'should create a div with both an id and a class', ->
      el = Creatable.create(['#myId.myClass'])
      el.nodeName.should.equal('DIV')
      $(el).attr('id').should.equal('myId')
      $(el).hasClass('myClass').should.be.true

describe 'Attributes', ->

  describe 'passing an object as the second argument', ->
    it 'should create an element with attributes', ->
      el = Creatable.create(['a', { href: 'http://google.com', target: '_blank' }])
      $(el).attr('href').should.equal('http://google.com')
      $(el).attr('target').should.equal('_blank')

  describe 'using css-syntax and a class attribute', ->
    it 'should create a div with both classes', ->
      el = Creatable.create(['.class1', { 'class': 'class2' }])
      $(el).hasClass('class1').should.be.true
      $(el).hasClass('class2').should.be.true

describe 'Children', ->

  describe 'passing an array of children', ->
    it 'should create an element with the appropriate children', ->
      el = Creatable.create(
        ['div', [
          ['a'],
          ['p']
        ]]
      )
      el.nodeName.should.equal('DIV')
      el.childNodes.should.have.length(2)
      el.childNodes[0].nodeName.should.equal('A')
      el.childNodes[1].nodeName.should.equal('P')

  describe 'null or undefined children', ->
    it 'should be ignored', ->
      el = Creatable.create(
        ['div', [
          ['a'],
          null,
          undefined,
          ['p']
        ]]
      )
      el.childNodes.should.have.length(2)
      el.childNodes[0].nodeName.should.equal('A')
      el.childNodes[1].nodeName.should.equal('P')


  describe 'document fragment', ->
    it 'should be created from an empty array', ->
      el = Creatable.create([])
      el.nodeType.should.equal(11)
      el.childNodes.should.have.length(0)
    it 'should be created from an array of children', ->
      el = Creatable.create(
        [[
          ['a'],
          ['p']
        ]]
      )
      el.nodeType.should.equal(11)
      el.childNodes.should.have.length(2)
      el.childNodes[0].nodeName.should.equal('A')
      el.childNodes[1].nodeName.should.equal('P')

  describe 'descendant css syntax', ->
    it 'should create children', ->
      el = Creatable.create(['div p a'])
      el.nodeName.should.equal('DIV')
      el.firstChild.nodeName.should.equal('P')
      el.firstChild.firstChild.nodeName.should.equal('A')
    it 'should add classes and attributes to the final descendant', ->
      el = Creatable.create(['div p a.button', { href: 'http://google.com' }])
      $(el.firstChild.firstChild).attr('href').should.equal('http://google.com')

describe 'Other Features', ->

  describe 'unescaped HTML content', ->
    it 'should be able to be added with the attribute of { html: true }', ->
      el = Creatable.create(
        ['ul', {html:true}, '<li>A</li><li>B</li><li>C</li>']
      )
      el.childNodes.should.have.length(3)
      el.firstChild.nodeName.should.equal('LI')
      el.firstChild.textContent.should.equal('A')

  describe 'checked, disabled, selected attributes', ->
    it 'should convert true to the attribute name', ->
      checked = Creatable.create(["input", { type: "radio", checked: true }])
      disabled = Creatable.create(["input", { type: "text", disabled: true }])
      selected = Creatable.create(["select", [
        ["option", { selected: true }]
      ]])

      $(checked).prop('checked').should.be.true
      $(disabled).attr('disabled').should.equal('disabled')
      $(selected.firstChild).attr('selected').should.equal('selected')

    it 'should not render the attribute when set to false', ->
      checked = Creatable.create(["input", { type: "radio", checked: false }])
      disabled = Creatable.create(["input", { type: "text", disabled: false }])
      selected = Creatable.create(["select", [
        ["option", { selected: false }]
      ]])

      checked.hasAttribute('checked').should.be.false
      disabled.hasAttribute('disabled').should.be.false
      selected.firstChild.hasAttribute('selected').should.be.false

  describe 'TextNode', ->
  describe 'DocumentFragment', ->
  describe 'Element', ->

  describe 'createHtml', ->
    it 'should render creatable markup to a string', ->
      Creatable.createHtml(['a#go.small.button', 'test']).should.equal('<a id="go" class="small button">test</a>')







