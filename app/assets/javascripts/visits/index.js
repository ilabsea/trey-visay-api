"use strict";

TV.VisitsIndex = (() => {
  return {
    init: init
  }

  function init() {
    let localStorageKey = "advance_search_visit";

    TV.Common.DaterangePicker.init();
    TV.Common.ToggleCollapse.init(localStorageKey);
    TV.Common.ToggleCollapse.onClickAdvanceSearch(localStorageKey);
  }
})();
