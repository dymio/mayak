$ ->
  detectIe()
  return

detectIe = () ->
  ua = window.navigator.userAgent
  msie = ua.indexOf("MSIE ")
  if (msie > 0)
    $("body").addClass("lt-ie-11")
  return

