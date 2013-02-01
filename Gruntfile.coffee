module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-commoncoffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-compass'

  grunt.initConfig
    commoncoffee:
      app:
        options:
          root: 'app/coffee'
        files:
          'public/app.js': ['app/coffee/**/*.coffee'],

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

      

  grunt.registerTask 'default', ['commoncoffee']



