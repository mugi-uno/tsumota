# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $keyword = $('#keyword')
  $items_list = $('#items_list')

  $keyword.on "input", ->
    # todo:defer
    # 入力値でインクリメンタルサーチ
    keyword = $keyword.val()

    $keyword.parent().removeClass "waiting"

    $.ajax
      url : 'api/search'
      processData : true
      method : 'GET'
      data :
        keyword : keyword
    .done (html)-> 
      $items_list.html html
    .always ->
      $keyword.parent().addClass "waiting"
