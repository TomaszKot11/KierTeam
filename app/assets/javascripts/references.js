document.addEventListener("turbolinks:load", function() {
    // makes some assumptions
    // checks the format hwen user stops
    // typing
    var typingTimer;
    // relatively short because programmers
    // type fast :)
    var doneTypingInterval = 1500;
    var $input = $('.references-js');

    // start counting
    $input.keyup(function(){
        clearTimeout(typingTimer);
        if($input.val()){
            typingTimer = setTimeout(checkFormat, doneTypingInterval);
        }
    });

    function checkFormat(){
        var text = $input.val().trim();
        // avoid futher bugs within helper in Rails
        $input.val(text);
        split = text.split(/[\r\n]+/);
        if(split.size == 0){
            makeRedBackground();
            return 1;
        }else if(split.size == 1){
            array = s.split(" ");
            if(array.size == 1){
                if(!isValidURL(array[0])){
                    makeRedBackground();
                }else if(array.size == 2){
                    if(!isValidURL(array[0])){
                       makeRedBackground();
                    }
                }else{
                   makeRedBackground();
                }
            }
            return 1;
        }
        if(split[split.length -1] == "") split.pop();
       for (s of split) {
        s.trim();
        array = s.split(" ");
        // alert(array[0]);
        if (array.size > 2 || array.size < 1 ){
            // wrong
           // alert('errors 1');
             makeRedBackground();
            return 1;
        }else if(array.size == 1){
            // only URL
            if(!isValidURL(array[0])){
                // red
              //  alert('errors 2');
                makeRedBackground();
                return 1;
            }
        }else{
            // both url and name
            if(!isValidURL(array[0])){
                // red
                //alert('errors 3');
                makeRedBackground();
                return 1;
            }
        }

        }

        makeGreenBackground();
      }

      function makeRedBackground(){
        $input.css('background-color','#d9534f');
      }

      function makeGreenBackground(){
        $input.css('background-color','#5cb85c');
      }

    function isValidURL(str) {
        var pattern = new RegExp('^((https?:)?\\/\\/)?'+ // protocol
            '(?:\\S+(?::\\S*)?@)?' + // authentication
            '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ // domain name
            '((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
            '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ // port and path
            '(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
            '(\\#[-a-z\\d_]*)?$','i'); // fragment locater
        if (!pattern.test(str)) {
            return false;
        } else {
            return true;
        }
    }

});