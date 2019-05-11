$( document ).ready(function() {
    $("#selection").change(function(){
        window.location.replace($('#selection').val()+window.location.search);
    });
});