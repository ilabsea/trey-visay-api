"use strict";

TV.MajorsNew = (() => {
  return {
    init: init
  }

  function init() {
    TV.Job_clustersNew.initRecommendationRichText('#major_recommendation');
    TV.Job_clustersNew.onSubmitForm($('#major_recommendation'));
  }
})();

TV.MajorsCreate = TV.MajorsNew
TV.MajorsEdit = TV.MajorsNew
TV.MajorsUpdate = TV.MajorsNew
