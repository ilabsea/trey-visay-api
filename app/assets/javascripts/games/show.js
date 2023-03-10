"use strict";

TV.GamesShow = (() => {
  return {
    init: init
  }

  function init() {
    onClickSchool();
  }

  function onClickSchool() {
    $('#modal-school').on('show.bs.modal', function (event) {
      var button = $(event.relatedTarget);
      var school = button.data('school');
      var departments = button.data('departments');
      var blankDepartmentMajors = button.data('majors');

      var modal = $(this)
      var arrDom = [];
      _clearDom(modal);
      _renderCommuncations(modal, school);
      _renderDepartmentsWithMajors(modal, departments, arrDom);
      _renderBlankDepartmentMajors(modal, blankDepartmentMajors, arrDom);

      modal.find('.modal-body .departments-with-majors').html(arrDom);
    })
  }

  function _renderCommuncations(modal, school) {
    modal.find('.modal-title').html(school.name);
    modal.find('.modal-header .category').html(school.category);
    modal.find('.modal-body .address').html(_buildCom(school.address, 'map-marker'));
    var numbers = school.phone_numbers.split(';').join(' | ');
    modal.find('.modal-body .phone_numbers').html(_buildCom(numbers, 'earphone'));
    modal.find('.modal-body .faxes').html(_buildCom(school.faxes, 'print'));
    modal.find('.modal-body .emails').html(_buildCom(school.emails, 'envelope'));
    modal.find('.modal-body .mailbox').html(_buildCom(school.mailbox, 'inbox'));
    modal.find('.modal-body .website_or_facebook').html(_buildCom(school.website_or_facebook, 'globe'));
  }

  function _buildCom(text, iconName) {
    if (!text) { return; }

    var dom = $("<div></div>");
    dom.append($('<span class="glyphicon text-primary com-icon"></span>').addClass('glyphicon-'+iconName));
    dom.append(text);

    return dom;
  }

  function _clearDom(modal) {
    modal.find('.modal-body .departments-with-majors').html('');
    modal.find('.modal-body .address').html('');
    modal.find('.modal-body .phone_numbers').html('');
    modal.find('.modal-body .faxes').html('');
    modal.find('.modal-body .emails').html('');
    modal.find('.modal-body .mailbox').html('');
    modal.find('.modal-body .website_or_facebook').html('');
  }

  function _renderDepartmentsWithMajors(modal, departments, arrDom) {
    for (var i=0; i<departments.length; i++) {
      var dom = $("<div></div>").addClass('department').text(departments[i].name);
      var majors = departments[i].majors || [];

      for (var j=0; j< majors.length; j++) {
        var ma = $("<div class='major'></div>")
        ma.append($('<span class="glyphicon glyphicon-education text-primary major-icon"></span>'))
        ma.append(majors[j].name)
        dom.append(ma)
      }
      arrDom.push(dom);
    }
  }

  function _renderBlankDepartmentMajors(modal, blankDepartmentMajors, arrDom) {
    var dom = $('<div></div>');

    for (var i=0; i<blankDepartmentMajors.length; i++) {
      var ma = $("<div class='major'></div>");
      ma.append($('<span class="glyphicon glyphicon-education text-primary major-icon"></span>'));
      ma.append(blankDepartmentMajors[i].name);
      dom.append(ma);
    }

    arrDom.push(dom);
  }
})();
