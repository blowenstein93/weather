// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function hide_signin(){
    var ele = document.getElementsByTagName("li")[2];
        if (ele.className.indexOf("hide") == -1) {
            ele.className =  "hide";
        } else if (ele.className.indexOf("hide") > -1) {
            ele.className = "link"
        }


}

$(document).ready(function(){
    if (window.location.pathname.indexOf("users") || window.location.pathname.indexOf("weathers/new")) {
        hide_signin();
    }
});
