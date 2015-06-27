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


## Nav Items hiding variables fields on show and new pages
  if $("#edit_nav_item, #new_nav_item").length
    checkTypeElementsVisibility = (url_t_val) ->
      url_t_val = url_t_val || $("#nav_item_url_type_input input:checked").val()
      $("#nav_item_url_text_input").toggle url_t_val.toString() == "0"
      $("#nav_item_url_page_input").toggle url_t_val.toString() == "1"

    $("#nav_item_url_type_input input").change (evnt) ->
      evnt.preventDefault()
      checkTypeElementsVisibility $(this).val()
      false
    checkTypeElementsVisibility()

