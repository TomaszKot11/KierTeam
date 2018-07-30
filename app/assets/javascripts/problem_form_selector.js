// wait for turbolinks to load
document.addEventListener("turbolinks:load", function() {
    (function() {
            $(function() {
              return $('.chosen-select').chosen({
                allow_single_deselect: true,
                no_results_text: 'No results matched',
            });
        });

    }).call(this);
});