path = require 'path'

# commoncoffee {{{1
initCommonCoffee = (grunt, config) ->
  grunt.loadNpmTasks 'grunt-commoncoffee'

  config.regarde.app_coffee =
    files: 'app/coffee/**/*.coffee'
    tasks: ['commoncoffee:app']

  config.regarde.test_coffee =
    files: 'test/**/*.coffee'
    tasks: ['commoncoffee:test']

  config.commoncoffee =
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
        'public/vendor.js': [
          'components/jquery/jquery.js'
          'components/underscore/underscore.js'
          'components/backbone/backbone.js'
          'components/marionette/lib/backbone.marionette.js'
          'components/bootstrap-sass/js/bootstrap-tooltip.js'
          'components/bootstrap-sass/js/bootstrap-affix.js'
          'components/bootstrap-sass/js/bootstrap-alert.js'
          'components/bootstrap-sass/js/bootstrap-button.js'
          'components/bootstrap-sass/js/bootstrap-carousel.js'
          'components/bootstrap-sass/js/bootstrap-collapse.js'
          'components/bootstrap-sass/js/bootstrap-dropdown.js'
          'components/bootstrap-sass/js/bootstrap-modal.js'
          'components/bootstrap-sass/js/bootstrap-popover.js'
          'components/bootstrap-sass/js/bootstrap-scrollspy.js'
          'components/bootstrap-sass/js/bootstrap-tab.js'
          'components/bootstrap-sass/js/bootstrap-transition.js'
          'components/bootstrap-sass/js/bootstrap-typeahead.js'
        ]
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
          'components/chai/chai.js',
          'components/sinon.js/sinon.js',
          'components/sinon-chai/lib/sinon-chai.js'
        ]

# jade2html {{{1
initJade2html = (grunt, config) ->
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.renameTask('jade', 'jade2html')

  config.regarde.jade2html =
    files: ['app/pages/**/*.jade', 'test/*.jade']
    tasks: ['jade2html:dev']

  config.jade2html =
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
          javascripts: ['app.js']
      files:
        'build/index.html': 'app/pages/index.jade'

# jade2js {{{1

initJade2js = (grunt, config) ->
  grunt.loadNpmTasks 'grunt-jade-plugin'
  grunt.renameTask('jade', 'jade2js')

  config.regarde.jade2js =
    files: ['app/templates/**/*.jade']
    tasks: ['jade2js']

  config.jade2js =
    app:
      options:
        namespace: 'JST'
      files:
        'public/templates.js': 'app/templates/**/*.jade'

# compass {{{1
initCompass = (grunt, config) ->
  grunt.loadNpmTasks 'grunt-compass'
  config.regarde.app_compass =
    files: 'app/stylesheets/**/*.scss'
    tasks: ['compass:dev']

  config.compass =
    dev:
      src: 'app/stylesheets'
      dest: 'public'
      images: '.'
      importPath: 'components'
    production:
      outputstyle: 'compressed'
      src: 'app/stylesheets'
      dest: 'build'
      images: '.'
      importPath: 'components'

# livereload {{{1
initLiveReload = (grunt, config) ->
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-livereload'

  config.regarde.public =
    files: 'public/**/*'
    tasks: ["livereload"]

  config.connect =
    livereload:
      options:
        port: 9001
        middleware: (connect, options) ->
          utils = require('grunt-contrib-livereload/lib/utils')
          snippet = utils.livereloadSnippet
          mount = connect.static(path.resolve('.'))
          [snippet, mount]
 
# copy files {{{1
initCopy = (grunt, config) ->
  grunt.loadNpmTasks 'grunt-contrib-copy'
  config.regarde.images =
    files: 'app/images/**/*'
    tasks: ["copy"]

  config.copy =
    dev:
      files: [
        {expand: true, cwd: 'app/images', src: ['**'], dest: 'public/images/' }
        {expand: true, cwd: 'components/bootstrap-sass/img', src: ['**'], dest: 'public/images/' }
        {expand: true, cwd: 'components/font-awesome/font', src: ['**'], dest: 'public/fonts/' }
      ]
    production:
      files: [
        {expand: true, cwd: 'app/images', src: ['**'], dest: 'build/images/' }
        {expand: true, cwd: 'components/bootstrap-sass/img', src: ['**'], dest: 'build/images/' }
        {expand: true, cwd: 'components/font-awesome/font', src: ['**'], dest: 'build/fonts/' }
      ]

initUglify = (grunt, config) ->
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  config.uglify =
    production:
      files:
        'build/app.js': ['public/vendor.js', 'public/templates.js', 'public/app.js']
  

# registerTasks {{{1
registerTasks = (grunt) ->
  grunt.registerTask 'default',
    ['commoncoffee', 'compass:dev', 'jade2html:dev', 'jade2js', 'copy']

  grunt.registerTask 'production',
    ['commoncoffee', 'compass:production', 'jade2html:production', 'jade2js', 'copy', 'uglify']

  grunt.registerTask 'live',
    ['livereload-start', 'connect', 'regarde']

# module.exports {{{1

module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-regarde'

  config =
    regarde: {}

  initJade2html(grunt, config)
  initJade2js(grunt, config)
  initCommonCoffee(grunt, config)
  initCompass(grunt, config)
  initLiveReload(grunt, config)
  initCopy(grunt, config)
  initUglify(grunt, config)

  grunt.initConfig(config)
  registerTasks(grunt)

# vim: set foldmethod=marker
