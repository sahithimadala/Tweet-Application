<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Facebook App</title>
</head>
<body align="center" background="bg.jpg">
<div id="status"></div>
<script type="text/javascript" src="fb.js"></script>
<br> </br>
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
   <br>
   <h1 align="center" style="font-size:40px;color:white;font-family:Arial;font-weight:400;"><b>Tweet Application</b></h1>
 	<br/>
   <br/>
   <nav>
   	<ul>
   		<li><a href="tweet.jsp">Tweets</a></li>
   		<li><a href="Tweetfriends.jsp">Friends Tweets</a></li>
   		<li><a href="TopTweets.jsp">Top Tweets</a></li>
   	</ul>
   	</nav>
   	</br>
   	
   	
   	
   	
   	<p align="justify">
   		
   			<h2 align="center" style="color:white"><u>Post your Tweet here..!!</u></h2>
   		<div class="dsa">
   			<p id="mp" align="center"></p>
   		</div>
   		<br> </br></p>
   		
   		
   		
   		<div id="display_tweet" style="display:none;">
   			<form action="/store" method="post">
   			<div>
<div id="status">
</div>


<div>
   				<textarea name="message" rows="7" cols="30" id="message"></textarea>
   				<br> </br>

<input type="button" id="send" value="Post on your timeline!" onclick="testMessageCreate();"/>
<br></br>

