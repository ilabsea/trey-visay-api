"use strict";

TV.SchoolsNew = (() => {
  return {
    init: init
  }

  function init() {
    TV.Common.Logo.init();

    initMajorList();
    onClickAddAssociation();
    onClickRemoveField();
  }

  function initMajorList() {
    let doms = $(".fieldset")
    for(let i=0; i<doms.length; i++) {
      TV.Common.tagList.init($(doms[i]).find('.major-list'))
    }
  }

  function onClickAddAssociation(css_class) {
    if (css_class == null) {
      css_class = 'form .add_association';
    }
    $(document).off('click', css_class);
    $(document).on('click', css_class, function(event) {
      appendField(this);
      return event.preventDefault();
    });
  };

  function onClickRemoveField() {
    $(document).on('click', 'form .remove_fields', function(event) {
      event.preventDefault();
      removeField(this);
    });
  };

  function appendField(dom) {
    var time = new Date().getTime();
    var regexp = new RegExp($(dom).data('id'), 'g');
    var field = $($(dom).data('fields').replace(regexp, time));
    $(dom).before(field);

    if (!!$(field).find('.major-list').length) {
      TV.Common.tagList.init($(field).find('.major-list'))
    }

    return field;
  };

  function removeField(dom) {
    $(dom).parent().find('input[type=hidden]').val('1');
    $(dom).closest('fieldset').hide();
  };
})();

TV.SchoolsCreate = TV.SchoolsNew
TV.SchoolsEdit = TV.SchoolsNew
TV.SchoolsUpdate = TV.SchoolsNew
