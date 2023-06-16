TV.Common.Sidebar = (() => {
  return {
    init
  }

  function init() {
    toggleCollapseContent()
  }

  function toggleCollapseContent() {
    $( ".collapse-inner" ).each(function( index ) {
      if (!!$( this ).find(".active").length) {
        $(this).parents('li').addClass('active');
        $(this).parent().addClass('show');
      }
    });
  }
})();
