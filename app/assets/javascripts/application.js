// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require_tree .

// 商品名の文字数をカウントする。
// コードはヤフオクの商品出品ページからパクってきた。
// 半角英数や記号は0.5文字、それ以外は1文字分？（半角ｶﾅは１文字分らしい）
// ヤフオクへの出品が目的なので、これで正解のはず。
function count_title_length(title) {
  len = 0;
  title = escape(title);
  for (i = 0; i < title.length; i++, len++) {
    if (title.charAt(i) == '%') {
      if (title.charAt(++i) == 'u') {
        i += 3;
        len++;
      }
      i++;
    }
  }
  return len / 2;
}

function copy_to_clipboard(selector){
  var obj = $(selector)[0];

  // 範囲の指定
  var range = document.createRange();
  range.selectNodeContents(obj);

　// 範囲を選択
  var selection = window.getSelection();
  selection.removeAllRanges();
  selection.addRange(range);

  // クリップボードへコピー  
  document.execCommand("copy");
}

function replace_tags(text, key, value) {
  text = text.replace(`{{${key}}}`, value);
  return text;
}

function simple_format(str) {
  str = str.replace(/\r\n?/, "\n");
  str = $.trim(str);
  if (str.length > 0) {
    str = str.replace(/\n\n+/g, '</p><p>');
    str = str.replace(/\n/g, '<br>');
    str = '<p>' + str + '</p>';
  }
  return str;
}

$(document).on('turbolinks:load', function(){
  $('#show-preview').change(function() {
    var val = $(this).prop('checked');
    $('.editorPreview').toggle(val);
  });

  $('.editable-select > select').change(function() {
    var val = $(this).val();
    var $item = $(this).nextAll('input,select,textarea').first();
    $item.val(val);
  });

  $('[data-filter-to]').change(function() {
    var search_value = $(this).val();
    var target_id = $(this).data('filter-to');

    $(`#${target_id} > option`).hide();
    $(`#${target_id} > option[data-tags*=${search_value}]`).show();
  });

  $('#goto-next').click(function() {
    var title = $("#title").val();
    var body = $("#body").val();

    $('.template-item').each(function() {
      var label = $(this).find('label').filter(':not(.ignore)').first().text();
      var $item = $(this).find('input,select,textarea').filter(':not(.ignore)').first();
      var value = $item.val();

      if($item.is(':checkbox')) {
        value = '';
        $item.filter(':checked').each(function() {
          value += $(this).val();
          value += ' ';
        });
      }

      title = replace_tags(title, label, value);
      body = replace_tags(body, label, value);
    });
    body = replace_tags(body, "タイトル", title);

    $("#title").val(title).change();
    $("#body").val(body).change();
    $('.editorMain').show(200);
    $('.editorPreview').show(200);
  });

  $('#templates').change(function(e){
    var id = $(this).val();
    $.ajax({
      url: `/templates/${id}.json`,
      success: function(result) {
        $("#title").val(result.title).change();
        $("#body").val(result.description).change();
        $(`[data-type]`).hide();
        $(`[data-type="${result.name}"]`).show();
      }
    });
  });

  $('#clothing_brands').change(function() {
    var id = $(this).val();
    $.ajax({
      url: `/clothing_brands/${id}.json`,
      success: function(result) {
        $("#clothing_brands-ja_name").val(result.ja_name);
        $("#clothing_brands-en_name").val(result.en_name);
        $("#clothing_brands-description").val(result.description);
      }
    });
  }).change();

  $('#designs').change(function() {
    var id = $(this).val();
    $.ajax({
      url: `/designs/${id}.json`,
      success: function(result) {
        $("#designs-name").val(result.name);
        $("#designs-description").val(result.description);
      }
    });
  }).change();

  $('#material_brands').change(function() {
    var id = $(this).val();
    $.ajax({
      url: `/material_brands/${id}.json`,
      success: function(result) {
        $("#material_brands-name").val(result.name);
        $("#material_brands-description").val(result.description);
      }
    });
  }).change();

  $('#colors').change(function() {
    var id = $(this).val();
    $.ajax({
      url: `/colors/${id}.json`,
      success: function(result) {
        $("#colors-name").val(result.name);
        $("#colors-description").val(result.description);
      }
    });
  }).change();

  $("#editorPreview_title_copy_btn").click(function() {
    copy_to_clipboard(".editorPreview_title");
  });

  $("#editorPreview_body_copy_btn").click(function() {
    copy_to_clipboard(".editorPreview_body");
  });

  $("#title").on('change input', function() {
    var title = $(this).val();
    var count = count_title_length(title);

    $(".editorPreview_title").html(title);
    $(".editorPreview_title_counter").html(`${count}/65`);
  });

  $("#body").on('change input', function() {
    var body = $(this).val();
    $(".editorPreview_body").html(simple_format(body));
  });

  // 初期表示のときもchangeを発火
  // $('#direct-edit-mode').change();
  $('[data-filter-to]').change();
  $('.editable-select > select').change();
  $('#templates').change();
  $("#title").change();
  $("#body").change();
});

