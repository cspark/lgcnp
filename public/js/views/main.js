$(function() {
    $("#create_activity").click(function(e) {
        var newWindow = window.open("/activities/create_activity", "/activities/create_activity", "scrollbars=1,resizable=1,height=460,width=600");
        childrens.push(newWindow);
    });

    $("#create_group").click(function(e) {
        var newWindow = window.open("/groups/create_group", "/groups/create_group", "scrollbars=1,resizable=1,height=460,width=600");
        childrens.push(newWindow);
    });

    $("#friends_list").click(function(e) {
        var newWindow = window.open("/friends?favorite=false&page=1&per=10000", "/friends?favorite=false&page=1&per=10000", "scrollbars=1,resizable=1,height=600,width=400");
        childrens.push(newWindow);
    });

    $("#recommend_friends").click(function(e) {
      var newWindow = window.open("/friends/recommand_friend", "/recommand_friend", "scrollbars=1,resizable=1, width=500, height=600");
      childrens.push(newWindow);
    });

    var temp = "timeZone";
    var timeZoneArray = [];
    for (var i = -11; i < 14; i++) {
        var obj = {
            time_zone: "",
            time: ""
        };
        obj.time_zone = i
        obj.time = getWorldTime(i)
        timeZoneArray.push(obj);
    }
    for (var j = 0; j < timeZoneArray.length; j++) {
        if (document.getElementById('zone' + timeZoneArray[j].time_zone) != null) {
            document.getElementById('zone' + timeZoneArray[j].time_zone).innerHTML = timeZoneArray[j].time;
        }
    }

    $('#ko').click(function() {
        userLocaleChange("ko");
    });
    $('#en').click(function() {
        userLocaleChange("en");
    });
    $('#ja').click(function() {
        userLocaleChange("ja");
    });
    $('#zh').click(function() {
        userLocaleChange("zh");
    });

    if ($.cookie("time_zone") != null && $.cookie("time_zone") != undefined) {
        $("#time_zone").text("Timezone : " + $.cookie("time_zone"));
    } else {
        $("#time_zone").text("Timezone : ");
    }

    $(".timezone").click(function(e) {
        e.preventDefault();
        var tempTimeZone = $(e.currentTarget).text();
        if (tempTimeZone == "서울") {
            tempTimeZone = "Seoul"
        } else if (tempTimeZone == "北京") {
            tempTimeZone = "Beijing"
        } else if (tempTimeZone == "東京") {
            tempTimeZone = "Tokyo"
        }

        $.cookie("time_zone", tempTimeZone);
        var formData = new FormData($(this)[0]);
        formData.append("user_id", $.cookie("id"));
        formData.append("time_zone", tempTimeZone);

        $("#time_zone").text("Timezone : " + $(e.currentTarget).text());

        $.ajax({
            type: "POST",
            url: "/api/v1/users/update_time_zone",
            data: formData,
            async: false,
            cache: true,
            contentType: false,
            processData: false,
            success: function(data) {
                $('#cancle').trigger('click');
            },
            failure: function(errMsg) {
                console.log(errMsg);
            }
        });
    });

    $("#withdraw_confirm").click(function(e) {
        $.ajax({
            type: "POST",
            url: "/users/withdrawal",
            async: false,
            cache: true,
            contentType: false,
            processData: false,
            success: function(data) {
                for (var it in $.cookie()) $.removeCookie(it);
                alert(withdrawalComplete());
                location.href = "/"
            },
            failure: function(errMsg) {
                console.log(errMsg);
            }
        });
    });

    // $(document).on("show_main_new_text", function(evt) {
    //     console.log("show_main_new_text");
    //     showMainNewText();
    // });

    function userLocaleChange(locale) {
        var formData = new FormData($(this)[0]);
        formData.append("locale", locale);

        $.ajax({
            url: "/api/v1/users/" + $.cookie("id"),
            type: 'PUT',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function(returndata) {
                // location.reload();
            }
        });
    }

    $('#radioBtn a').on('click', function() {
        var sel = $(this).data('title');
        var tog = $(this).data('toggle');
        $('#' + tog).prop('value', sel);

        $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('active').addClass('notActive');
        $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('notActive').addClass('active');

        var formData = new FormData($(this)[0]);
        formData.append("is_info_private", sel);
        formData.append("user_id", $.cookie("id"));

        $.ajax({
            url: "/api/v1/is_info_private",
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function(returndata) {
                $.cookie("is_info_private", returndata.is_info_private);
            }
        });
    })
});

function getWorldTime(tzOffset) { // 24시간제
    var now = new Date();
    var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (tzOffset * 3600000);
    now.setTime(tz);


    var s =
        // leadingZeros(now.getFullYear(), 4) + '-' +
        // leadingZeros(now.getMonth() + 1, 2) + '-' +
        // leadingZeros(now.getDate(), 2) + ' ' +

        leadingZeros(now.getHours(), 2) + ':' +
        leadingZeros(now.getMinutes(), 2)
        // leadingZeros(now.getSeconds(), 2);

    return s;
}


function leadingZeros(n, digits) {
    var zero = '';
    n = n.toString();

    if (n.length < digits) {
        for (i = 0; i < digits - n.length; i++)
            zero += '0';
    }
    return zero + n;
}
