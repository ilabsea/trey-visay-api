"use strict";

TV.UsersIndex = (() => {
  return {
    init: init
  }

  function init() {
    onClickSearch();
    onClickDownload();
    handleDisplaySearchButton();
    TV.Common.DaterangePicker.init();
  }

  function handleDisplaySearchButton() {
    if(!$(".filter-wrapper .form-group").length) {
      $(".filter-wrapper .search-button").remove();
    }
  }

  function onClickSearch() {
    $('.btn-search').on('click', function() {
      let url = window.location.origin + '?' + getQueryString();
      window.location = url
    })
  }

  function getQueryString() {
    let codes = ['province_id', 'district_id', 'high_school_code', 'grade'];
    let arr = [];

    for(var i=0; i<codes.length; i++) {
      let value = $('select[name="' + codes[i] + '"]').val();
      if(!value) { continue; }
      let query = codes[i] + '=' + value;
      arr.push(query);
    }

    return arr.join('&');
  }

  function onClickDownload() {
    $('#btn-download').on('click', function(event) {
      event.preventDefault();
      window.open($(this).attr("href") + '?' + getQueryString(), '_blank');
    })
  }
})();
