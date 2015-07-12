$(function() {

    // Allow toggling displays of blocks of text.
    $('div.proof').each(function() {
        var that = $(this);
        that.find('.proof-icon').click(function() {
            that.find('.pane').toggleClass('hidden');
            $(this).text($(this).hasClass('plus') ? '-' : '+');
            $(this).toggleClass('plus').toggleClass('minus');
            that.find('.header').toggleClass('plus').toggleClass('minus');
        });
    });

    // Moves icon to table of contents
    // Plugins do not allow manipulating outside of content
    $('#TOC').prepend($('<div id="toc-icon-wrapper">')
             .append($('#toc-icon').remove()));

});
