// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  tinymce.remove()
  tinymce.init({ 
    height: 512,
    selector:'textarea#post_content',
    plugins: "media image link paste emoticons charmap nonbreaking preview tinymcespellchecker lists linkchecker autolink autosave wordcount fullscreen",
    toolbar: "styleselect | restoredraft undo redo paste | bold italic link | image media emoticons charmap | nonbreaking fullscreen",
    menubar: "insert view edit",
    spellchecker_rpc_url: 'localhost/ephox-spelling',
    spellchecker_language: 'en',
  });
})
 