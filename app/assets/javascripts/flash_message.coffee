$(document).ready () ->

  # Notices and alerts from rails app
  if $("#flmsg").length
    rmsgsPopapilus = $.popapilus
      css_class: "flmsg-popup",
      no_overlay: true,
      fixed: true,
      modal: false,
      centered: false,
      show_animation_speed: 800,
      autoclose_time: 4600
    rmsgsPopapilus.show $("#flmsg").html()
