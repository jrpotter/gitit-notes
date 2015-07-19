$(function() {

    // Proof Plugin
    // ==================================================
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

    // Excerpt Plugin
    // ================================================k
    // ...

    // Icon Plugin
    // ==================================================
    // Plugins do not allow manipulating outside of content
    // so the plugin appends the icon and the js replaces the logo
    +function() {
        var icon = $('#toc-icon').remove();
        if(icon.length > 0) {
            $('#logo').find('img')
                      .attr('src', icon.attr('src'))
                      .addClass('toc-icon');
        }
    }();

    // Sidebar Follow
    // ==================================================
    // The following ensures that the site navigation follows
    // the scroll view for quick access
    +function() {
        var sitenav = $('.sitenav');
        var position = sitenav.position().top;
        $(window).scroll(function() {
            var scrollTop = $(window).scrollTop();
            if(scrollTop <= position) {
                sitenav.css('margin-top', 0);
            } else {
                sitenav.css('margin-top', scrollTop - position);
            }
        });
    }();

});
