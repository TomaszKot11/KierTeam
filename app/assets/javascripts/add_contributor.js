$(function() {
 
    $('#addContributorID').click(function () {
           $('#newProblemID').append("<%= escape_javascript(render 'add_contributor_block') %>");
    });


} );