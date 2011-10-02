/*
*   jQuery.stickyPanel
*   ----------------------
*   version: 1.3.0
*   date: 7/21/11
*
*   Copyright (c) 2011 Donny Velazquez
*   http://donnyvblog.blogspot.com/
*   http://code.google.com/p/sticky-panel/
*   
*   Licensed under the Apache License 2.0
*
*/
(function ($) {

    $.fn.stickyPanel = function (options) {

        var options = $.extend({}, $.fn.stickyPanel.defaults, options);

        return this.each(function () {
            $(window).bind("scroll.stickyPanel", { selected: $(this), options: options }, Scroll);
        });

    };

    function Scroll(event) {
        var node = event.data.selected;
        var o = event.data.options;


        // when top of window reaches the top of the panel detach
        if ($(document).scrollTop() > node.offset().top - o.topPadding) {

            // topPadding
            var top = 0;
            if (o.topPadding != "undefined") {
                top = top + o.topPadding;
            }

            // get left before adding spacer
            var left = node.offset().left;

            // save panels top
            node.data("PanelsTop", node.offset().top - top);

            // afterDetachCSSClass
            if (o.afterDetachCSSClass != "") {
                node.addClass(o.afterDetachCSSClass);
            }

            // savePanelSpace
            if (o.savePanelSpace == true) {
                var width = node.outerWidth(true);
                var height = node.outerHeight(true);
                var cssfloat = node.css("float");
                var cssdisplay = node.css("display");
                var randomNum = Math.ceil(Math.random() * 9999); /* Pick random number between 1 and 9999 */
                node.data("PanelSpaceID", "stickyPanelSpace" + randomNum);
                node.before("<div id='" + node.data("PanelSpaceID") + "' style='width:" + width + "px;height:" + height + "px;float:" + cssfloat + ";display:" + cssdisplay + ";'>&nbsp;</div>");
            }

            // save inline css
            node.data("Original_Inline_CSS", (!node.attr("style") ? "" : node.attr("style")));

            // detach panel
            node.css({
                "margin": 0,
                "left": left,
                "top": top,
                "position": "fixed"
            });

        }

        if ($(document).scrollTop() <= node.data("PanelsTop")) {

            if (o.savePanelSpace == true) {
                $("#" + node.data("PanelSpaceID")).remove();
            }

            // attach panel
            node.attr("style", node.data("Original_Inline_CSS"));

            if (o.afterDetachCSSClass != "") {
                node.removeClass(o.afterDetachCSSClass);
            }
        }

    };

    $.fn.stickyPanel.defaults = {
        topPadding: 0,
        // Use this to set the top margin of the detached panel.

        afterDetachCSSClass: "",
        // This class is applied when the panel detaches.

        savePanelSpace: false
        // When set to true the space where the panel was is kept open.
    };

})(jQuery);