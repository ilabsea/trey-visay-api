"use strict";

TV.Job_clustersNew = (() => {
  return {
    init: init
  }

  function init() {
    TV.Common.Logo.init();
    initVideoTagify();
    initRecommendationRichText();
  }

  function initVideoTagify() {
    var inputElm = $("input.video-list");

    function tagTemplate(tagData){
      return `
          <tag title="${tagData.name}"
                  contenteditable='false'
                  spellcheck='false'
                  tabIndex="-1"
                  class="tagify__tag ${tagData.class ? tagData.class : ""}"
                  ${this.getAttributes(tagData)}>
              <x title='' class='tagify__tag__removeBtn' role='button' aria-label='remove tag'></x>
              <div>
                  <div class='tagify__tag__avatar-wrap'>
                      <img width=24 onerror="this.style.visibility='hidden'" src="${tagData.avatar}">
                  </div>
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
              ${ tagData.avatar ? `
              <div class='tagify__dropdown__item__avatar-wrap'>
                  <img onerror="this.style.visibility='hidden'" src="${tagData.avatar}">
              </div>` : ''
              }
              <strong>${tagData.name}</strong>
          </div>
      `
    }

    function dropdownHeaderTemplate(suggestions){
      return `
          <div class="${this.settings.classNames.dropdownItem} ${this.settings.classNames.dropdownItem}__addAll">
              <strong>${this.value.length ? `Add remaning ${suggestions.length}` : 'Add All'}</strong>
              <span>${suggestions.length} members</span>
          </div>
      `
    }

    // initialize Tagify on the above input node reference
    var tagify = new Tagify(inputElm[0], {
      tagTextProp: 'name', // very important since a custom template is used with this property as text
      enforceWhitelist: true,
      skipInvalid: true, // do not remporarily add invalid tags
      dropdown: {
        closeOnSelect: false,
        enabled: 0,
        classname: 'items-list',
        searchKeys: ['value', 'name']  // very important to set by which keys to search for suggesttions when typing
      },
      templates: {
        tag: tagTemplate,
        dropdownItem: suggestionItemTemplate,
        dropdownHeader: dropdownHeaderTemplate
      },
      whitelist: inputElm.data('tags')
    })

    tagify.on('add', onAddTag);
    tagify.on('remove', onRemoveTag);

    function onAddTag(e) {
      inputBuilder(e.detail.data).insertAfter(inputElm);
    }

    function inputBuilder(data) {
      return $(`<input class="${tagify_class(data.value)}"
                  type="hidden"
                  name="job_cluster[video_ids][]"
                  value="${data.value}" />`);
    }

    function onRemoveTag(e) {
      $(`.${tagify_class(e.detail.data.value)}`).remove();
    }

    function tagify_class(value) {
      return 'tagify-item-' + value;
    }
  }

  function initRecommendationRichText() {
    $('#job_cluster_recommendation').richText({
      // text formatting
      bold: true,
      italic: true,
      underline: true,

      // text alignment
      leftAlign: true,
      centerAlign: true,
      rightAlign: true,
      justify: true,

      // lists
      ol: true,
      ul: true,

      // title
      heading: false,

      // fonts
      fonts: false,
      fontList: ["Arial",
        "Arial Black",
        "Comic Sans MS",
        "Courier New",
        "Geneva",
        "Georgia",
        "Helvetica",
        "Impact",
        "Lucida Console",
        "Tahoma",
        "Times New Roman",
        "Verdana"
      ],
      fontColor: false,
      fontSize: false,

      // uploads
      imageUpload: false,
      fileUpload: false,

      // media
      videoEmbed: false,

      // link
      urls: false,

      // tables
      table: true,

      // code
      removeStyles: false,
      code: true,

      // colors
      colors: [],

      // dropdowns
      fileHTML: '',
      imageHTML: '',

      // privacy
      youtubeCookies: false,

      // preview
      preview: false,

      // placeholder
      placeholder: '',

      // dev settings
      useSingleQuotes: false,
      height: 0,
      heightPercentage: 0,
      id: "",
      class: "",
      useParagraph: false,
      maxlength: 0,
      useTabForNext: false,

      // callback function after init
      callback: undefined,
    });
  }
})();

TV.Job_clustersCreate = TV.Job_clustersNew
TV.Job_clustersEdit = TV.Job_clustersNew
TV.Job_clustersUpdate = TV.Job_clustersNew
