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
            typingTimer = setTimeout(trimReferences, doneTypingInterval);
        }
    });

    // trim text to avoid futher bugs
    function trimReferences(){
        var text = $input.val().trim();
        $input.val(text);
    }
// //TODO: some bugs when www.google.pl text text
// // TODO: shorter
// //  NIGHTMARE !
//     function checkFormat(){
//         var text = $input.val().trim();
//         // avoid futher bugs within helper in Rails
//         $input.val(text);
//         split = text.split(/[\r\n]+/);
//         if(split.size == 0){
//             makeRedBackground();
//             return false;
//         }else if(split.size == 1){
//             array = s.split(" ");
//             if(array.size == 1){
//                 if(!isValidURL(array[0])){
//                     makeRedBackground();
//                 }else if(array.size == 2){
//                     if(!isValidURL(array[0])){
//                        makeRedBackground();
//                     }
//                 }else{
//                    makeRedBackground();
//                 }
//             }
//             return false;
//         }
//         if(split[split.length -1] == "") split.pop();
//        for (s of split) {
//         s.trim();
//         array = s.split(" ");
//         if (array.size > 2 || array.size < 1 ){
//              makeRedBackground();
//             return false;
//         }else if(array.size == 1){

//             if(!isValidURL(array[0])){
//                 makeRedBackground();
//                 return false;
//             }
//         }else{
//             if(!isValidURL(array[0])){
//                 makeRedBackground();
//                 return false;
//             }
//         }

//         }

//         makeGreenBackground();
//         return true;
//       }

//       function makeRedBackground(){
//         $input.css('background-color','#d9534f');
//       }

//       function makeGreenBackground(){
//         $input.css('background-color','#5cb85c');
//       }

//     function isValidURL(str) {
//         var pattern = new RegExp('^((https?:)?\\/\\/)?'+ // protocol
//             '(?:\\S+(?::\\S*)?@)?' + // authentication
//             '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ // domain name
//             '((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
//             '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ // port and path
//             '(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
//             '(\\#[-a-z\\d_]*)?$','i'); // fragment locater
//         if (!pattern.test(str)) {
//             return false;
//         } else {
//             return true;
//         }
//     }

//     // code benath prevents form from being submitted
//     // when reference_list have not valid format

//     // $('#new_problem_id').submit(function(e){
//     // //   console.log('Validating form...');
//     // //   //stop submission
//     // //
//     //     //  var inputText = ;
//     //      var inputText = $('.references-js').val();
//     //      if(checkFormat(inputText)){
//     //         e.currentTarget.submit();
//     //         console.log(checkFormat(inputText));
//     //      }else{
//     //         e.preventDefault();
//     //         console.log(checkFormat(inputText));
//     //         // temporary page reload
//     //         window.location.reload();
//     //      }
//     // });



//     // var foo = function(e) {
//     //     e.preventDefault();
//     //     console.log('Witam bardzo serdecznie.');
//     //  };
//     //  $('.submit-creation-js').click(function(){
//     //      console.log('witam');
//     //  });
});