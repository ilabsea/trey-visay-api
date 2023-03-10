"use strict";

TV.UsersIndex = (() => {
  return {
    init: init
  }

  function init() {
    onClickSearch();
    onClickDownload();
  }

  function onClickSearch() {
    $('.btn-search').on('click', function() {
      let url = window.location.origin + '?' + getQueryString();
      window.location = url
    })
  }

  function getQueryString() {
    let codes = ['province_code', 'district_code', 'high_school_code', 'grade'];
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
