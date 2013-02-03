module.exports = (grunt) ->

  tusk = require 'grunt-tusk'
  tusk.initialize grunt,
    scripts:
      vendor: [
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
        ]
      test_vendor: [
        'components/mocha/mocha.js',
        'components/chai/chai.js',
        'components/sinon.js/sinon.js',
        'components/sinon-chai/lib/sinon-chai.js'
        ]
    copy: [
      { source: 'components/bootstrap-sass/img', dest: 'images' }
      { source: 'components/font-awesome/font', dest: 'fonts' }
    ]

# vim: set foldmethod=marker
