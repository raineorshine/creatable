* Add more explicit API details
	- In a table maybe? See how other libraries are doing this
* Research
* Define recommended use vs templating
* Handlebars integration?

# data binding
1. render spans with ids
2. bind to the model's change event
3. when the model changes, update the span's HTML
4. when the span's content changes through contenteditable, update the model

# example

  var tableMarkup = 
    ['table', [
      ['tr', [
        ['td', 'Name'],
        ['td', 'Raine']
      ]]
      ['tr', [
        ['td', 'Job'],
        ['td', 'Teacher']
      ]]
      ['tr', [
        ['td', 'Favorite Language'],
        ['td', 'Javascript']
      ]]
    ]];

  // create a DOM node from jsonml
  var tableNode = Creatable.create(tableMarkup);

  // create an HTML string from jsonml
  var tableHTML = Creatable.createHTML(tableMarkup);

  var TableView = Backbone.View.extend({
    build: function() {
      return ['table', [
        ['tr', [
          ['td', 'Name'],
          ['td', this.model.bind('name')]
        ]]
        ['tr', [
          ['td', 'Job'],
          ['td', this.model.bind('job')]
        ]]
        ['tr', [
          ['td', 'Preferred Language'],
          ['td', this.model.bind('language')]
        ]]
      ]];
    }
  });






   var MyView = Backbone.View.extend({
      init: function() {
      },
      
      build: function() {
          return ['#mymodule', [
            ['input', { value: this.model.get('name'); }]
          ]];
      }
  });

  Creatable.plugins.bind = function(el, o/*comes from bind attribute value*/) {
      // dom -> model
      el.addEventHandler('change', function() {
         o.model.save(RJS.keyValue(o.name, el.value));
      };
      
      // model -> dom
      o.model.bind('change', function() {
        el.value = o.model.get(o.name);
      });
  };

  // the value of the 'bind' attribute gets passed as the second argument to the plugin (above)
  Creatable.create(['input', { bind: { model: this.model, field: 'name' } }]);

  /*
  <div id="mymodule">
  <input value="Raine">
  </div>

  In creatable itself:

  var newEl = document.createElement("input");
  newEl.addEventHandler("change", function() {
    
  });

  */ 
