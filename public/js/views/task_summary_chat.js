$(function() {
    $.cookie("task_type_chat", "all_list");
    $.cookie("task_sort_chat", "created_at");
    $.cookie("task_status_chat", -1);

    // displayTaskSortChat();
    // displayTaskTypeChat();
    // loadSummaryViewChat(true);

    $("#task_sort_chat").click(function(evt) {
        if ($.cookie("task_sort_chat") == "created_at" || $.cookie("task_sort_chat") == null)
            $.cookie("task_sort_chat", "due_date");
        else if ($.cookie("task_sort_chat") == "due_date")
            $.cookie("task_sort_chat", "assignee.name");
        else if ($.cookie("task_sort_chat") == "assignee.name")
            $.cookie("task_sort_chat", "created_at");
        displayTaskSortChat();
        clickTaskSortTypeChat($.cookie("task_status_chat"));
    });

    $("#task_type_chat").click(function(evt) {
        $.cookie("task_status_chat", -1);

        if ($.cookie("task_type_chat") == "all_list" || $.cookie("task_type_chat") == null)
            $.cookie("task_type_chat", "i_am_owner");
        else if ($.cookie("task_type_chat") == "i_am_owner")
            $.cookie("task_type_chat", "i_am_assignee");
        else if ($.cookie("task_type_chat") == "i_am_assignee")
            $.cookie("task_type_chat", "relate_list");
        else if ($.cookie("task_type_chat") == "relate_list")
            $.cookie("task_type_chat", "all_list");
        displayTaskTypeChat();
        loadSummaryViewChat(null);

        $.event.trigger({
            type: "task_type_changed_chat",
            message: "task type changed chat",
            status: $.cookie("task_status_chat")
        });
    });
});

//Relate view method
function loadSummaryViewChat(user_id) {
    if ($.cookie("id") == undefined) {
        return;
    }
    $("#count_chat").empty();
    var chat_id = getUrlParameter("chat_id");

    var formData = new FormData($(this)[0]);
    formData.append("task_status", $.cookie("task_status_chat"));
    formData.append("task_type", $.cookie("task_type_chat"));
    formData.append("chat_id", chat_id);
    formData.append("confirmed", false);

    if (user_id != null) {
      formData.append("user_id", user_id);
    }

    $.ajax({
        url: "/tasks/summary",
        type: 'POST',
        data: formData,
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        success: function(response) {}
    });
}

function displayTaskSortChat() {
    if ($.cookie("task_sort_chat") == "created_at" || $.cookie("task_sort_chat") == null) {
        $("#task_sort_chat").html(taskSortRecent());
    } else if ($.cookie("task_sort_chat") == "due_date") {
        $("#task_sort_chat").html(taskSortDueDate());
    } else if ($.cookie("task_sort_chat") == "assignee.name") {
        $("#task_sort_chat").html(taskSortName());
    }
}

function displayTaskTypeChat() {
    if ($.cookie("task_type_chat") == "all_list" || $.cookie("task_type_chat") == null) {
        $("#task_type_chat").html(taskTypeAllTask());
    } else if ($.cookie("task_type_chat") == "i_am_owner") {
        $("#task_type_chat").html(taskTypeRequestTask());
    } else if ($.cookie("task_type_chat") == "i_am_assignee") {
        $("#task_type_chat").html(taskTypeRequestForMe());
    } else if ($.cookie("task_type_chat") == "relate_list") {
        $("#task_type_chat").html(taskTypeRequestJustSee());
    }
}

function clickTaskSortTypeChat(status) {
    $.event.trigger({
        type: "task_sort_changed",
        message: status,
        time: new Date()
    });
}

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
