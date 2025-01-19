$(function () {
  window.addEventListener("message", function (event) {
    var data = event.data;

    {
      if (event.data.hide) {
        document.getElementById("content").style.visibility = "visible";
        document.getElementById("content").style.opacity = "0";
      } else {
        document.getElementById("content").style.visibility = "visible";
        document.getElementById("content").style.opacity = "1";
      }

      if (data.action === "ui") {
        document.querySelector(".poss1").style.background =
          "conic-gradient(#e2b260  " + data.hungry + "%, transparent 0%)";
        $("#hungrylevel").html(Math.round(data.hungry));

        document.querySelector(".poss2").style.background =
          "conic-gradient(#e2b260  " + data.stress + "%, transparent 0%)";
        $("#stresslevel").html(Math.round(data.stress));

        document.querySelector(".poss3").style.background =
          "conic-gradient(#e2b260  " + data.dive + "%, transparent 0%)";
        $("#divelevel").html(Math.round(data.dive));

        if (data.dive < 0) {
          $("#divelevel").text("0");
        }

        if (data.armor) $("#armorlevel").html(data.armor + "%");
        $("#armor").css("width", data.armor + "%");
        if (data.armor > 50) {
          $("#armorlevel").html(data.armor + "%");
          $("#armor").css("width", data.armor + "%");
        } else if (data.armor > 30) {
          $("#armor").css("width", data.armor + "%");
          $("#armorlevel").html(data.armor + "%");
        } else if (data.armor <= 30) {
          $("#armorlevel").html(data.armor + "%");
          $("#armor").css("width", data.armor + "%");
        }

        if (data.dive >= 100) {
          $("#diveshow").hide();
          $(".percent-dive").hide();
        } else if (data.dive > 50) {
          $("#diveshow").show();
          $(".percent-dive").show();
        } else if (data.dive > 30) {
          $("#diveshow").show();
          $(".percent-dive").show();
        } else if (data.dive <= 30) {
          $("#diveshow").show();
          $(".percent-dive").show();
        }

        if (data.id) $("#id").html(data.id);

        if (data.health) $("#healtlevel").html(Math.round(data.health) + "%");

        if (data.health < 0) {
          $("#healtlevel").text("0" + "%");
        }

        $("#health").css("width", data.health + "%");
        if (data.health > 50) {
          $("#health").css("width", data.health + "%");
        } else if (data.health > 30) {
          $("#health").css("width", data.health + "%");
        } else if (data.health <= 30) {
          $("#health").css("width", data.health + "%");
        }
      }

    if (data.stamina) $("#stamina").css(Math.round(data.stamina) + "%");
      $("#stamina").css("width", data.stamina + "%");
    }

    if (data.type == "SetDiscord") {
      $("#Profile-Player").attr("src",data.avatar);
    }

      var xhr = new XMLHttpRequest();
      xhr.responseType = "text";
      xhr.open('GET', event.data.steamid, true);
      xhr.send();
      xhr.onreadystatechange = processRequest;

      function processRequest(e) {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var string = xhr.responseText.toString();
            var array = string.split("avatarfull");
            var array2 = array[1].toString().split('"');
            $('#Profile-Player').attr('src', array2[2].toString());
        }
      }

    if (data.talk) {
      $("#voice-text").css("color", "#e2b260 ");
    } else {
      $("#voice-text").css("color", "#ffffff");
    }

    if (data.action === "voice") {
      $("#voice-text").text(data.voiceText);
      if (data.voiceCircle === 1) {
        $("#voice1").css(
          "background-image",
          "linear-gradient(0deg, #e2b260  40%, #e2b260  100%)"
        );
        $("#voice2").css(
          "background-image",
          "linear-gradient(0deg, #6c6c6c 0%, #6c6c6c 100%)"
        );
        $("#voice3").css(
          "background-image",
          "linear-gradient(0deg, #6c6c6c 0%, #6c6c6c 100%)"
        );
      }
      if (data.voiceCircle === 2) {
        $("#voice1").css(
          "background-image",
          "linear-gradient(0deg, #6c6c6c 0%, #6c6c6c 100%)"
        );
        $("#voice2").css(
          "background-image",
          "linear-gradient(0deg, #e2b260  40%, #e2b260  100%)"
        );
        $("#voice3").css(
          "background-image",
          "linear-gradient(0deg, #6c6c6c 0%, #6c6c6c 100%)"
        );
      }
      if (data.voiceCircle === 3) {
        $("#voice1").css(
          "background-image",
          "linear-gradient(0deg, #6c6c6c 0%, #6c6c6c 100%)"
        );
        $("#voice2").css(
          "background-image",
          "linear-gradient(0deg, #6c6c6c 0%, #6c6c6c 100%)"
        );
        $("#voice3").css(
          "background-image",
          "linear-gradient(0deg, #e2b260  40%, #e2b260  100%)"
        );
      }
    }
  });
});

var audio = new Audio();
$(function () {
  window.addEventListener("message", function (event) {
    var item = event.data;
    if (item.action == "sound") {
      // audio.pause();
      audio = new Audio("sound/" + item.sound + ".mp3");
      audio.play();
      audio.volume = 1;
    }
  });
});
