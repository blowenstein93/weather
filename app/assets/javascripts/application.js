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
    var ele = document.getElementsByTagName("li")[4];
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

var fade = function(node) {
    var level = 1;
    var opacity = 0;
    var step = function(){
        var hex = level.toString(16);
        opacity += 0.05;
        node.style.backgroundColor = "rgba(99, 99, 122, " + opacity + ")";

        if (level < 20) {
            level += 1;
            setTimeout(step, 50);
        }
    };
    setTimeout(step, 100);
}


var hover = function(node_set){
    var i;
    var length = node_set.length;
    for (i =0; i < length; i++){
        node_set[i].onmouseover = function(i){
            return function() {
                console.log("on" + node_set[i])
                node_set[i].style.backgroundColor = "#6E6E6E";
                node_set[i].style.borderRadius = "5px";

            };
        }(i);
        node_set[i].onmouseout = function(i){
            return function() {
                console.log("off" + node_set[i])
                node_set[i].style.backgroundColor = "";
            };
        }(i);
    }
}

window.onload = function() {
    fade(document.getElementsByClassName("nav_bar")[0]);
    hover(document.getElementsByClassName("nav_el"));
}
