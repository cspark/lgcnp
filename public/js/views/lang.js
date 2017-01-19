$(function(){
  langChange();
  var langCode = ""
  // $.ajax({
  //   headers: {'AUTHORIZATION': $.cookie("token")},
  //   url: '/api/v1/users/' +$.cookie("id"),
  //   type: 'GET',
  //   async: false,
  //   cache: false,
  //   contentType: false,
  //   processData: false,
  //   success: function (returndata) {
  //     $.cookie("langCode",returndata.locale);
  //     langChange();
  //     changeFlag();
  //   },
  //   error: function(returndata){
  //   }
  // });

  $('#ko').click(function(){
    $.cookie("langCode","ko");
    userLocaleChange($.cookie("langCode"));
    changeFlag();
  });
  $('#en').click(function(){
    $.cookie("langCode","en");
    userLocaleChange($.cookie("langCode"));
    changeFlag();
  });
  $('#ja').click(function(){
    $.cookie("langCode","ja");
    userLocaleChange($.cookie("langCode"));
    changeFlag();
  });
  $('#zh').click(function(){
    $.cookie("langCode","zh");
    userLocaleChange($.cookie("langCode"));
    changeFlag();
  });

  $('#index_ko').click(function(){
    $.cookie("langCode","ko");
    changeFlag();
    langChange();
  });
  $('#index_en').click(function(){
    $.cookie("langCode","en");
    changeFlag();
    langChange();
  });
  $('#index_ja').click(function(){
    $.cookie("langCode","ja");
    changeFlag();
    langChange();
  });
  $('#index_zh').click(function(){
    $.cookie("langCode","zh");
    changeFlag();
    langChange();
  });

  // if($.cookie("langCode") != null)
  // {
  //   if(document.location.href.indexOf("main.html") < 0)
  //   {
  //     if(document.location.href.indexOf("profile") < 0 && document.location.href.indexOf("chat") < 0 && document.location.href.indexOf("task") < 0 && document.location.href.indexOf("friend") < 0)
  //     {
  //       select_language($.cookie("langCode"));
  //     }
  //   }
  // }
});

function userLocaleChange(lang){
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
    success: function (returndata) {
      location.reload();
     }
   });
}

function langChange(){
  var translate = function (jsdata)
  {
    $("[tkey]").each (function (index)
    {
      var strTr = jsdata [$(this).attr ('tkey')];
        $(this).html (strTr);
    });
  }
  if ($.cookie("langCode") == "ko")
  {
    $.getJSON('/lang/ko.json', translate);
  }
  else if($.cookie("langCode") == "en")
  {
    $.getJSON('/lang/en.json', translate);
  }
  else if($.cookie("langCode") == "ja")
  {
    $.getJSON('/lang/ja.json', translate);
  }
  else if($.cookie("langCode") == "zh")
  {
    $.getJSON('/lang/zh.json', translate);
  }
}

function changeFlag(){
  if($.cookie("langCode") == "en")
  {
    $(".locale_flag").attr("src", "/img/flag_usa.png")
    $(".locale_flag").css("width", "36px")
    $(".locale_flag").css("height", "36px")
  }
  else if($.cookie("langCode") == "ja")
  {
    $(".locale_flag").attr("src", "/img/flag_japan.png")
    $(".locale_flag").css("width", "36px")
    $(".locale_flag").css("height", "36px")
  }
  else if($.cookie("langCode") == "zh")
  {
    $(".locale_flag").attr("src", "/img/flag_china.png")
    $(".locale_flag").css("width", "36px")
    $(".locale_flag").css("height", "36px")
  }
  else
  {
    $(".locale_flag").attr("src", "/img/flag_korea.png")
    $(".locale_flag").css("width", "36px")
    $(".locale_flag").css("height", "36px")
  }
}
