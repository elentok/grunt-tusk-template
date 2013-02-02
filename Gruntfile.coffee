path = require 'path'

module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-commoncoffee'
  grunt.loadNpmTasks 'grunt-compass'

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.renameTask('jade', 'jade2html')
  grunt.loadNpmTasks 'grunt-jade-plugin'
  grunt.renameTask('jade', 'jade2js')

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

      jade2html:
        files: ['app/pages/**/*.jade', 'test/*.jade']
        tasks: ['jade2html:dev']

      jade2js:
        files: ['app/templates/**/*.jade']
        tasks: ['jade2js']

      public:
        files: 'public/**/*'
        tasks: ["livereload"]


    compass:
      app:
        src: 'app/stylesheets'
        dest: 'public'
        images: '.'
        importPath: 'components'

    jade2html:
      dev:
        options:
          pretty: true
          data:
            debug: true
            javascripts: ['vendor.js', 'templates.js', 'app.js']
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

    jade2js:
      app:
        options:
          namespace: 'JST'
        files:
          'public/templates.js': 'app/templates/**/*.jade'

    connect:
      livereload:
        options:
          port: 9001
          middleware: (connect, options) ->
            utils = require('grunt-contrib-livereload/lib/utils')
            snippet = utils.livereloadSnippet
            mount = connect.static(path.resolve('.'))
            [snippet, mount]
      

  grunt.registerTask 'default',
    ['commoncoffee', 'compass', 'jade2html:dev', 'jade2js']

  grunt.registerTask 'production',
    ['commoncoffee', 'compass', 'jade2html:production', 'jade2js']

  grunt.registerTask 'live',
    ['livereload-start', 'connect', 'regarde']



