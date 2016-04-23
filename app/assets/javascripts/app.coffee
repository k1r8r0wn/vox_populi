# Notifications

$ ->
  setTimeout (->
    $('#notifications-wrapper').fadeOut 'slow', ->
      $(this).remove()
  ), 4500
