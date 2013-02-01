module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-commoncoffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

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

      

  grunt.registerTask 'default', ['commoncoffee']



