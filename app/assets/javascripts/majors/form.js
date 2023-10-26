"use strict";

TV.MajorsNew = (() => {
  return {
    init: init
  }

  function init() {
    TV.Job_clustersNew.initRecommendationRichText('#major_recommendation');
    onSubmitForm();
  }

  function onSubmitForm() {
    $(".simple_form").on("submit", function(e) {
      let dom = $("#major_recommendation");
      let content = dom.val().replace(/<\/?[^>]+(>|$)/g, "");

      if(!content) {
        dom.val(null);
      }

      return true;
    })
  }
})();

TV.MajorsCreate = TV.MajorsNew
TV.MajorsEdit = TV.MajorsNew
TV.MajorsUpdate = TV.MajorsNew
