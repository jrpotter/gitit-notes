$(function() {

    /**
     * Allow toggling displays of blocks of text.
     * View the HideShow plugin for usage.
    */
    $('div.proof').each(function() {
        var that = $(this);
        that.find('.proof-icon').click(function() {
            that.find('.pane').toggleClass('hidden');
            $(this).text($(this).hasClass('plus') ? '-' : '+');
            $(this).toggleClass('plus').toggleClass('minus');
            that.find('.header').toggleClass('plus').toggleClass('minus');
        });
    });

});
