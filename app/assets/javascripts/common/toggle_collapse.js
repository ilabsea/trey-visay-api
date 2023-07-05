TV.Common.ToggleCollapse = (() => {
  function init(localStorageKey='advance_search') {
    let css_class = localStorage.getItem(localStorageKey);

    if(!!css_class) {
      document.getElementById('collapseFilter').classList.add(css_class);
    }
  }

  function toggleLocalStorage(localStorageKey) {
    let css_class = !!localStorage.getItem(localStorageKey) ? '' : 'show'

    localStorage.setItem(localStorageKey, css_class);
  }

  function onClickAdvanceSearch(localStorageKey) {
    $(".advance-search").on('click', function() {
      toggleLocalStorage(localStorageKey);
    })
  }

  return {
    init: init,
    toggleLocalStorage: toggleLocalStorage,
    onClickAdvanceSearch: onClickAdvanceSearch
  }
})();
