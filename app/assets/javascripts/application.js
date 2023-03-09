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
//= require jquery
//= require turbolinks
//= require popper
//= require bootstrap
//= require sb-admin-2
//= require chart.bundle.min
//= require common/pumi

//= require application/namespace
//= require application/util
//= require common/copy

//= require games/show
//= require personality_tests/show
//= require users/index

$(document).on('turbolinks:load', function() {
  TV.Common.Copy.init();
  $("[role='tooltip']").remove();
  $('[data-toggle="tooltip"]').tooltip({ trigger: "hover" });

  let currentPage = TV.Util.getCurrentPage();
  console.log(currentPage)
  !!TV[currentPage] && TV[currentPage].init();
});
