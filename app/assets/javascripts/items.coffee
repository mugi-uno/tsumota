$ ->
  $('.typeahead-tags').tagsinput
    typeahead:
      source: $.get('/api/tags/source')