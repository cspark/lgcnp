var chatRoomBar;
var dataSize = 0;
$(function() {
    var chat_id = getUrlParameter('chat_id');
    $.cookie("chat_id", chat_id);
    document.getElementById("body").focus();

    $('#exit_chatting').click(function() {
        var chat_id = getUrlParameter('chat_id');
        var r = confirm("채팅방을 나가시겠습니까?");
        if (r == true) {
            $.ajax({
                url: "/chats/" + chat_id + "/leave",
                type: 'POST',
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function(returndata) {
                    if (window.opener.location.href.indexOf("main") >= 0) {
                        window.opener.activityRefresh(map_id, group_id);
                    } else {
                        window.opener.chatListRefresh();
                    }
                    window.close();
                }
            });
        }
    });

    $('#edit_chat_name').click(function() {
        var chat_name = prompt('Enter chat room name');
        if (chat_name) {
            var formData = new FormData($(this)[0]);
            formData.append("name", chat_name);

            $.ajax({
                url: "/chats/" + chat_id,
                type: 'PUT',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function(returndata) {
                    if (window.opener.location.href.indexOf("main") >= 0) {
                        window.opener.activityRefresh(<%= @map.id %>, <%= @group.id %>);
                    } else {
                        window.opener.chatListRefresh();
                    }
                }
            });
        }
    });

    $('#delete_chat_name').click(function() {
        var r = confirm("채팅방 이름을 삭제하시겠습니까?");
        if (r == true) {
            var formData = new FormData($(this)[0]);
            formData.append("name", null);

            $.ajax({
                url: "/chats/" + chat_id,
                type: 'PUT',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function(returndata) {
                    if (window.opener.location.href.indexOf("main") >= 0) {
                        window.opener.activityRefresh();
                    } else {
                        window.opener.chatListRefresh();
                    }
                }
            });
        }
    });

    $('#chat_favorite').click(function() {
        var chat_id = getUrlParameter('chat_id');
        var formData = new FormData($(this)[0]);
        formData.append("chat_id", chat_id);

        $.ajax({
            url: "/chats/favorite",
            type: 'PUT',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function(returndata) {
                if (window.opener.location.href.indexOf("main") >= 0) {
                    window.opener.activityRefresh();
                } else {
                    window.opener.chatListRefresh();
                }
                $("#chat_unfavorite").show();
                $("#chat_favorite").hide();
            }
        });
    });

    $('#chat_unfavorite').click(function() {
        var chat_id = getUrlParameter('chat_id');
        var formData = new FormData($(this)[0]);
        formData.append("chat_id", chat_id);

        $.ajax({
            url: "/chats/unfavorite",
            type: 'PUT',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function(returndata) {
                if (window.opener.location.href.indexOf("main") >= 0) {
                    window.opener.activityRefresh();
                } else {
                    window.opener.chatListRefresh();
                }
                $("#chat_favorite").show();
                $("#chat_unfavorite").hide();
            }
        });
    });

    setInterval(function() {
        if ($('.new_text').css("color") == "rgb(253, 90, 90)")
            $(".new_text").css('color', '#fff600');
        else
            $(".new_text").css('color', '#fd5a5a');
    }, 250);
});

function progressCreateChatRoom() {

}

function progressStartChatRoom() {

}

function progressStopChatRoom() {

}
