// http://jsbeautifier.org/
 var CKEDITOR_CONFIG_0 = {
     height: "380px",
     enterMode: CKEDITOR.ENTER_BR,
     removePlugins: 'elementspath',
     extraPlugins: 'codesnippet,base64image',
     codeSnippet_theme: 'mono-blue',
     toolbar: [
         ['CodeSnippet', 'Styles', 'Bold', 'Italic', 'base64image'],
         ['Link', 'Unlink', 'Anchor'],
         ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']

     ]
 };

 var CKEDITOR_CONFIG_1 = {
     height: "80px",
     enterMode: CKEDITOR.ENTER_BR,
     removePlugins: 'elementspath',
     resize_enabled: false,
     extraPlugins: 'codesnippet,base64image',
     toolbar: [
         ['Styles', 'Bold', 'Italic']
     ]
 };

 function getEndNumber(str) {
     var idx = str.lastIndexOf('-');
     return parseInt(str.substring(idx + 1));
 }

 function showCKEDITOR(parentId) {
     $("#" + parentId + "  textarea.editor1").ckeditor(
         CKEDITOR_CONFIG_1
     );
     $("#" + parentId + " textarea.editor0").ckeditor(
         CKEDITOR_CONFIG_0
     );
 }

 // Kiem tra login.
 function isLogined() {
     var result = false;
     $.ajax({
         url: CHECK_LOGINED_URL,
         async: false
     }).
     done(function(data) {
         var div = $(data).filter("#thirdUserId");
         if (div.length > 0) {
             result = true;
         } else {
             result = false;
         }
     }).fail(function(xhr) {
         alert("check login fail " + xhr.responseText);
         return false;
     });
     return result;
 }


 $(document).ready(function() {

     $("textarea#editor0").ckeditor(
         CKEDITOR_CONFIG_0
     );
     $("textarea#editor1").ckeditor(
         CKEDITOR_CONFIG_1
     );

     // Issue Product Component Change.
     $('body').on("change", "select[name='productComponentId']", function() {
         var option = $(this).find(":selected");
         var desc = option.attr("description");
         if (desc) {
             $("#issue-product-component-desc").html(desc);
         } else {
             $("#issue-product-component-desc").html("&nbsp;");
         }
     });



     // Create Issue Topic : combobox issue product change.
     $("select[name='productId']").on("change", function() {
         var option = $(this).find(":selected");
         var value = option.attr("value");

         $("#issue-product-version-container > select").empty();
         $("#issue-product-component-container > select").empty();
         if (value == "") {
             return;
         }
         var url = option.attr("ajaxUrl");

         $.post(url).done(function(data) {
             $("#issue-product-version-container").html($(data).find("[name='productVersionId']"));
             $("#issue-product-component-container").html($(data).find("[name='productComponentId']"));
         }).fail(function() {
             alert("error");
         })

     });

     $("#form-issue-message").submit(function(event) {

         var content = $(this).find("textarea[name='messageContent']").val();
         if (content.length < 20) {
             alert("Minimum 20 characters");
             return false;
         }
         var isLogin = isLogined();
         if (!isLogin) {
             alert("Please login first");
             window.open(LOGIN_URL);
             return false;
         }
     });

     $("#form-issue-topic").submit(function() {
         if ($("#form-issue-topic [name='productId']").length == 0 || !$("#form-issue-topic [name='productId']").val()) {
             alert("Required");
             return false;
         }
         if ($("#form-issue-topic  [name='productComponentId']").length == 0 || !$("#form-issue-topic  [name='productComponentId']").val()) {
             alert("Required");
             return false;
         }

         if ($("#form-issue-topic input[name='topicTitle']").val().length < 10) {
             alert("Title to short");
             return false;
         }
         if ($("#form-issue-topic textarea[name='topicContent']").val().length < 20) {
             alert("Content minimum 20 characters");
             return false;
         }
         var isLogin = isLogined();
         if (!isLogin) {
             alert("Please login first");
             window.open(LOGIN_URL);
             return false;
         }

     });

     // Save comment!
     $('body').on("submit", "div[id^='comment-form-container-'] > form", function(event) {
         event.preventDefault();
         var isLogin = isLogined();
         if (!isLogin) {
             alert("Please login first");
             window.open(LOGIN_URL);
             return false;
         }

         var $form = $(this);
         var commentContent = $form.find("textarea").val();

         if (!commentContent || commentContent.length < 15) {
             alert("Please type content, min 15 characters");
             return;
         }
         var url = $form.attr("action");
         // Send the data using post

         var postData = $form.serializeArray();
         var posting = $.post(url, postData);
         // Put the results in a div
         posting.done(function(data) {
             var divId = $(data).filter("div[id^='comment-']").attr("id");
             var hiddenDiv = $form.parent().siblings(".comments").find("#" + divId);
             if (hiddenDiv.length != 0) {
                 hiddenDiv.replaceWith(data);
             } else
             if (hiddenDiv.length == 0) {
                 $form.parent().siblings(".comments").append(data);
             }
             $form.parent().empty();
         });
         posting.fail(function(data) {
             alert("Fail:" + data);
         });
     });

     // ---------------------------------------------------------------------------------------
     // Click add-comment-mc-xxx hoac add-comment-tc-xxx
     $('body').on("click", "a[id^='add-comment-']", function() {
         var id = $(this).attr("id");
         var isTopicComment = id.indexOf("tc") > 0;
         var tmId = getEndNumber(id);
         var suffix = id.substring("add-comment-".length);

         var commentId = $("#comment-form-container-" + suffix + " > form > input[name='commentId']").val();
         //
         if (commentId) {
             return;
         }
         // On new comment form
         if (commentId == "") {
             return;
         }
         var commentUrlId = "add-comment-url-" + suffix;
         var createUrl = $("#" + commentUrlId).val();

         var postData = {};
         if (isTopicComment) {
             postData = {
                 "topicId": tmId
             };
         } else {
             postData = {
                 "messageId": tmId
             };
         }
         $.post(createUrl, postData)
             .done(function(data) {
                 $("#comment-form-container-" + suffix).html(data);
                 showCKEDITOR("comment-form-container-" + suffix);
             });
     });
     // -------------------------------------------------------------------------------------------
     // Click edit-comment-xxx
     $('body').on("click", "a[id^='edit-comment-']", function() {
         var id = $(this).attr("id");
         var commentId = getEndNumber(id);
         var editUrl = $("#edit-comment-url-" + commentId).val();
         // alert("Eidt="+editUrl);

         var parentId = $(this).parentsUntil("[id^='comments-']").parent().attr("id");
         // mc-xxxx or tc-xxxx
         var suffix = parentId.substring("comments-".length);


         $.post(editUrl).done(function(data) {
             $("#comment-form-container-" + suffix).html(data);
             showCKEDITOR("comment-form-container-" + suffix);
             $("#" + parentId + " > div[id^='comment-']").show();
             $("#comment-" + commentId).hide();
         });

         //$("#comment-" + commentId).hide();
     });
     // ---------------------------------------------------------------------------------------------
     $('body').on("click", "a[id^='delete-comment-']", function() {
         var isLogin = isLogined();
         if (!isLogin) {
             alert("Please login first");
             window.open(LOGIN_URL);
             return false;
         }
         var confirm = window.confirm("Area you sure to delete?");
         if (confirm == false) {
             return;
         }
         var id = $(this).attr("id");
         var commentId = getEndNumber(id);

         var html = $("#comment-" + commentId).html();

         var deleteUrl = $("#delete-comment-url-" + commentId).attr("value");

         var postData = {
             "form-action": "delete",
             "deleteId": commentId
         };

         $.post(deleteUrl, postData).done(function(data) {
             if ("deleted" == data) {
                 $("#comment-" + commentId).remove();
             } else {
                 alert("delete result:" + data);
             }
         });

     });

 });