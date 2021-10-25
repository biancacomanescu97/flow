$(window).on("click", ".small", function() {
    me = this;
    setTimeout( function() { $(me).addClass("big"); }, 1 );
});

$(window).on("click", ".big", function() {
    me = this;
    setTimeout( function() { $(me).removeClass("big"); }, 1 );
});