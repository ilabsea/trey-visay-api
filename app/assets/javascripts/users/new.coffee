TV.AccountsNew = do ->
  TARGET_ROLE = "counselor"

  init = ->
    initDisplayLocalNgo()
    onChangeRole()

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
    else
      hideSchool()

  showSchool = ->
    $('.school').removeClass('d-none')

  hideSchool = ->
    $('.school').addClass('d-none')
    $('.school select').val('')

  { init: init }

TV.AccountsCreate = TV.AccountsNew
TV.AccountsEdit = TV.AccountsNew
TV.AccountsUpdate = TV.AccountsNew
