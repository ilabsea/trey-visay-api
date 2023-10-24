TV.AccountsNew = do ->
  TARGET_ROLE = "counselor"

  init = ->
    initDisplayLocalNgo()
    onChangeRole()
    onSubmitForm()

  onSubmitForm = ->
    $(".simple_form").on "submit", (e) ->
      if $("#account_role").val() == TARGET_ROLE
        $("[name='account[province_ids][]']").remove();

      return true;

  initDisplayLocalNgo = ->
    if !!$('.role').val() && $('.role').val() == TARGET_ROLE
      showSchool()

  onChangeRole = ->
    $('.role').off('change')
    $('.role').on 'change', (event) ->
      role = event.target.value
      handleDisplaySchool(role)

  handleDisplaySchool = (role) ->
    if role == TARGET_ROLE
      showSchool()
      hideProvinces()
    else if role == "trainer"
      hideSchool()
      showProvinces()
    else
      hideSchool()
      hideProvinces()

  showProvinces = () ->
    $('.provinces').removeClass('d-none')

  hideProvinces = () ->
    $('.provinces').addClass('d-none')

  showSchool = ->
    $('.school').removeClass('d-none')

  hideSchool = ->
    $('.school').addClass('d-none')
    $('.school select').val('')

  { init: init }

TV.AccountsCreate = TV.AccountsNew
TV.AccountsEdit = TV.AccountsNew
TV.AccountsUpdate = TV.AccountsNew
