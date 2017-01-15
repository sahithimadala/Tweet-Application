<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Facebook App</title>
</head>
<body>
<div id="status"></div>
<script type="text/javascript" src="fb.js"></script>
<script>
    //This is called with the results from from FB.getLoginStatus().

  		function statusChangeCallback(response) {

        console.log('statusChangeCallback');

        console.log(response);

        // The response object is returned with a status field that lets the

        // app know the current login status of the person.

        // Full docs on the response object can be found in the documentation

        // for FB.getLoginStatus().

        if (response.status === 'connected') {

              // Logged into your app and Facebook.

               testAPI();

         } else if (response.status === 'not_authorized') {

              // The person is logged into Facebook, but not your app.

               document.getElementById('status').innerHTML = 'Please log ' +'into this app.';

         } else {

               // The person is not logged into Facebook, so we're not sure if

               // they are logged into this app or not.

               document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';

         }

  }



  // This function is called when someone finishes with the Login

  // Button. See the onlogin handler attached to it in the sample

  // code below.

  function checkLoginState() {

         FB.getLoginStatus(function(response) {

               statusChangeCallback(response);

         });

  }


  // Here we run a very simple test of the Graph API after login is

  // successful. See statusChangeCallback() for when this call is made.

  function testAPI() {
		
         //window.location="tweet.jsp";
         FB.api('/me',function(response){
        	 document.getElementById('uname').value=response.name;
        	 //alert(response.name);
        	 document.getElementById('tweet').style.display='inline';
         })

  }

  window.fbAsyncInit = function() {

  FB.init({

	  appId : '1101308109914171',

        cookie : true, // enable cookies to allow the server to access 

        // the session

        xfbml : true, // parse social plugins on this page

        version : 'v2.5' // use version 2.5

  });



  // Now that we've initialized the JavaScript SDK, we call 

  // FB.getLoginStatus(). This function gets the state of the

  // person visiting this page and can return one of three states to

  // the callback you provide. They can be:

  

  // 1. Logged into your app ('connected')

  // 2. Logged into Facebook, but not your app ('not_authorized')

  // 3. Not logged into Facebook and can't tell if they are logged into

  // your app or not.

  //

  // These three cases are handled in the callback function.



  FB.getLoginStatus(function(response) {

        statusChangeCallback(response);

        });



  };

// Load the SDK asynchronously

  (function(d, s, id) {

        var js, fjs = d.getElementsByTagName(s)[0];

        if (d.getElementById(id)) return;

        js = d.createElement(s); js.id = id;

        js.src = "//connect.facebook.net/en_US/sdk.js";

        fjs.parentNode.insertBefore(js, fjs);

  }(document, 'script', 'facebook-jssdk'));


</script>
    <fb:login-button scope="public_profile,email,user_friends" onlogin="checkLoginState();">
   </fb:login-button>
   <br></br>
   <div id="tweet" style="display:none"/>
   <form action="/store" method="get">
   <input type="submit" value="Try Tweet Application" id="tapp" onclick="location.href='/tweet.jsp?'"/>
   <input type="hidden" value="uname" id="uname" name="uname"/>
   </form>
   </div>
</body>
</html>