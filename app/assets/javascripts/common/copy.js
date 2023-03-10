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
    let oldLabel = $(dom).data('title');
    let hint = $(dom).data('hint');

    $(dom).attr('data-original-title', hint);
    $(dom).tooltip('show');

    setTimeout(function() {
      $(dom).attr('data-original-title', oldLabel);
    }, 500);
  }

})();
