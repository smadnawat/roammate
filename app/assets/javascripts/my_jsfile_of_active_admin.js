$(document).ready(function() {
  $("#profile_submit_action").click(function() {
    var email, fname, gender;
    email = $("#profile_email").val();
    fname = $("#profile_first_name").val();
    gender = $("#profile_gender").val();
   
    if (email.trim() === "") {
      window.alert("Email can not be null");
      return false;
    }
    if (fname.trim() === "") {
      window.alert("First name can not be null");
      return false;
    }
    if (gender.trim() === "") {
      window.alert("Please select gender");
      return false;
    }
  });

 $("#interest_submit_action").click(function() {
 	 name = $("#interest_interest_name").val();
   description = $("#interest_description").val();

	 if (name.trim() == "") {
	  window.alert("Name can not be null");
	  return false;
	 }

    if (description.trim() === "") {
      window.alert("Description can not be null");
      return false;
    }
	});

 $("#question_submit_action").click(function() {
   question = $("#question_question").val();
    if (question.trim() === "") {
      window.alert("Question can not be null");
      return false;
    }
  });
$("#event_submit_action").click(function() {
   name = $("#event_event_name").val();
   place = $("#event_place").val();
   link = $("#event_link").val();
   city = $("#event_city").val();
   time = $("#event_time").val();

    if (name.trim() === "") {
      window.alert("Event name can not be null");
      return false;
    }
    if (place.trim() === "") {
      window.alert("Event place can not be null");
      return false;
    }  
   if (link.trim() === "") {
      window.alert("Event link can not be null");
      return false;
    }  
     if (time.trim() === "") {
      window.alert("Event time can not be null");
      return false;
    }  
   if (city.trim() === "") {
      window.alert("Event city can not be null");
      return false;
    }  
  });

$("#post_submit_action").click(function() {
   title = $("#post_title").val();
   content = $("#post_content").val();
   image = $("#post_image").val();
 
    if (title.trim() === "") {
      window.alert("Event title can not be null");
      return false;
    }
    if (content.trim() === "") {
      window.alert("Event content can not be null");
      return false;
    }  
   if (image.trim() === "") {
      window.alert("Event image can not be null");
      return false;
    }  
  });
 
 $("#category_submit_action").click(function() {
   name = $("#category_category_name").val(); 
    if (name.trim() === "") {
      window.alert("Category name can not be null");
      return false;
    }
  });

});
