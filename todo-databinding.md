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
