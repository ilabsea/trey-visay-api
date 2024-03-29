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
//= require tagify.min
//= require jquery.richtext

// for daterange picker
//= require moment
//= require moment/km.js
//= require daterangepicker
//= require bootstrap-select.min

//= require common/pumi

//= require application/namespace
//= require application/util
//= require common/copy
//= require common/wizard_new
//= require common/timeago
//= require common/sidebar
//= require common/date_locale
//= require common/daterange_picker
//= require common/select_picker
//= require common/logo
//= require common/confirm_modal
//= require common/toggle_advance_search
//= require common/tag_list

// Accordion
//= require common/toggle_collapse

//= require games/show
//= require personality_tests/show
//= require users/index
//= require visits/index
//= require career_websites/form
//= require schools/form
//= require job_clusters/form
//= require jobs/form
//= require personality_types/form
//= require accounts/form
//= require majors/form

$(document).on('turbolinks:load', function() {
  TV.Common.Copy.init();
  TV.Common.WizardNew.init();
  TV.Common.Timeago.init();
  TV.Common.Sidebar.init();
  TV.Common.SelectPicker.init();
  TV.Common.ConfirmModal.init("confirmDeleteModal");
  TV.Common.toggleAdvanceSearch.init();

  $("[role='tooltip']").remove();
  $('[data-toggle="tooltip"]').tooltip({ trigger: "hover" });

  let currentPage = TV.Util.getCurrentPage();
  !!TV[currentPage] && TV[currentPage].init();
});
