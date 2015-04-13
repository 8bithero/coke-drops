# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $ ->
    $('[data-toggle="tooltip"]').tooltip()
    return
  $('#positive-drop').click ->
    $('#positive-filter').toggleClass 'drop-muted'
    $('[data-sentiment="positive"]').toggle 'slow'
    return
  $('#neutral-drop').click ->
    $('#neutral-filter').toggleClass 'drop-muted'
    $('[data-sentiment="neutral"]').toggle 'slow'
    return
  $('#negative-drop').click ->
    $('#negative-filter').toggleClass 'drop-muted'
    $('[data-sentiment="negative"]').toggle 'slow'
    return
  $('#censored').change ->
    if $(this).is(':checked')
      $('[data-censored="true"]').addClass 'highlight'
    else
      $('[data-censored="true"]').removeClass 'highlight'
    return

$(document).ready(ready)
$(document).on('page:load', ready)