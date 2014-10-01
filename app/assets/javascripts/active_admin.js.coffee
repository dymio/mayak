#= require active_admin/base

$(document).ready ->
  ## Chosen select boxes
  $('.chzn-select').chosen { width: "78%" }

  ## Init Redactor text editor
  if (editr = $('.editor:first')).length
    file_upload_url = location.protocol + "//" + location.host + "/admin/static_files/upload.json"
    uploadsFields =
      authenticity_token: $("meta[name=csrf-token]").attr('content')
      holder_type: editr.attr('data-type')
    uploadsFields.holder_id = editr.attr('data-id') if editr.is("[data-id]")
    # $("meta[name=csrf-param]").attr('content')

    # Init all editors
    $('.editor').redactor
      lang: 'ru'
      buttonSource: true
      imageUpload: file_upload_url
      uploadImageFields: uploadsFields
      fileUpload: file_upload_url
      uploadFileFields: uploadsFields

  ## Remote deletion of the Static File
  $(".delete-static-file").on 'ajax:success', (data, status, xhr) ->
    $(this).closest('tr').remove()
