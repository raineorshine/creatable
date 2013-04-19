module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig

    shell:
      'compile-client-side':
        options: stdout: true
        command: 'coffee -o ./ -c src/'
      'compile-server-side':
        options: stdout: true
        command: 'coffee -o public/scripts/compiled -c public/scripts/src/'
      'compile-css':
        options: stdout: true
        command: 'stylus public/styles/'

    concat:
      options:
        separator: ';'
      dist:
        src: ['public/scripts/compiled/*.js', 'public/scripts/compiled/views/*.js']
        dest: 'public/scripts/out.js'

    uglify:
      build:
        src: 'public/scripts/out.js'
        dest: 'public/scripts/out.min.js'

    clean:
      js: ['*.js', 'public/scripts/compiled/', 'public/scripts/*.js']
      css: 'public/styles/main.css'
      components: 'public/components'
      npm: 'node_modules'

  
  # Load the plugin that provides the 'uglify' task.
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'

  # Default task(s).
  grunt.registerTask 'default', ['compile', 'concat', 'uglify']
  grunt.registerTask 'compile', ['shell:compile-server-side', 'shell:compile-client-side', 'shell:compile-css']
