TV.Common.Copy = (() => {
  return {
    init
  }

  function init() {
    onClickBtnCopy();
  }

  function onClickBtnCopy() {
    $(document).off('click', '.btn-copy');
    $(document).on('click', '.btn-copy', function(event) {
      event.preventDefault();

      copyCode(this);
      handleNotifyMessage(this);
    })
  }

  function copyCode(dom) {
    $(dom).prev('input.confirm-link').select();
    document.execCommand("copy");
  }

  function handleNotifyMessage(dom) {
    let labelDom = $(dom).find('.m-label');
    let oldLabel = labelDom.html();
    let hint = labelDom.data('hint');

    labelDom.html(hint);

    setTimeout(function() {
      labelDom.html(oldLabel);
    }, 500);
  }

})();
