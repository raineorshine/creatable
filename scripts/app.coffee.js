(function() {
  var build, convertGFM, converter;
  converter = new Markdown.Converter;
  convertGFM = function(mkd) {
    var indentMode, line, lines, newLines;
    indentMode = false;
    lines = mkd.split("\n");
    newLines = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = lines.length; _i < _len; _i++) {
        line = lines[_i];
        _results.push(line.startsWith("```") ? (indentMode = !indentMode, "") : indentMode ? "\t" + line : line);
      }
      return _results;
    })();
    return newLines.join("\n");
  };
  build = function() {
    return [
      "#page", [
        [
          "a#fork", {
            href: "https://github.com/RaineOrShine/creatable"
          }, [
            [
              "img", {
                src: "https://a248.e.akamai.net/assets.github.com/img/7afbc8b248c68eb468279e8c17986ad46549fb71/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67"
              }
            ]
          ]
        ], ["heading", [["h1", "Creatable"], ["h2.subtitle", "Pure Javascript client-side templating."]]], [
          "#main", {
            html: true
          }, converter.makeHtml(convertGFM(readme))
        ], [
          "footer ul", [
            ["li", "Author: Raine Lourie"], [
              "li", [
                "Github: ", [
                  "a", {
                    href: "http://github.com/RaineOrShine"
                  }, "RaineOrShine"
                ]
              ]
            ]
          ]
        ]
      ]
    ];
  };
  $(function() {
    Creatable.render(build());
    $("code").wrap(create(["pre.prettyprint"]));
    return prettyPrint();
  });
}).call(this);
