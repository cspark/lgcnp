$(function() {
    $.cookie("task_type_activity", "all_list");
    $.cookie("task_sort_activity", "created_at");
    $.cookie("task_status_activity", -1);

    displayTaskSortActivity();
    displayTaskTypeActivity();
    loadSummaryViewActivity();

    $("#task_sort_activity").click(function(evt) {
        if ($.cookie("task_sort_activity") == "created_at" || $.cookie("task_sort_activity") == null)
            $.cookie("task_sort_activity", "due_date");
        else if ($.cookie("task_sort_activity") == "due_date")
            $.cookie("task_sort_activity", "assignee.name");
        else if ($.cookie("task_sort_activity") == "assignee.name")
            $.cookie("task_sort_activity", "created_at");
        displayTaskSortActivity();
        clickTaskSortTypeActivity($.cookie("task_status_activity"));
    });

    $("#task_type_activity").click(function(evt) {
        $.cookie("task_status_activity", -1);

        if ($.cookie("task_type_activity") == "all_list" || $.cookie("task_type_activity") == null)
            $.cookie("task_type_activity", "i_am_owner");
        else if ($.cookie("task_type_activity") == "i_am_owner")
            $.cookie("task_type_activity", "i_am_assignee");
        else if ($.cookie("task_type_activity") == "i_am_assignee")
            $.cookie("task_type_activity", "relate_list");
        else if ($.cookie("task_type_activity") == "relate_list")
            $.cookie("task_type_activity", "all_list");
        displayTaskTypeActivity();
        loadSummaryViewActivity();

        $.event.trigger({
            type: "task_type_changed_activity",
            message: "task type changed activity",
            status: $.cookie("task_status_activity")
        });
    });
});

//Relate view method
function loadSummaryViewActivity() {
    if ($.cookie("id") == undefined) {
        return;
    }
    $("#count_activity").empty();
    var activity_id = getUrlParameter("activity_id");
    console.log(activity_id);
    var formData = new FormData($(this)[0]);
    formData.append("task_status", $.cookie("task_status_activity"));
    formData.append("task_type", $.cookie("task_type_activity"));
    formData.append("activity_id", activity_id);
    formData.append("confirmed", false);

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

function displayTaskSortActivity() {
    if ($.cookie("task_sort_activity") == "created_at" || $.cookie("task_sort_activity") == null) {
        $("#task_sort_activity").html(taskSortRecent());
    } else if ($.cookie("task_sort_activity") == "due_date") {
        $("#task_sort_activity").html(taskSortDueDate());
    } else if ($.cookie("task_sort_activity") == "assignee.name") {
        $("#task_sort_activity").html(taskSortName());
    }
}

function displayTaskTypeActivity() {
    if ($.cookie("task_type_activity") == "all_list" || $.cookie("task_type_activity") == null) {
        $("#task_type_activity").html(taskTypeAllTask());
    } else if ($.cookie("task_type_activity") == "i_am_owner") {
        $("#task_type_activity").html(taskTypeRequestTask());
    } else if ($.cookie("task_type_activity") == "i_am_assignee") {
        $("#task_type_activity").html(taskTypeRequestForMe());
    } else if ($.cookie("task_type_activity") == "relate_list") {
        $("#task_type_activity").html(taskTypeRequestJustSee());
    }
}

function clickTaskSortTypeActivity(status) {
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
