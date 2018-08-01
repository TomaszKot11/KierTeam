document.addEventListener("turbolinks:load", function() {

    var typingTimer;
    var doneTypingInterval = 1500;
    var $input = $('.references-js');

    // start counting
    $input.keyup(function(){
        clearTimeout(typingTimer);
        if($input.val()){
            typingTimer = setTimeout(trimReferences, doneTypingInterval);
        }
    });

    // trim text to avoid futher bugs
    function trimReferences(){
        var text = $input.val().trim();
        $input.val(text);
    }
});
