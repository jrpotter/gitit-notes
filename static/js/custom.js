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

    // Moves icon to top right
    // Plugins do not allow manipulating outside of content
    +function() {
        var icon = $('#toc-icon').remove();
        if(icon.length > 0) {
            $('#logo').find('img')
                      .attr('src', icon.attr('src'))
                      .addClass('toc-icon');
        }
    }();

});
