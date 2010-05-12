jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} 
});

$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

function verify_email(field_name1 , field_name2 , message_area_name , form_name){
    if($('#'+field_name1).val() == $('#'+field_name2).val()){
        $('#'+form_name).submit();
    }else{
        $('#'+field_name1).attr('class', 'focus_elements' );
        $('#'+field_name2).attr('class', 'focus_elements' );
        $('#'+message_area_name).html("<span class='focus_elements' style='margin-left:10px;'>The Email Addresses Do Not Match, Please Ensure Both Email And The Verification Email Match.</span>");
    }
}

function clear_warning(field_name , message_area_name){
    $('#'+field_name).attr('class', '' );
    $('#'+message_area_name).html("&nbsp;");
}

