$(function() {
    var chatRoomBar;
    var dataSize = 0;
    var plusContainer = false;

    $('#plus').click(function() {
        if (!plusContainer) {
            // window.resizeTo(700, 1050);
            $("#plus-container").show();
            plusContainer = true;
        } else {
            // window.resizeTo(700, 900);
            $("#plus-container").hide();
            plusContainer = false;
        }
    });

    $('#chat-list').scrollTop($('#chat-list').prop("scrollHeight"));

    var chat_id = getUrlParameter('chat_id');
    $.cookie("chat_id", chat_id);
    $.cookie("task_status_chat", 4);
    $.cookie("task_type_chat", "all_list");
    document.getElementById("body").focus();
    window.resizeTo(700, 850);
    // progressCreateChatRoom(); progressStartChatRoom();
    if (document.referrer && document.referrer.indexOf("task_detail") > 0) {
        $("#backbutton").show();
    } else {
        $("#backbutton").hide();
    }

    $('#backbutton').click(function() {
        parent.history.back();
    });

    // ==============================
    <% onlyTwoUserId = "" %>
    <% users = [] %>
    <% if @chat.join_users.count == 1 %>
    <% onlyTwoUserId = cookies.permanent[:id] %>
    <% elsif @chat.join_users.count == 2 %>
    <% @chat.join_users.each do |user| %>
    <% users.push(user) %>
    <% if user.id != cookies.permanent[:id] %>
    <% onlyTwoUserId = user.id %>
    <% end %>
    <% end %>
    <% end %>

    $('#create_task').click(function() {
        var chat_id = getUrlParameter('chat_id');
        <% if onlyTwoUserId != "" && onlyTwoUserId != nil %>
        location.href = "/tasks/create_task?chat_id=" + chat_id + "&user_id=<%= onlyTwoUserId %>"
        <% else %>
        location.href = "/tasks/create_task?chat_id=" + chat_id;
        <% end %>
    });
    // ==============================

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
                    location.reload();
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
                    location.reload();
                }
            });
        }
    });

    if ($.cookie("langCode") == "en") {
        document.getElementsByName('body')[0].placeholder = 'Click airplane button to create task!';
    } else if ($.cookie("langCode") == "ja") {
        document.getElementsByName('body')[0].placeholder = 'タスクを作成するために飛行機のボタンをクリック！';
    } else if ($.cookie("langCode") == "zh") {
        document.getElementsByName('body')[0].placeholder = '点击飞机按钮创建的任务！';
    } else {
        document.getElementsByName('body')[0].placeholder = '비행기 버튼을 눌러 부탁을 만들어보세요!';
    }

    $(document).on('change', ':file', function() {
        var input = $(this),
            numFiles = input.get(0).files ?
            input.get(0).files.length :
            1,
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [numFiles, label]);
    });

    // We can watch for our custom `fileselect` event like this
    $(document).ready(function() {
        $(':file').on('fileselect', function(event, numFiles, label) {

            var input = $(this).parents('.input-group').find(':text'),
                log = numFiles > 1 ?
                numFiles + ' files selected' :
                label;

            if (input.length) {
                input.val(log);
            } else {}

        });
    });

    var isFile = true;
    $('#image_upload').click(function() {
        isFile = false;
    });
    $('#file_upload').click(function() {
        isFile = true;
    });

    $("form#data").submit(function(event) {
        event.preventDefault();
        dataSize = document.getElementById('file').files.length;
        alert(document.getElementById('file').files.length);
        alert($(this)[0]);
        if (document.getElementById('file').files.length == 0) {
            var formData = new FormData($(this)[0]);
            messageSubmit(formData, 0);
        } else {
            for (var i = 0; i < document.getElementById('file').files.length; i++) {
                var formData = new FormData();
                var file = document.getElementById('file').files[i]
                formData.append('file', file);
                if (isFile == false) {
                    if (formData.get("file").type == "image/png" || formData.get("file").type == "image/jpg" || formData.get("file").type == "image/jpeg" || formData.get("file").type == "image/gif" || formData.get("file").type == "image/bmp") {
                        formData.append("image", formData.get("file"));
                        formData.append("file", null);
                        isFile = false;
                    } else {
                        alert(onlyImageFile());
                        formData = null;
                        isFile = true;
                        location.reload();
                    }
                }

                var fileName = formData.get("file").name;
                if (formData.get("body") == null || formData.get("body") == "") {
                    formData.set("body", fileName);
                }
                fileSubmit(formData, i);
            }
        }
        return false;
    });

    function fileSubmit(formData, i) {
        var chat_id = getUrlParameter('chat_id');
        formData.append("chat_id", chat_id);
        $.ajax({
            url: "/chats/" + chat_id + "/messages",
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function(returndata) {
                $("#body").val("");
            }
        });
    }

    function messageSubmit(formData, i) {
        var chat_id = getUrlParameter('chat_id');
        formData.append("chat_id", chat_id);
        $.ajax({
            url: "/rooms/add_message",
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function(returndata) {
                $("#body").val("");
            }
        });
    }

    $(document).on("task_sort_changed", function(evt) {
        var chat_id = getUrlParameter('chat_id');
        if (evt.message == 3) {
            $.cookie("task_status_chat", 3);
        } else {
            $.cookie("task_status_chat", -1);
        }
        var loadTaskList = new LoadTaskList({
            model: taskModel
        });
        $.cookie("task_type_chat", "all_list")
        var taskSummaryModel = new TaskSummaryModel();
        var taskSummaryView = new TaskSummaryView({
            model: taskSummaryModel
        });
        location.href = "/task_chat.html?user_id=" + $.cookie("id") + "&chat_id=" + chat_id;
    });

    var page = 1

    $('#chat-list').on('scroll', function() {
        var tempHeight = $("#chat-list").prop("scrollHeight")
        if ($(this).scrollTop() <= 0) {
            page = page + 1;
            var chat_id = getUrlParameter('chat_id');
            var formData = new FormData($(this)[0]);
            formData.append("chat_id", chat_id);
            formData.append("page", page);
            $.ajax({
                url: "/rooms/loadmore",
                // url: "/rooms/show?chat_id=<%= @chat.id %>",
                type: 'POST',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function(returndata) {
                    $('#chat-list').scrollTop($("#chat-list").prop("scrollHeight") - tempHeight)
                }
            });
        }
    });

    $(document).on("chatting_refresh", function(evt) {
        if (evt.message.message.message_type == 'tutorial_message') {
            location.reload();
        } else {
            var chat_id = getUrlParameter('chat_id');
            var formData = new FormData($(this)[0]);
            formData.append("chat_id", chat_id);
            formData.append("message_id", evt.message.message.id);
            $.ajax({
                url: "/rooms/receive_message",
                type: 'POST',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function(returndata) {
                    // $('#chat-list').scrollTop($('#chat-list').prop("scrollHeight"));
                }
            });
        }
    });

    setInterval(function() {
        if ($('.new_text').css("color") == "rgb(253, 90, 90)")
            $(".new_text").css('color', '#fff600');
        else
            $(".new_text").css('color', '#fd5a5a');
    }, 250);
});

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ?
                true :
                sParameterName[1];
        }
    }
};
