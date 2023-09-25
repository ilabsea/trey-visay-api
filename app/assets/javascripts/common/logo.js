TV.Common.Logo = (() => {
  return {
    init
  }

  function init() {
    onChangeLogoFile();
    onClickButtonDeleteLogo();
  }

  function onClickButtonDeleteLogo() {
    $('.btn-delete').on('click', function() {
      showDefaultImage();
      hideDeleteButton();
      setCheckRemoveLogo();
    })
  }

  function onChangeLogoFile() {
    $("input.input-logo").change(function() {
      readURL(this);
      showButtonDelete();
      setUncheckRemoveLogo();
    });
  }

  function setCheckRemoveLogo() {
    $('input.remove-logo').attr('checked', true);
  }

  function setUncheckRemoveLogo() {
    $('.input.remove-logo').attr('checked', false);
  }

  function showDefaultImage() {
    $('.program-logo').attr('src', $('.program-logo').data('default'));
  }

  function hideDeleteButton() {
    $('.btn-delete').addClass('d-none');
  }

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function(e) {
        $('.program-logo').attr('src', e.target.result);
      }

      reader.readAsDataURL(input.files[0]);
    }
  }

  function showButtonDelete() {
    $('.btn-delete').removeClass('d-none');
  }

})();
