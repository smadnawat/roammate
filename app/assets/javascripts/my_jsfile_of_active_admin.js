$(document).ready(function() {
  $('.picker__holder').addClass( "time_holder" );
  var time_format = /([01]\d|2[0-3]):([0-5]\d)/;
 
  $('.label_error').hide();
  
  var _URL = window.URL || window.webkitURL;
  $("#interest_image").change(function (e) {
    var file, img;
    if ((file = this.files[0])) {
    img = new Image();
    img.onload = function () {
      if (this.width < 200) {
        $("#interest_image_label").show();
        return false;
        } 
        else if (this.height < 200) {
          $("#interest_image_label").show();
          return false;
        } 
        else{
          $("#interest_image_label").hide();
        } 
        };
      img.src = _URL.createObjectURL(file);
    }
  });
  $("#interest_icon").change(function (e) {
    var file, img;
    if ((file = this.files[0])) {
    img = new Image();
    img.onload = function () {
      if (this.width < 100) {
        $("#interest_icon_label").show();
        return false;
        } 
        else if (this.height < 100) {
          $("#interest_icon_label").show();
          return false;
        } 
        else{
          $("#interest_icon_label").hide();
        } 
        };
      img.src = _URL.createObjectURL(file);
    }
  });
  $("#interest_banner").change(function (e) {
    var file, img;
    if ((file = this.files[0])) {
    img = new Image();
    img.onload = function () {
      if (this.width < 600) {
        $("#interest_banner_label").show();
        return false;
        } 
        else if (this.height < 200) {
          $("#interest_banner_label").show();
          return false;
        } 
        else{
          $("#interest_banner_label").hide();
        } 
        };
      img.src = _URL.createObjectURL(file);
    }
  });
  $("#event_image").change(function (e) {
    var file, img;
    if ((file = this.files[0])) {
    img = new Image();
    img.onload = function () {
      if (this.width < 600) {
        $("#event_image_label").show();
        return false;
        } 
        else if (this.height < 200) {
          $("#event_image_label").show();
          return false;
        } 
        else{
          $("#event_image_label").hide();
        } 
        };
      img.src = _URL.createObjectURL(file);
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

 $("#special_message_submit_action").click(function() {
   name = $("#special_message_content").val();

   if (name.trim() == "") {
    $("#message_new_label").show();
    return false;
   }
  });

 
 $("#service_point_submit_action").click(function() {
   point = $("#service_point_point").val(); 
    if (point.trim() === "") {
      $("#service_point_label").show();
      return false;
    }
  });
 

$("#profile_submit_action").click(function() {
     var check_name = /^[a-zA-Z]*$/;
     var email_format = /^[a-zA-Z0-9_\.\-]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;

    var email, fname, gender,lname;
    email = $("#profile_fb_email").val();
    fname = $("#profile_first_name").val();
    dob = $("#profile_dob").val();
    lname = $("#profile_last_name").val();

    if (!email_format.test(email) || email.trim()==="") {
      $("#email_label").show();
      $("#fname_label").hide();
      $("#lname_label").hide();
      $("#dob_label").hide();
      return false;
    }
   if (!check_name.test(fname) || fname.trim() === "")
   {
     $("#email_label").hide();
     $("#fname_label").show();
     $("#lname_label").hide();
     $("#dob_label").hide();
     return false;
   }

    if (!check_name.test(lname)) {
      $("#email_label").hide();
      $("#fname_label").hide();
      $("#dob_label").hide();
      $("#lname_label").show();
      return false;
    }
    
    if (dob.trim() === "") {
      $("#email_label").hide();
      $("#fname_label").hide();
      $("#dob_label").show();
      $("#lname_label").hide();

      return false;
    }

  });


  
$("#post_submit_action").click(function() {
   title = $("#post_title").val();
   content = $("#post_content").val();
   user_type = $("#post_user_type").val();
  
    if (title.trim() === "") {
      $("#title_label").show();
      $("#content_label").hide();
      $("#user_label").hide();

      return false;
    }
    if (content.trim() === "") {
      $("#content_label").show();
      $("#user_label").user      
      $("#title_label").hide();
      return false;
    }  
    if(user_type == "")
    {
      $("#content_label").hide();
      $("#title_label").hide();
      $("#user_label").show();           
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
 
 $("#category_submit_action").click(function() {
   name = $("#category_category_name").val(); 
    if (name.trim() === "") {
      $("#category_name_label").show();
      return false;
    }
  });

$("#file_upload").click(function() {
   name = $("#upload_csv_file").val(); 
    if (name.trim() === "") {
      $("#file_label").show();
      return false;
    }
  });
$("#event_submit_action").click(function() {
   name = $("#event_event_name").val();
   host_name = $("#event_host_name").val();
   place = $("#event_place").val();
   link = $("#event_link").val();
   city = $("#event_city").val();
   time = $("#event_event_time").val();
   date = $("#event_event_date").val();
    if (name.trim() === "") {
      $("#event_name_label").show();
      $("#host_name_label").hide();      
      $("#city_label").hide();
      $("#link_label").hide();
      $("#event_date_label").hide();
      $("#event_time_label").hide();
      $("#place_label").hide();
      return false;
    }
    if (host_name.trim() === "") {
      $("#event_name_label").hide();
      $("#host_name_label").show();      
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
      $("#host_name_label").hide();      
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
      $("#host_name_label").hide();      
      $("#event_name_label").hide();
      return false;
    } 
    if (date.trim() === "") {
      $("#event_date_label").show();
      $("#event_time_label").hide();
      $("#place_label").hide();
      $("#host_name_label").hide();      
      $("#event_name_label").hide();
      $("#city_label").hide();
      $("#link_label").hide();
      return false;
    } 
   if (link.trim() === "") {
      $("#link_label").show();
      $("#event_date_label").hide();
      $("#city_label").hide();
      $("#host_name_label").hide();      
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
      $("#host_name_label").hide();      
      $("#place_label").hide();
      $("#event_name_label").hide();
      return false;
    }  
  });

    $("#event_event_time").pickatime();

});

