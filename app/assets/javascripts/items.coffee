$ ->
  tags = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    prefetch:
      url: '/api/tags/source'
      filter: (list) ->
        $.map list, (name) ->
          name: name

  tags.initialize()

  $('.typeahead-tags').tagsinput
    typeaheadjs:
      name: 'name'
      displayKey: 'name'
      valueKey: 'name'
      source: tags.ttAdapter()
