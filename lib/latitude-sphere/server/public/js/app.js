require.config({
  baseUrl: '../js',
  paths: {
    jquery: 'libs/jquery-1.8.3.min',
    ember: 'libs/ember-1.0.0-pre.2.min',
    handlebars: 'libs/handlebars-1.0.0.beta.6'
  },
  shim: {
    'jquery': {
      exports: "$"
    },
    'ember': {
      deps: ['handlebars', 'jquery'],
      exports: "Ember"
    }
  }
});

define(function(require) {
  var jquery = require("jquery");
  var ember = require("ember");
});