module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-commoncoffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-compass'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.initConfig
    commoncoffee:
      app:
        options:
          root: 'app/coffee'
        files:
          'public/app.js': ['app/coffee/**/*.coffee'],
      vendor:
        options:
          wrap: false
          runtime: false
        files:
          'public/vendor.js': ['components/jquery/jquery.js']

    watch:
      app_coffee:
        files: 'app/coffee/**/*.coffee'
        tasks: ['commoncoffee:app']
        options:
          debouceDelay: 100
          interrupt: true

      app_compass:
        files: 'app/stylesheets/**/*.scss'
        tasks: ['compass:app']
        options:
          debouceDelay: 100
          interrupt: true


    compass:
      app:
        src: 'app/stylesheets'
        dest: 'public'
        images: '.'
        importPath: 'components'

    jade:
      dev:
        options:
          pretty: true
          data:
            debug: true
            javascripts: ['vendor.js', 'app.js']
        files:
          'public/index.html': 'app/pages/index.jade'

      production:
        options:
          data:
            debug: false
            javascripts: ['app.min.js']
        files:
          'public/index.html': 'app/pages/index.jade'
      

  grunt.registerTask 'default', ['commoncoffee', 'compass', 'jade:dev']



