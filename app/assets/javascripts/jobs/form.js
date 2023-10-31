"use strict";

TV.JobsNew = (() => {
  return {
    init: init
  }

  function init() {
    TV.Common.Logo.init();
    TV.Job_clustersNew.initRecommendationRichText('#job_recommendation');
    TV.Job_clustersNew.onSubmitForm($('#job_recommendation'));
  }

})();

TV.JobsCreate = TV.JobsNew
TV.JobsEdit = TV.JobsNew
TV.JobsUpdate = TV.JobsNew
