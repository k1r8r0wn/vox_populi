$ ->
# FadeOut notifications
  setTimeout (->
    $('#notifications-wrapper').fadeOut 'slow', ->
      $(this).remove()
  ), 4500

# Open menu dropdown list on mobile devices by default, when main menu is opened
  $('.navbar-toggle').click ->
    setTimeout (->
      $('.dropdown-toggle').click()
    ), 100

# Enable tooltips everywhere
  $('[data-toggle="tooltip"]').tooltip()
