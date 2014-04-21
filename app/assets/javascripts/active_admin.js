//= require active_admin/base

// == * ==
// Please, have a look at the bottom of this file to find init script (doc.ready)
// == * ==

// Init Redactor text editor
function load_editor() {
  var file_upload_url = location.protocol + "//" + location.host + "/admin/static_files/upload_static_file.json"
  var csrf_param_value = $("meta[name=csrf-param]").attr('content');
  var csrf_token_value = $("meta[name=csrf-token]").attr('content');

  $('.editor').redactor({
    lang: 'ru',
    imageUpload: file_upload_url,
    uploadFields: { "authenticity_token" : csrf_token_value }
  });
}

function initEditContentPageMechanism() {
  var checkTypeElementsVisibility = function(beh_type_value) {
    beh_type_value = beh_type_value || $("#content_page_behavior_type_input input:checked").val();
    $("#content_page_rct_page_input").toggle(beh_type_value.toString() == "2");
    $("#content_page_rct_lnk_input").toggle(beh_type_value.toString() == "3");
    $("#content_page_body_input").toggle(beh_type_value.toString() == "0");
  }

  $("#content_page_behavior_type_input input").change(function(evnt) {
    evnt.preventDefault();
    checkTypeElementsVisibility($(this).val());
    false;
  });

  checkTypeElementsVisibility();
}

function initEditMainNavItemMechanism() {
  var checkTypeElementsVisibility = function(url_type_value) {
    url_type_value = url_type_value || $("#main_nav_item_url_type_input input:checked").val();
    $("#main_nav_item_url_text_input").toggle(url_type_value.toString() == "0");
    $("#main_nav_item_url_page_input").toggle(url_type_value.toString() == "1");
  }

  $("#main_nav_item_url_type_input input").change(function(evnt) {
    evnt.preventDefault();
    checkTypeElementsVisibility($(this).val());
    false;
  });

  checkTypeElementsVisibility();
}

$(document).ready(function() {
  // Content pages edit or new page functional
  if ($("#edit_content_page, #new_content_page").length) {
    initEditContentPageMechanism();
  }

  // Main Nav Items edit or new page functional
  if ($("#edit_main_nav_item, #new_main_nav_item").length) {
    initEditMainNavItemMechanism();
  }

  // Init chosen jQuery plugin
  $('.chzn-select').chosen({width: "78%"});

  // Init Redactor text editor
  load_editor();
});
