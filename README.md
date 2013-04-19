Scaffolding for a Heroku-ready, coffee-fueled web stack: **node + bower + bootstrap + backbone + creatable**

# server-side (npm)

* express
* mongodb
* underscore
* rjs
* jade
* async

# client-side (bower)

* bootstrap
* underscore
* backbone
* jQuery
* rjs
* creatable

# directory structure

    root
      |- public
        |- components
        |- images
        |- styles
        |- scripts
           |- compiled
           |- src
      |- src
        |- models
      |- view

# global dependencies

* node
* npm
* grunt-cli
* bower
* coffee
* stylus
* mongod
* foreman

# setup

    npm install
    bower install

# background jobs

    stylus public/styles/ -w &
    coffee -o ./ -cw src/ &
    coffee -o public/scripts/compiled -cw public/scripts/src/ &
    mongod &

# build

    grunt compile
    grunt concat
    grunt uglify
    grunt

    grunt clean

# start app
at port specified in .env file (default: 5001)

    foreman start


----------

**TODO**

* incorporate background jobs into grunt build task
