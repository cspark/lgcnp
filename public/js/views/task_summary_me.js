$(function() {
    $.cookie("task_sort_me", "created_at");
    $.cookie("task_status_me", 4);

    $("#task_sort_me").click(function(evt) {
        if ($.cookie("task_sort_me") == "created_at" || $.cookie("task_sort_me") == null)
            $.cookie("task_sort_me", "due_date");
        else if ($.cookie("task_sort_me") == "due_date")
            $.cookie("task_sort_me", "assignee.name");
        else if ($.cookie("task_sort_me") == "assignee.name")
            $.cookie("task_sort_me", "created_at");
        displayTaskSortMe();
        clickTaskSortTypeMe($.cookie("task_status_me"));
    });
});

//Relate view method
function loadSummaryViewMe(user_id) {
    if ($.cookie("id") == undefined) {
        return;
    }
    $("#count_me").empty();
    var userId = getUrlParameter("userId");

    var formData = new FormData($(this)[0]);
    formData.append("task_status", $.cookie("task_status_me"));
    formData.append("task_type", "own_me");
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

function displayTaskSortMe() {
    if ($.cookie("task_sort_me") == "created_at" || $.cookie("task_sort_me") == null) {
        $("#task_sort_me").html(taskSortRecent());
    } else if ($.cookie("task_sort_me") == "due_date") {
        $("#task_sort_me").html(taskSortDueDate());
    } else if ($.cookie("task_sort_me") == "assignee.name") {
        $("#task_sort_me").html(taskSortName());
    }
}

function clickTaskSortTypeMe(status) {
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