<div id="theText"></div>

   				<input type="hidden" id="Username" name="Username"/>
   				<input type="hidden" id="UserId" name="UserId"/>
   				<input type="hidden" id="image" name="image"/>
   				
   			</div>
   			</form>
   			<div>
   				<input type="submit" id="send" value="Share your Tweet!" onclick="sendmessage();"> <label for="send"></label>
   			</div>
   			</div>
   			<br>
   			<h2 align="center" style="color:white"><u> List of Tweets</u></h2>
   		 
   		<%
   		   String name=(String)session.getAttribute("name");
   		   DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
   		   Filter keyfilter = new FilterPredicate("Username",FilterOperator.EQUAL,name); 
   		   Query q= new Query("Tweet").setFilter(keyfilter); 
   		   List<Entity> tweets = ds.prepare(q).asList(FetchOptions.Builder.withLimit(30));
   		 
   		 %>
   		 <div style="height: 200px; overflow: auto">
   		 <table align="center" id="tblid">
   		 <tbody>
   		 <tr>
   		 <th align="center" font-size:16px">
   		 Tweets
   		 </th>
   		 <th align="center" style="font-size:16px">
   		 UserName
   		 </th>
   		 &nbsp;&nbsp;&nbsp;
         <th>
         <form action="${pageContext.request.contextPath}/delete" method="post">
  			<input type="submit" value="Delete"/>
  			<input type="hidden" id="delete" name="delete"/>  
  	    </form>
         </th>
   		 <br> </br>
   		 </tr>
 		 <% 
   		   for(Entity tweet: tweets)
   			{ 
  				  String message=(String)tweet.getProperty("TweetMessage");
  				  String usrname=(String)tweet.getProperty("Username"); 
  				  String usrid=(String)tweet.getProperty("UserId");
  				  String image=(String)tweet.getProperty("picture");
  				  //String tweetid=(String)tweet.getProperty("Name/ID");
  				  //Long id=tweet.getKey().getId();
  	   	  %>
            	<tr> 
  				<td>
  				<%=message %>
  				</td>
  				<td>
  				<%=usrname %>
  			   </td>
  			   <td hidden="true"> <%= KeyFactory.keyToString(tweet.getKey()) %> </td>
  			   <td>
  			   &nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkbox" name="chkbox" onclick="deleteTweet()"/>
  			   </td>
  			   </tr>
   		
        <%  }  %>
      
        </tbody>
        </table>
        </div>
   	<div id="the_Text">
   	</div>
   	<div id="the msg">
   	</div>
   	<div id="the name">
   	</div>
   	</p>
   	<!--<script type="text/javascript" src="fb.js"></script>-->
   	<script type="text/javascript">
 
   	
   	// Here we run a very simple test of the Graph API after login is
 // successful to post a message to the user me. See statusChangeCallback() for when this call is made.
 function testMessageCreate() {
 
  FB.login(function(){
        var tweetmessage = document.getElementById("message").value;
         FB.api('/me/feed', 'post', {message: tweetmessage});
         document.getElementById('theText').innerHTML = 'Thanks for posting the tweet : ' + tweetmessage;
    }, {scope: 'publish_actions'});
 }
   	 
   	function showform()
   	{

   		document.getElementById('display_tweet').style.display='inline';
   		getUserDetails();
   		
   	}
   	document.getElementById('mp').innerHTML = showform();
   	function create_message()
   	{
   		//alert("Hello");
   		
   		var tweetmessage=document.getElementById('message').value;
   		post_tweet(tweetmessage);
   
    	}
  	function sendmessage()
  	{
   		send_message();
   	}
   	function deleteTweet()
   	{
   		var table = document.getElementById("tblid");
   		var rows = table.getElementsByTagName("tr");
   		for (i = 0; i < rows.length; i++) {
   	        var currentRow = table.rows[i];
   	        var createHandler=
   	        	function(row) 
   	            {
   	                return function() { 
   	                                        var cell = row.getElementsByTagName("td")[2];
   	                                        var id = cell.innerText;
   	                                        document.getElementById('delete').value=id;
   	                                        //var id=document.getElementById('delete').value
   	                                        //alert("ID: "+id);
   	                                        //document.write(id);
   	                                       
   	                                 };
   	            };

   	        currentRow.onclick = createHandler(currentRow);
   	    }
   	}
   	
 function post_tweet(tweetmessage)
   	{
	 document.getElementById('post').checked=false;
   	FB.login(function() {

   	       // var typed_text = document.getElementById("message").value;
   		    
   			FB.api('/me/feed', 'post', {message: tweetmessage});
   			//document.getElementById('the_Text').innerHTML='Thanks for posting the message';

   	    }, {scope: 'publish_actions'});

   	
   	  //document.getElementById('display_tweet').style.display='none';
   	  //window.location="tweet.jsp";
   	}
 function getUserDetails()
 {
 		FB.api('/me?fields=name,id,picture',function(response){
 			document.getElementById('Username').value=response.name;
 			document.getElementById('UserId').value=response.id;
 			document.getElementById('uname').value=response.name;
 			document.getElementById('image').value=response.picture.data.url;
 		});
 }
 function send_message()
 {
	 document.getElementById('send').checked=false;
 		FB.ui({
 		method: 'share',
 		href:'https://apps.facebook.com/myfbtweetapp/tweet.jsp'
 		});		
 }
 window.fbAsyncInit = function() {

	  FB.init({

		  appId : '1101308109914171',
	        cookie : true, // enable cookies to allow the server to access 

	        // the session

	        xfbml : true, // parse social plugins on this page

	        version : 'v2.5' // use version 2.5

	  });
	  
	  function checkLoginState() {

	      FB.getLoginStatus(function(response) {

	            statusChangeCallback(response);

	      });

	}
	  
	  // function to check the login status
	  
	  function statusChangeCallback(response) {

	      console.log('statusChangeCallback');

	      console.log(response);

	      // The response object is returned with a status field that lets the

	      // app know the current login status of the person.

	      // Full docs on the response object can be found in the documentation

	      // for FB.getLoginStatus().

	      if (response.status === 'connected') {

	            // Logged into your app and Facebook.

	             //testAPI();
	    	  //document.getElementById('status').innerHTML='succesfully connected';

	       } else if (response.status === 'not_authorized') {

	            // The person is logged into Facebook, but not your app.

	             document.getElementById('status').innerHTML = 'Please log ' +'into this app.';

	       } else {

	             // The person is not logged into Facebook, so we're not sure if

	             // they are logged into this app or not.

	             document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';

	       }

	}
	  
	  FB.getLoginStatus(function(response) {

	        statusChangeCallback(response);

	        },{scope:'user_friends,user_birthday,email,publish_actions'});

	  };


	// Load the Facebook SDK asynchronously

	  (function(d, s, id) {

	        var js, fjs = d.getElementsByTagName(s)[0];

	        if (d.getElementById(id)) return;

	        js = d.createElement(s); js.id = id;

	        js.src = "//connect.facebook.net/en_US/sdk.js";

	        fjs.parentNode.insertBefore(js, fjs);

	  }(document, 'script', 'facebook-jssdk'));
   	 	
   	</script>
</body>
</html>