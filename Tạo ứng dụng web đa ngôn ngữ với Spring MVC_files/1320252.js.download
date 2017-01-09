/* TemplageFragmentId=1320155  Main (For All) ****/
$(document).ready(function() {
   var hostname = new RegExp(location.host);



   $('a').each(function() {

       var url = $(this).attr("href");
       var target = $(this).attr("target");
       if (url) {
           // Test if current host (domain) is in it
           if (hostname.test(url)) {
               // If it's local...
               // $(this).addClass('internal-url');
           } else if (url.slice(0, 1) == "/") {
               // $(this).addClass('internal-url');
           } else if (url.slice(0, 1) == "#") {
               // It's an anchor link
               $(this).addClass('internal-page-anchor');
               $(this).removeAttr("href");
               $(this).attr("data-href", url);
           } else {
               // a link that does not contain the current host
               // $(this).attr("target", "_blank");
               // $(this).addClass('external-url');
           }
       }
       if (target == "_blank") {
           if ($(this).children().length == 0) {
               $(this).addClass('target-blank-url');
           }
       }
   });


   $("a").click(function() {

       var href = $(this).attr("data-href");

       if (href) {
           location.href = href;
       }
   });

   // SLIDER
   $(".owl-carousel").owlCarousel({

       slideSpeed: 300,
       paginationSpeed: 400,
       pagination: true,
       singleItem: true

       // Show next and prev buttons
       // navigation : true,
       // singleItem:true
       // autoPlay:3000,
       // items : 1,
       // itemsDesktop : false,
       // itemsDesktopSmall : false,
       // itemsTablet: false,
       // itemsMobile : false

   });

   $("#style-switcher a[name='top']").remove();

   /*
   setTimeout(function(){

   if (!$('#style-switcher').hasClass('active')){
       $('#style-switcher-toggle').addClass('autoclick').click();
   }

   }, 10000);
   */

   $('#style-switcher-toggle').on('click', function(e) {
       $(this).removeClass('autoclick');
       var panel = $(this).parents('#style-switcher');
       if (panel.hasClass('active')) {
           panel.animate({
               right: -335
           }, 335);
           panel.removeClass('active');
           $('#style-switcher-toggle').removeClass("on");
           $('#style-switcher-toggle').addClass("off");
       } else {
           panel.addClass('active');
           panel.animate({
               right: 0
           }, 335);
           $('#style-switcher-toggle').removeClass("off");
           $('#style-switcher-toggle').addClass("on");
       }
   });

   $("div.cat-entry > ul").each(function() {

       if ($(this).children().length == 0) {
           $(this).parent().hide();
       }
   });

});


$('.item-data img').error(function() {
   var src = $(this).attr('src');
   if (window.console) {
       console.log('reload image ' + src);
   }
   var i = src.indexOf("&random=");
   if (i > -1) {
       src = src.substring(0, i);
   }
   i = src.indexOf("?random=");
   if (i > -1) {
       src = src.substring(0, i);
   }
   if (src.indexOf('?') > -1) {
       src = src + "&random=" + (new Date().getTime());
   } else {
       src = src + "?random=" + (new Date().getTime());
   }
   $(this).delay(10000).attr('src', src);
});
