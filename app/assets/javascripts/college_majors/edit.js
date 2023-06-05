"use strict";

TV.College_majorsEdit = (() => {
  return {
    init
  }

  function init() {
    assignValueToTagsInput();
    initTagify();
    onSubmitForm();
  }

  function onSubmitForm() {
    $('.edit_college_major').submit(()=> {
      assignMajorValues();
    });
  }

  function assignMajorValues() {
    $("input[type=checkbox]").prop('checked', false);

    let majors = $("tag").map((i, dom) => $(dom).attr('value')).toArray();
    for(let i=0; i < majors.length; i++) {
      $(`input[type=checkbox][value=${majors[i]}]`).prop('checked', true);
    }
  }

  function initTagify() {
    var tagify = new Tagify(document.querySelector('.tag-input'), {
        templates : {
            tag : tagTemplate,
            dropdownItem : suggestionItemTemplate
        },
        enforceWhitelist : true,
        whitelist : $('.tag-input').data('collection').map(x => ({value: x.id, name: x.name})),
        dropdown : {
            enabled: 1, // suggest tags after a single character input
            classname : '', // custom class for the suggestions dropdown
            enabled: 0,
            closeOnSelect: false,
            searchKeys: ['name'],
        },
        originalInputValueFormat: (valuesArr) => valuesArr.map(item => item.value)
    })
  }

  function assignValueToTagsInput() {
    var selectedMajors = $('input[name="college_major[major_ids][]"]:checked').map(function() {return this.value}).toArray();
    var majors = $('.tag-input').data('collection').map(x => ({value: x.id, name: x.name}));
    var data = majors.filter(x => selectedMajors.includes(x.value + ""));
    console.log(data)

    $('.tag-input').val(JSON.stringify(data))
  }

  function tagTemplate(tagData){
    return `
        <tag title="${(tagData.title || tagData.email)}"
                contenteditable='false'
                spellcheck='false'
                tabIndex="-1"
                class="${this.settings.classNames.tag} ${tagData.class ? tagData.class : ""}"
                ${this.getAttributes(tagData)}>
            <x title='' class='tagify__tag__removeBtn' role='button' aria-label='remove tag'></x>
            <div>
                <span class='tagify__tag-text'>${tagData.name}</span>
            </div>
        </tag>
    `
  }

  function suggestionItemTemplate(tagData){
    return `
        <div ${this.getAttributes(tagData)}
            class='tagify__dropdown__item ${tagData.class ? tagData.class : ""}'
            tabindex="0"
            role="option">
            <strong>${tagData.name}</strong>
        </div>
    `
  }

})();

TV.College_majorsUpdate = TV.College_majorsEdit
