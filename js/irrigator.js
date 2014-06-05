var Backbone = require('backbone');

var GeocodeSearchForm = Backbone.View.extend({
  tagName: 'form'
 ,id: 'geocode-search'
 ,events: {
    'submit': 'search'
  }
 ,search: function(event) {
    event.preventDefault();
    alert('will geocode someday!');
  }
});


$(document).ready(function() {
  var f = new GeocodeSearchForm({ el: $('#geocode-search') });
});
