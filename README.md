# The Essentials

    1. npm install
    2. bower install
    3. grunt
    4. foreman start (http://localhost:5001)
    5. grunt static
    6. grunt deploy

# Background Jobs

    stylus public/styles/ -w &
    coffee -o ./ -cw src/ &
    coffee -o public/scripts/compiled -cw public/scripts/src/ &
