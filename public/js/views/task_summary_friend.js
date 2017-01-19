$(function() {
    $.cookie("task_sort_friend", "created_at");
    $.cookie("task_status_friend", 4);

    $("#task_sort_friend").click(function(evt) {
        if ($.cookie("task_sort_friend") == "created_at" || $.cookie("task_sort_friend") == null)
            $.cookie("task_sort_friend", "due_date");
        else if ($.cookie("task_sort_friend") == "due_date")
            $.cookie("task_sort_friend", "assignee.name");
        else if ($.cookie("task_sort_friend") == "assignee.name")
            $.cookie("task_sort_friend", "created_at");
        displayTaskSortFriend();
        clickTaskSortTypeFriend($.cookie("task_status_friend"));
    });
});

//Relate view method
function loadSummaryViewFriend(user_id) {
    if ($.cookie("id") == undefined) {
        return;
    }
    $("#count_friend").empty();
    var friend_id = getUrlParameter("friend_id");

    var formData = new FormData($(this)[0]);
    formData.append("task_status", $.cookie("task_status_friend"));
    formData.append("task_type", "task_with_friend");
    formData.append("friend_id", friend_id);
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

function displayTaskSortFriend() {
    if ($.cookie("task_sort_friend") == "created_at" || $.cookie("task_sort_friend") == null) {
        $("#task_sort_friend").html(taskSortRecent());
    } else if ($.cookie("task_sort_friend") == "due_date") {
        $("#task_sort_friend").html(taskSortDueDate());
    } else if ($.cookie("task_sort_friend") == "assignee.name") {
        $("#task_sort_friend").html(taskSortName());
    }
}

function clickTaskSortTypeFriend(status) {
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
