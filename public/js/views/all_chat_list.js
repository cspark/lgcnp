$(function() {
    $(document).on("chat_list_refresh", function(evt) {
        chatListRefresh();
    });
});

function chatListRefresh() {
    $("#chatting-list").empty();
    $.ajax({
        url: "/sessions/all_chat_list",
        headers: {
            'HTTP_AUTHORIZATION': $.cookie("token")
        },
        type: 'GET',
        async: false,
        cache: true,
        contentType: false,
        processData: false,
        success: function(response) {
        },
        error: function(response) {
            console.log(response);
        }
    });
}
