module.exports = (grunt) ->

  Tusk = require 'grunt-tusk'
  tusk = new Tusk(grunt)

  if tusk.env.current == 'dev'
    javascripts = ['javascripts/vendor.js',
      'javascripts/templates.js',
      'javascripts/app.js']
  else
    javascripts = ['javascripts/app.min.js']

  tusk.coffee.add('app.js', ['app/coffee/**/*.coffee'],
    wrap: 'CommonJS', runtime: true, modulesRoot: 'app/coffee')

  tusk.coffee.add('vendor.js', [
    'components/jquery/jquery.js'
    'components/underscore/underscore.js'
    'components/backbone/backbone.js'
    'components/i18n-js/vendor/assets/javascripts/i18n.js'
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
  ], wrap: false)

  if tusk.env.current == 'dev'
    tusk.coffee.add('test.js', ['test/**/*.coffee'],
      wrap: 'Function', runtime: true, env: 'dev')
    tusk.coffee.add('test_vendor.js', [
      'components/mocha/mocha.js',
      'components/chai/chai.js',
      'components/sinon.js/sinon.js',
      'components/sinon-chai/lib/sinon-chai.js'
    ], wrap: false)

  else
    tusk.uglify.add('app.min.js', ['vendor.js', 'templates.js', 'app.js'])

  cssOptions = {}
  cssOptions['output-style'] = 'compressed' if tusk.env.current == 'production'
  tusk.css.add 'stylesheets', 'app/stylesheets', cssOptions

  jadeData = { javascripts: javascripts }
  tusk.jade.add '', 'app/pages', data: jadeData
  tusk.jade.add 'javascripts/templates.js', 'app/templates'
  tusk.jade.add 'test.html', 'test/test.jade', data: jadeData

  tusk.copy.add 'images', 'app/images'
  tusk.copy.add 'fonts', 'components/font-awesome/font'
  tusk.copy.add 'images', 'components/bootstrap-sass/img'

  config = tusk.getConfig()
  config.pkg = grunt.file.readJSON('package.json')

  grunt.initConfig(config)

# vim: set foldmethod=marker
