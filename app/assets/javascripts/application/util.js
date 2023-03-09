TV.Util = {
  capitalize: function(value) {
    return value.replace(/(^|\s)([a-z])/g, function(m, p1, p2) {
      return p1 + p2.toUpperCase();
    });
  },
  getCurrentPage: function() {
    var action, bodyId, controller, i, pageName;
    if (!$("body").attr("id")) {
      return "";
    }
    bodyId = $("body").attr("id").split("-");
    action = this.capitalize(bodyId.pop());
    controller = bodyId;
    i = 0;
    while (i < controller.length) {
      controller[i] = this.capitalize(controller[i]);
      i++;
    }
    pageName = controller.join("") + action;
    return pageName;
  }
};
