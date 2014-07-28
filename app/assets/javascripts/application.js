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

var fade = function(node) {
    var level = 1;
    var opacity = 0;
    var step = function(){
        var hex = level.toString(16);
        opacity += 0.05;
        node.style.backgroundColor = "rgba(226, 60, 60, " + opacity + ")";
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
                node_set[i].style.fontWeight = "900";
            };
        }(i);
        node_set[i].onmouseout = function(i){
            return function() {
                node_set[i].style.fontWeight = "normal";
            };
        }(i);
    }
}


var text = function(node){
    var level = 0;
    var times = 2;
    var sayings = ["Stop worrying about the weather", "Stop worrying about the future", "Stop checking your phone", "Be in the moment"];
    var loop = function(){
        node.innerHTML = sayings[level];
        if (level < 3) {
            level += 1;
            setTimeout(loop, 1500);
        } else {
            level = 0;
            times -= 1;
            if (times !== 0) {
                setTimeout(loop, 1500);
            }
        }
    }
    setTimeout(loop, 100);
}

$(document).on('page:change', function() {
    fade(document.getElementsByClassName("nav_bar")[0]);
    hover(document.getElementsByClassName("nav_el"));
    hover(document.getElementsByClassName("action"));
    if (document.getElementById("light") !== null) {
        text(document.getElementById("light"));
    }
});
