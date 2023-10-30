document.addEventListener 'turbolinks:load', ->
  pumi.setup()

pumi =
  dataAttributeTag: (attribute, selector) ->
    tag = "pumi-select-#{attribute}"
    tag = if !!selector then "[data-#{tag}]" else tag

  setDataAttribute: (element, attribute, value) ->
    element.data(pumi.dataAttributeTag(attribute), value)

  getDataAttribute: (element, attribute, value) ->
    element.data(pumi.dataAttributeTag(attribute))

  removeDataAttribute: (element, attribute) ->
    element.removeData(pumi.dataAttributeTag(attribute))

  toggleEnableSelect: (select, enable) ->
    wrapperTarget = select.closest(pumi.getDataAttribute(select, 'disabled-target'))
    disabledClass = pumi.getDataAttribute(select, 'disabled-class')

    if !!enable
      wrapperTarget.removeClass(disabledClass)
      select.removeAttr("disabled")
    else
      wrapperTarget.addClass(disabledClass)
      select.attr("disabled", "disabled")

  selectPopulateOnLoad: ->
    $(pumi.dataAttributeTag('populate-on-load', true))

  selectTargets: ->
    $(pumi.dataAttributeTag('id', true))

  selectHasTarget: ->
    $(pumi.dataAttributeTag('target', true))

  selectTarget: (id) ->
    $(pumi.dataAttributeTag("id=#{id}", true))

  selectHasHiddenValue: =>
    $(pumi.dataAttributeTag('has-hidden-value', true))

  setupOnLoad: ->
    pumi.selectPopulateOnLoad().each ->
      pumi.populateFromAjax($(this))

    pumi.selectHasHiddenValue().each ->
      select = $(this)
      value = $($.find("[name='#{select.attr('name')}']")).val()

      # Custom here to support multiple select
      if select.prop('multiple')
        value = select.data(pumi.dataAttributeTag('hidden-values'))

      pumi.setDataAttribute(select, 'default-value', value)

  populateFromAjax: (select, filterValue) ->
    collectionUrl = pumi.getDataAttribute(select, 'collection-url')
    if !!collectionUrl
      filterInterpolationKey = pumi.getDataAttribute(select, 'collection-url-filter-interpolation-key')
      labelMethod = pumi.getDataAttribute(select, 'collection-label-method')
      valueMethod = pumi.getDataAttribute(select, 'collection-value-method')
      $.getJSON collectionUrl.replace(filterInterpolationKey, filterValue), (data) ->
        $.each data, (index, item) ->
          select.append($('<option>').text(item[labelMethod]).val(item[valueMethod]))

        if pumi.getDataAttribute(select, 'allow-none')
          option = { en: 'None', km: 'មិនមាន' }
          languageCode = $("[data-language-code]").data('languageCode') || 'en'
          select.append($('<option>').text(option[languageCode]).val('none'))

        defaultValue = pumi.getDataAttribute(select, 'default-value')
        if !!defaultValue
          select.val(defaultValue)
          pumi.removeDataAttribute(select, 'default-value')
          select.trigger("change")

  setupTargets: (selects) ->
    selects.each ->
      select = $(this)
      options = []
      select.find('option').each ->
        options.push
          value: @value
          text: @text

      pumi.setDataAttribute(select, 'options', options)
      pumi.toggleEnableSelect(select, false)

  resetSelectAndHiddenInput: (select) ->
    $($.find("[name='#{select.attr('name')}']")).val(null)

  filterSelectByValue: (select, filterValue) ->
    staticPumiOptions = pumi.getDataAttribute(select, 'options')
    select.empty()

    pumi.toggleEnableSelect(select, !!filterValue)
    select.trigger("change")

    $.each staticPumiOptions, (i) ->
      pumiOption = staticPumiOptions[i]

      # គ្រប់សាលា គ្របស្រុក/ខណ្ឌ
      if !pumiOption.value || pumiOption.value.match(///^#{filterValue}///)
        select.append($('<option>').text(pumiOption.text).val(pumiOption.value))

        pumi.resetSelectAndHiddenInput(select)

    pumi.populateFromAjax(select, filterValue) if !!filterValue

  setup: ->
    pumi.setupOnLoad()
    pumi.setupTargets(pumi.selectTargets())

    pumi.selectHasTarget().change ->
      pumi.filterSelectByValue(pumi.selectTarget(pumi.getDataAttribute($(this), 'target')), @value)
