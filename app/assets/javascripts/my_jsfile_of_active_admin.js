$(document).ready(function() {

  var time_format = /([01]\d|2[0-3]):([0-5]\d)/;
 
  $('.label_error').hide();
  $("#profile_submit_action").click(function() {
     var check_name = /^[a-zA-Z]*$/;
     var email_format = /^[a-zA-Z0-9_\.\-]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;

    var email, fname, gender;
    email = $("#profile_email").val();
    fname = $("#profile_first_name").val();
    dob = $("#profile_dob").val();
  
    // if (email.trim() === "") {
    //   $("#email_label").show();
    //   return false;
    // }
    if (!email_format.test(email) || email.trim()==="") {
      $("#email_label").show();
      $("#fname_label").hide();
       $("#dob_label").hide();
      return false;
    }
   if (!check_name.test(fname) || fname.trim() === "")
   {
     $("#email_label").hide();
     $("#fname_label").show();
     $("#dob_label").hide();
     return false;
   }
    // if (gender.trim() === "") {
    //   // window.alert("Please select gender");
    //   return false;
    // }
    if (dob.trim() === "") {
      $("#email_label").hide();
      $("#fname_label").hide();
       $("#dob_label").show();
      return false;
    }
  });

 $("#interest_submit_action").click(function() {
 	 name = $("#interest_interest_name").val();
   description = $("#interest_description").val();

   if (name.trim() == "") {
    $("#interest_name_label").show();
    $("#description_label").hide();
    return false;
   }

  if (description.trim() === "") {
    $("#description_label").show();
    $("#interest_name_label").hide();
    return false;
  }
	});

 $("#question_submit_action").click(function() {
   question = $("#question_question").val();
    if (question.trim() === "") {
      $("#question_label").show();
      return false;
    }
  });
$("#event_submit_action").click(function() {
   name = $("#event_event_name").val();
   place = $("#event_place").val();
   link = $("#event_link").val();
   city = $("#event_city").val();
   time = $("#event_event_time").val();
   date = $("#event_event_date").val();

    if (name.trim() === "") {
      $("#event_name_label").show();
      $("#city_label").hide();
      $("#link_label").hide();
      $("#event_date_label").hide();
      $("#event_time_label").hide();
      $("#place_label").hide();
      return false;
    }
    if (place.trim() === "") {
      $("#place_label").show();
      $("#city_label").hide();
      $("#link_label").hide();
      $("#event_date_label").hide();
      $("#event_time_label").hide();
      $("#event_name_label").hide();
      return false;
    }  

    if (time.trim() === "") {
      $("#event_time_label").show();
      $("#city_label").hide();
      $("#link_label").hide();
      $("#event_date_label").hide();
      $("#place_label").hide();
      $("#event_name_label").hide();
      return false;
    } 
    if (date.trim() === "") {
      $("#event_date_label").show();
      $("#event_time_label").hide();
      $("#place_label").hide();
      $("#event_name_label").hide();
      $("#city_label").hide();
      $("#link_label").hide();
      return false;
    } 
   if (link.trim() === "") {
      $("#link_label").show();
      $("#event_date_label").hide();
      $("#city_label").hide();
      $("#event_time_label").hide();
      $("#place_label").hide();
      $("#event_name_label").hide();
       return false;
    }   
   if (city.trim() === "") {
      $("#city_label").show();
      $("#link_label").hide();
      $("#event_date_label").hide();
      $("#event_time_label").hide();
      $("#place_label").hide();
      $("#event_name_label").hide();
      return false;
    }  
  });
  
$("#post_submit_action").click(function() {
   title = $("#post_title").val();
   content = $("#post_content").val();
 
    if (title.trim() === "") {
      $("#title_label").show();
      $("#content_label").hide();
      return false;
    }
    if (content.trim() === "") {
      $("#content_label").show();
      $("#title_label").hide();
      return false;
    }  
  });
 
 $("#category_submit_action").click(function() {
   name = $("#category_category_name").val(); 
    if (name.trim() === "") {
      $("#category_name_label").show();
      return false;
    }
  });

    $("#event_event_time").pickatime();

});

