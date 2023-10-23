"use strict";

TV.Personality_typesNew = (() => {
  return {
    init: init
  }

  function init() {
    TV.Job_clustersNew.initRecommendationRichText('#personality_type_recommendation');
  }
})();

TV.Personality_typesCreate = TV.Personality_typesNew
TV.Personality_typesEdit = TV.Personality_typesNew
TV.Personality_typesUpdate = TV.Personality_typesNew
