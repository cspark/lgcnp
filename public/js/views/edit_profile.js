$(function() {
    document.getElementById("please_id").value = $.cookie("login_id");
    if ($.cookie("phone") == null || $.cookie("phone") == "null")
        document.getElementById("phone").value = "";
    else
        document.getElementById("phone").value = $.cookie("phone");

    document.getElementById("name").value = $.cookie("name");
    document.getElementById("email").value = $.cookie("email");

    $("#edit-profile-confirm").click(function(evt) {
        var formData = new FormData($(this)[0]);
        formData.append("name", document.getElementById("name").value);
        formData.append("phone", document.getElementById("phone").value);
        formData.append("email", document.getElementById("email").value);

        if ($("#name").val() == "" || $("#email").val() == "" || $("#phone").val() == "") {
            alert(inputEmptyValue());
            evt.preventDefault();
            return;
        }
        var strValue = $("#email").val();
        var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
        if (strValue.lenght == 0) {
            return false;
        }
        if (!strValue.match(regExp)) {
            alert(fillEmailFormat());
            return;
        }

        $.ajax({
            url: "/users/" + $.cookie("id"),
            headers: {
                'HTTP_AUTHORIZATION': $.cookie("token")
            },
            type: 'PUT',
            data: formData,
            async: false,
            cache: true,
            contentType: false,
            processData: false,
            success: function(response) {
                $.cookie("name", response.name);
                $.cookie("phone", response.phone);
                $.cookie("email", response.email);
                if ($.cookie("langCode") == "en") {
                    alert("Your information has been edited.");
                } else if ($.cookie("langCode") == "ja") {
                    alert("情報の修正が完了しました。");
                } else if ($.cookie("langCode") == "zh") {
                    alert("这个信息修改就完成了。");
                } else {
                    alert("정보수정이 완료 되었습니다.");
                }

                $('#cancle').trigger('click');
            },
            error: function(response) {
                if (response.responseText.indexOf("Email") >= 0) {
                    alert(emailAlreadyUse());
                    return;
                }
            }
        });
    });

    $("#edit-password-confirm").click(function(evt) {

        if ($("#password").val() != $("#password_confirmation").val()) {
            alert(passwordDoNotMatch());
            evt.preventDefault();
            return;
        }

        var formData = new FormData($(this)[0]);
        formData.append("password", document.getElementById("password").value);
        formData.append("password_confirmation", document.getElementById("password_confirmation").value);

        $.ajax({
            url: "/users/" + $.cookie("id"),
            headers: {
                'HTTP_AUTHORIZATION': $.cookie("token")
            },
            type: 'PUT',
            data: formData,
            async: false,
            cache: true,
            contentType: false,
            processData: false,
            success: function(response) {
                $('#edit-password-cancle').trigger('click');
            },
            error: function(response) {
                console.log(response);
            }
        });
    });
});
