var newWindow = undefined

$(function() {
    window.resizeTo(500, 700);
    logout();
    // var langCode = ""
    // $.ajax({
    //     headers: {
    //         'AUTHORIZATION': $.cookie("token")
    //     },
    //     url: '/api/v1/users/' + $.cookie("id"),
    //     type: 'GET',
    //     async: false,
    //     cache: false,
    //     contentType: false,
    //     processData: false,
    //     success: function(returndata) {
    //         langCode = returndata.locale;
    //         $.cookie("landCode", langCode)
    //     },
    //     error: function(returndata) {}
    // });

    var langJS = null;

    var translate = function(jsdata) {
            $("[tkey]").each(function(index) {
                var strTr = jsdata[$(this).attr('tkey')];
                $(this).html(strTr);
            });
        }
        // var langCode = navigator.language.substr (0, 2);
    if ($.cookie("landCode") == "ko") {
        $.getJSON('/lang/ko.json', translate);
    } else if ($.cookie("landCode") == "en") {
        $.getJSON('/lang/en.json', translate);
    } else if ($.cookie("landCode") == "ja") {
        $.getJSON('/lang/ja.json', translate);
    } else if ($.cookie("landCode") == "zh") {
        $.getJSON('/lang/zh.json', translate);
    }

    $("#next_to_email").click(function(e) {
        $("#pls_user_container").hide();
        $("#send_email_container").show();

        var formData = new FormData($(this)[0]);
        formData.append("user_id", $.cookie("id"));
        formData.append("contacts", send_email_list);

        $.ajax({
            url: "/users/send_mail_google_list",
            type: 'POST',
            data: formData,
            async: false,
            cache: true,
            contentType: false,
            processData: false,
            success: function(returndata) {}
        });

    });
    $("#invite_google_user").click(function(e) {
        event.preventDefault();
        var user_emails = new Array();
        for (var i = 0; i < document.getElementsByName("box").length; i++) {
            if (document.getElementsByName("box")[i].checked == true) {
                user_emails.push(String(document.getElementsByName("box")[i].value));
            }
        }

        console.log(user_emails);
        var formData = new FormData($(this)[0]);
        formData.append("email", user_emails);
        formData.append("name", $.cookie("name"));
        $.ajax({
            url: "/users/send_mail_invite_google",
            type: 'POST',
            data: formData,
            async: false,
            cache: true,
            contentType: false,
            processData: false,
            success: function(returndata) {
                if ($.cookie("langCode") == "en") {
                    alert('I sent you an email ');
                } else if ($.cookie("langCode") == "ja") {
                    alert('私はあなたにメールを送信しました');
                } else if ($.cookie("langCode") == "zh") {
                    alert('我给你发了封邮件');
                } else {
                    alert('이메일을 보냈습니다.');
                }
                // self.close();
            }
        });
    });

    $("#google_contact").click(function(e) {
        auth();
    });
});

var google_friend_email_array = [];
var send_email_list = [];

function auth() {
    var config = {
        'client_id': '1088074598547-jv46h1sk6ofbh1i8d3dsato9o2evls4c.apps.googleusercontent.com',
        'scope': 'http://www.google.com/m8/feeds'
    };

    gapi.auth.authorize(config, function() {
        fetch(gapi.auth.getToken());
    });
}

function fetch(token) {
    $.ajax({
        url: "https://www.google.com/m8/feeds/contacts/default/full?access_token=" + token.access_token + "&max-results=10000&v=3.0&alt=json",
        dataType: "jsonp",
        success: function(data) {
            if (data.feed.entry != null) {
                for (var i = 0; i < data.feed.entry.length; i++) {
                    if (data.feed.entry[i].gd$email != null) {
                        google_friend_email_array.push(data.feed.entry[i].gd$email[0].address)
                    }
                }
            }
        }
    });

    $('.abcRioButtonContents').text(addressBook($.cookie("landCode")));
    $(".g-signin2").show();
    $("#google_contact").hide();
}

function logout() {
    win = window.open("http://accounts.google.com/logout", "something", "width=1,height=1");
    setTimeout("win.close();", 1000);
}

var googleUser = undefined

function onSignIn(googleUserProfile) {
    googleUser = googleUserProfile
    newWindow = window.open('', '', 'width=200,height=200,left=0,top=0');
    newWindow.document.write("<html><head><title>잠시 기다려주세요</title></head><body><div id='popup-div' style='width:140px; height:100px; margin-top:100px; margin: 0 auto;'><font color='#4dbdbd' size='4'>잠시 기다려주세요</font></div></body></html>");
    setTimeout("onSignIn2()", 1000);
};

function onSignIn2() {
    var profile = googleUser.getBasicProfile();

    var formData = new FormData($(this)[0]);
    formData.append("google_find_friend_uid", profile.getId());
    formData.append("login_id", $.cookie("login_id"));

    $.ajax({
        url: "/api/v1/google_find_friend_uid",
        type: 'POST',
        data: formData,
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        success: function(returndata) {},
        error: function(returndata) {
            console.log("error");
        }
    });
    signOut();

    // var emailListView = new EmailListView();
    send_email_list = google_friend_email_array
    find_user_email = []
    var formData = new FormData($(this)[0]);
    formData.append("contacts", google_friend_email_array);

    $.ajax({
        type: "POST",
        url: "/users/check_google_email",
        data: formData,
        async: false,
        cache: true,
        contentType: false,
        processData: false,
        success: function(data) {},
        failure: function(errMsg) {}
    });

    newWindow.close();
    $("#google_container").hide();
    $("#pls_user_container").show();

};

function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function() {});
}

function userLocaleChange(lang) {
    var formData = new FormData($(this)[0]);
    formData.append("user_id", $.cookie("id"));
    formData.append("locale", lang);
    $.ajax({
        url: "/api/v1/users/update_locale",
        type: 'POST',
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

function newWindowClose() {
    newWindow.close();
}
