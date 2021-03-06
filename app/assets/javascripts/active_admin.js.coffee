#= require active_admin/base

$(document).ready ->
## Chosen select boxes
  $('.chzn-select').chosen { width: "78%" }

## Init Trumbowyg editor
  if (editr = $('.editor:first')).length

    file_upload_path = "/admin/static_files/upload.json"
    uploadsFields = []
    uploadsFields.push {name: 'authenticity_token', value: $("meta[name=csrf-token]").attr('content')}
    uploadsFields.push {name: 'holder_type', value: editr.attr('data-type') }
    uploadsFields.push {name: 'holder_id', value: editr.attr('data-id') } if editr.is("[data-id]")

    $.trumbowyg.svgPath = '/assets/trumbowyg_icons.svg';

    $('.editor').trumbowyg
      lang: 'ru'
      resetCss: true
      removeformatPasted: false
      autogrow: false
      plugins:
        upload:
          serverPath: file_upload_path
          fileFieldName: 'file'
          data: uploadsFields
          urlPropertyName: 'filelink'
      btnsDef:
        image:
          dropdown: ['upload', 'insertImage']
          ico: 'insertImage'
        link:
          dropdown: ['createLink', 'unlink', 'upload_to_link']
          ico: 'link'
      btns: [
        ['viewHTML'],
        ['formatting'],
        'btnGrp-semantic',
        # ['superscript', 'subscript'],
        ['link'],
        ['image', 'noembed'],
        'btnGrp-justify',
        'btnGrp-lists',
        ['table'],
        ['horizontalRule'],
        ['removeformat'],
        ['fullscreen']
      ]

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

## Has many adding event helpers (original from https://github.com/activeadmin/activeadmin/blob/master/app/assets/javascripts/active_admin/lib/has_many.js.coffee )
#   $(document).on 'has_many_add:before', '.has_many_container', (e, container)->
#     if $(@).children('fieldset').length >= 3
#       alert "you've reached the maximum number of items"
#       e.preventDefault()
#
#   # The after hook is a good place to initialize JS plugins and the like.
#   $(document).on 'has_many_add:after', '.has_many_container', (e, fieldset, container)->
#     fieldset.find('.chzn-select').chosen { width: "78%" }
