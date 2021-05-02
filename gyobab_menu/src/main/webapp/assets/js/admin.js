var resizefunc = [];

!function($) {
    "use strict";
	
    var Sidemenu = function() {
        this.$body = $("body"),
        this.$openLeftBtn = $(".open-left"),
        this.$menuItem = $("#sidebar-menu a")
    };
    Sidemenu.prototype.openLeftBar = function() {
      console.log("zzzz")
      $("#main").toggleClass("enlarged");
      $("#main").addClass("forced");

      if($("#main").hasClass("enlarged") && $("body").hasClass("adminbody")) {
        $("body").removeClass("adminbody").addClass("adminbody-void");
      } else if(!$("#main").hasClass("enlarged") && $("body").hasClass("adminbody-void")) {
        $("body").removeClass("adminbody-void").addClass("adminbody");
      }

      if($("#main").hasClass("enlarged")) {
        $(".left ul").removeAttr("style");
      } else {
        $(".subdrop").siblings("ul:first").show();
      }

    },

    //init sidemenu
    Sidemenu.prototype.init = function() {
      var $this  = this;

      var ua = navigator.userAgent,
        event = (ua.match(/iP/i)) ? "touchstart" : "click";

      //bind on click
      this.$openLeftBtn.on(event, function(e) {
        e.stopPropagation();
        $this.openLeftBar();
      });

      // LEFT SIDE MAIN NAVIGATION
      $this.$menuItem.on(event, $this.menuItemClick);

      // NAVIGATION HIGHLIGHT & OPEN PARENT
      $("#sidebar-menu ul li.submenu a.active").parents("li:last").children("a:first").addClass("active").trigger("click");
    },

    //init Sidemenu
    $.Sidemenu = new Sidemenu, $.Sidemenu.Constructor = Sidemenu

}(window.jQuery),


//main app module
 function($) {
    "use strict";

    var App = function() {        
        this.pageScrollElement = "html, body",
        this.$body = $("body")
    };

     //on doc load
    App.prototype.onDocReady = function(e) {
      resizefunc.push("changeptype");

      $('.animate-number').each(function(){
        $(this).animateNumbers($(this).attr("data-value"), true, parseInt($(this).attr("data-duration")));
      });

      //RUN RESIZE ITEMS
      $(window).resize(debounce(resizeitems,100));
      $("body").trigger("resize");


    },
    //initilizing
    App.prototype.init = function() {
        var $this = this;
        $(document).ready($this.onDocReady);
        $.Sidemenu.init();
    },

    $.App = new App, $.App.Constructor = App

}(window.jQuery),

//initializing main application module
function($) {
    "use strict";
    $.App.init();
}(window.jQuery);


function executeFunctionByName(functionName, context) {
  var args = [].slice.call(arguments).splice(2);
  var namespaces = functionName.split(".");
  var func = namespaces.pop();
  for(var i = 0; i < namespaces.length; i++) {
    context = context[namespaces[i]];
  }
  return context[func].apply(this, args);
}
var w,h,dw,dh;
var changeptype = function(){
    w = $(window).width();
    h = $(window).height();
    dw = $(document).width();
    dh = $(document).height();

    if(jQuery.browser.mobile === true){
        $("body").addClass("mobile").removeClass("adminbody");
    }

    if(!$("#main").hasClass("forced")){
      if(w > 990){
        $("body").removeClass("smallscreen").addClass("widescreen");
          $("#main").removeClass("enlarged");
      }else{
        $("body").removeClass("widescreen").addClass("smallscreen");
        $("#main").addClass("enlarged");
        $(".left ul").removeAttr("style");
      }
      if($("#main").hasClass("enlarged") && $("body").hasClass("adminbody")){
        $("body").removeClass("adminbody").addClass("adminbody-void");
      }else if(!$("#main").hasClass("enlarged") && $("body").hasClass("adminbody-void")){
        $("body").removeClass("adminbody-void").addClass("adminbody");
      }

  }
  
}


var debounce = function(func, wait, immediate) {
  var timeout, result;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) result = func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) result = func.apply(context, args);
    return result;
  };
}

function resizeitems(){
  if($.isArray(resizefunc)){
    for (i = 0; i < resizefunc.length; i++) {
        window[resizefunc[i]]();
    }
  }
}
