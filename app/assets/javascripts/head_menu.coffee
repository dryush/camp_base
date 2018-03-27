
$(document).on 'turbolinks:load', ->
  curUrl = '/' + window.location.pathname.split('/')[1]
  $(".head-menu-buttons").find('.btn').each (i,dom) ->
    btn = $(dom)
    if btn.attr("href") == curUrl
      btn.addClass("active")
    else
      btn.removeClass("active")
