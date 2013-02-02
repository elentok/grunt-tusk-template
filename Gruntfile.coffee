path = require 'path'

module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-commoncoffee'
  grunt.loadNpmTasks 'grunt-compass'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.loadNpmTasks 'grunt-regarde'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-livereload'

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
      test:
        options:
          wrap: false
          runtime: false
        files:
          'public/test.js': ['test/**/*.coffee']
      test_vendor:
        options:
          wrap: false
          runtime: false
        files:
          'public/test_vendor.js': [
            'components/mocha/mocha.js',
            'components/chai/chai.js'
          ]




    regarde:
      app_coffee:
        files: 'app/coffee/**/*.coffee'
        tasks: ['commoncoffee:app']

      app_compass:
        files: 'app/stylesheets/**/*.scss'
        tasks: ['compass:app']

      test_coffee:
        files: 'test/**/*.coffee'
        tasks: ['commoncoffee:test']

      jade:
        files: '**/*.jade'
        tasks: ['jade:dev']

      public:
        files: 'public/**/*'
        tasks: ["livereload"]
        #spawn: true
        #tasks: ["livereload:<%= grunt.regarde.changed %>"]
        #events: true



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
          'public/test.html': 'test/test.jade'

      production:
        options:
          data:
            debug: false
            javascripts: ['app.min.js']
        files:
          'public/index.html': 'app/pages/index.jade'

    connect:
      livereload:
        options:
          port: 9001
          middleware: (connect, options) ->
            utils = require('grunt-contrib-livereload/lib/utils')
            snippet = utils.livereloadSnippet
            mount = connect.static(path.resolve('.'))
            [snippet, mount]
      

  grunt.registerTask 'default', ['commoncoffee', 'compass', 'jade:dev']
  grunt.registerTask 'live', ['livereload-start', 'connect', 'regarde']



