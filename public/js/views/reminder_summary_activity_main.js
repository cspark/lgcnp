$(function() {
    $.cookie("reminder_type_activity", "all_reminder");
    $.cookie("reminder_sort_activity", "created_at");
    $.cookie("reminder_status_activity", -1);

    displayReminderTypeActivity();
    // loadReminderView();

    $("#main_reminder_type_activity").click(function(evt) {
        $.cookie("task_status_activity", -1);

        if ($.cookie("reminder_type_activity") == "all_reminder" || $.cookie("reminder_type_activity") == null)
            $.cookie("reminder_type_activity", "i_am_owner");
        else if ($.cookie("reminder_type_activity") == "i_am_owner")
            $.cookie("reminder_type_activity", "i_am_assignee");
        else if ($.cookie("reminder_type_activity") == "i_am_assignee")
            $.cookie("reminder_type_activity", "relate_list");
        else if ($.cookie("reminder_type_activity") == "relate_list")
            $.cookie("reminder_type_activity", "all_reminder");

        displayReminderMessages();
    });

    $(document).on("activityting_refresh", function(evt) {
        reminderSummaryView.initialize();
    });

    $.cookie("reminder_type_activity", "all_reminder");
    displayReminderMessages();
});

function displayReminderMessages(){
  displayReminderTypeActivity();
  loadReminderView();
  clickReminderSortTypeActivity($.cookie("reminder_status_activity"));
}

function loadReminderView(){
  if ($.cookie("id") == undefined){
    return;
  }

  var url = "/sessions/" + $.cookie("reminder_type_activity");
  $.ajax({
      url: url,
      type: 'POST',

      async: false,
      cache: false,
      contentType: false,
      processData: false,
      success: function(response) {

      },
      error: function (response) {
          console.log(response);
      }
  });
}

//Relate view method
function loadSummaryViewActivity() {
    if ($.cookie("id") == undefined) {
        return;
    }
    // $("#main_count_activity").empty();

    var formData = new FormData($(this)[0]);
    formData.append("reminder_status", $.cookie("reminder_status_activity"));
    formData.append("reminder_type", $.cookie("reminder_type_activity"));
    formData.append("confirmed", false);

    $.ajax({
        url: "/sessions/summary",
        type: 'POST',
        data: formData,
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        success: function(response) {
          $("#main-reminder-list-chat").html("<%= render partial: 'sessions/main_reminder', locals: { message_list: @message_list } %>");
        },
        error: function (response) {
            console.log(response);
        }
    });
}

function displayReminderTypeActivity() {
    $("#main_reminder_type_activity").html("");
    if ($.cookie("reminder_type_activity") == "all_reminder" || $.cookie("reminder_type_activity") == null) {
        $("#main_reminder_type_activity").html(taskTypeAllTask());
    } else if ($.cookie("reminder_type_activity") == "i_am_owner") {
        $("#main_reminder_type_activity").html(taskTypeRequestTask());
    } else if ($.cookie("reminder_type_activity") == "i_am_assignee") {
        $("#main_reminder_type_activity").html(taskTypeRequestForMe());
    } else if ($.cookie("reminder_type_activity") == "relate_list") {
        $("#main_reminder_type_activity").html(taskTypeRequestJustSee());
    }
}

function clickReminderSortTypeActivity(status) {
    $.event.trigger({
        type: "reminder_sort_changed",
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
            return sParameterName[1] === undefined
                ? true
                : sParameterName[1];
        }
    }
};
