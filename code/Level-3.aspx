<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Level-3.aspx.cs" Inherits="SignalRDemo.Level_3" %>

<!doctype html>
<html>
	
<head>
		<title>Chat chat</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
   
    <script src="Scripts/jquery-1.12.0.min.js"></script>
      <script src="/Scripts/jquery.signalR-1.0.0.js"></script>
    <script src="/signalr/hubs"></script>
    <script src="Scripts/bootstrap.min.js"></script>
		<style>
			@media only screen and (max-width : 540px) 
			{
				.chat-sidebar
				{
					display: none !important;
				}
				
				.chat-popup
				{
					display: none !important;
				}
			}
			
		
			
			.chat-sidebar
			{
				width: 200px;
				position: fixed;
				height: 100%;
				right: 0px;
				top: 0px;
				padding-top: 10px;
				padding-bottom: 10px;
				border: 1px solid rgba(29, 49, 91, .3);
              background-color:#4e5d6c;
                
			}
			
			.sidebar-name 
			{
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 4px;
				font-size: 12px;
			}
			
			.sidebar-name span
			{
				padding-left: 5px;
			}
			
			.sidebar-name a
			{
				display: block;
				height: 100%;
				text-decoration: none;
				color: inherit;
			}
			
		
			.sidebar-name img
			{
				width: 32px;
				height: 32px;
				vertical-align:middle;
			}
			
			.popup-box
			{
				display: none;
				position: fixed;
				bottom: 0px;
				right: 220px;
				height: 285px;
				background-color: rgb(237, 239, 244);
				width: 300px;
				border: 1px solid rgba(29, 49, 91, .3);
			}
			
			.popup-box .popup-head
			{
				background-color: #6d84b4;
				padding: 5px;
				color: white;
				font-weight: bold;
				font-size: 14px;
				clear: both;
			}
			
			.popup-box .popup-head .popup-head-left
			{
				float: left;
			}
			
			.popup-box .popup-head .popup-head-right
			{
				float: right;
				opacity: 0.5;
			}
			
			.popup-box .popup-head .popup-head-right a
			{
				text-decoration: none;
				color: inherit;
			}
			
			.popup-box .popup-messages
			{
				height: 100%;
				overflow-y: scroll;
			}
			
			#carbonads { 
			    max-width: 300px; 
			    background: #f8f8f8;
			}

			.carbon-text { 
			    display: block; 
			    width: 130px; 
			}

			.carbon-poweredby { 
			    float: right; 
			}
			.carbon-text {
			    padding: 8px 0; 
			}

			#carbonads { 
			    padding: 15px;
			    border: 1px solid #ccc; 
			}

			.carbon-text {
			    font-size: 12px;
			    color: #333333;
			    text-decoration: none;
			}


			.carbon-poweredby {
			    font-size: 75%;
			    text-decoration: none;
			}

			#carbonads { 
			    position: fixed; 
			    top: 5px;
			    left: 5px;
			}

		</style>
		
		<script>
		    //this function can remove a array element.
		    Array.remove = function (array, from, to) {
		        var rest = array.slice((to || from) + 1 || array.length);
		        array.length = from < 0 ? array.length + from : from;
		        return array.push.apply(array, rest);
		    };

		    //this variable represents the total number of popups can be displayed according to the viewport width
		    var total_popups = 0;

		    //arrays of popups ids
		    var popups = [];

		    //this is used to close a popup
		    function close_popup(id) {
		        for (var iii = 0; iii < popups.length; iii++) {
		            if (id == popups[iii]) {
		                Array.remove(popups, iii);

		                document.getElementById(id).style.display = "none";

		                calculate_popups();

		                return;
		            }
		        }
		    }

		    //displays the popups. Displays based on the maximum number of popups that can be displayed on the current viewport width
		    function display_popups() {
		        var right = 220;

		        var iii = 0;
		        for (iii; iii < total_popups; iii++) {
		            if (popups[iii] != undefined) {
		                var element = document.getElementById(popups[iii]);
		                element.style.right = right + "px";
		                right = right + 320;
		                element.style.display = "block";
		            }
		        }

		        for (var jjj = iii; jjj < popups.length; jjj++) {
		            var element = document.getElementById(popups[jjj]);
		            element.style.display = "none";
		        }
		    }

		    //creates markup for a new popup. Adds the id to popups array.
		    function register_popup(id, name) {

		        for (var iii = 0; iii < popups.length; iii++) {
		            //already registered. Bring it to front.
		            if (id == popups[iii]) {
		                Array.remove(popups, iii);

		                popups.unshift(id);

		                calculate_popups();


		                return;
		            }
		        } 
     
		      //  var element = '<div class="popup-box chat-popup" id="' + id + '">';
		      // element = element + '<div class="popup-head">';
		      // element = element + '<div class="popup-head-left">' + name + '</div>';
		      // element = element + '<div class="popup-head-right"><a href="javascript:close_popup(\'' + id + '\');">&#10005;</a></div>';
		      // element = element + '<div style="clear: both"></div></div><div class="popup-messages ">asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br>asdsad<br></div>';
		//  element = element + '<div class="popup-footer">1weqweqw2asda</div></div>';



		        var element = '<div class="panel panel-default popup-box chat-popup" id="' + id + '">';
		        element = element + ' <div class="panel-heading" ><span  id="' + id + '-h" >' + name + '</span><span style="float:right"> <a href="javascript:close_popup(\'' + id + '\');">&#10005;</a> </span> </div>';
		       element = element + '  <div style="height:68%;color:black;overflow-y: scroll; " data-spy="scroll" class="panel-body" id="' + id + '-p" >';


		       element = element + '   </div> <div class="panel-footer"><input  class="   btn-sm""  id="' + id + '-t" type="text"/> <input  class="sendmessage btn btn-success  btn-sm"  value="Send Message"   id="' + id + '-b" type="button"/> </div> </div>';
   
                   







		       document.getElementsByTagName("body")[0].innerHTML = document.getElementsByTagName("body")[0].innerHTML + element;

		        popups.unshift(id);

		        calculate_popups();




		        var xmlHttp2;

        

		        var sid = document.getElementById('Label1').innerHTML;
		        var newid = document.getElementById('Label2').innerHTML;
		     
		        xmlHttp2 = new XMLHttpRequest();
		        var url2 = "ajax.aspx?sid=" + sid + "&rid=" + id + "&newid=" + newid + "&status=1";
		        xmlHttp2.open("GET", url2, true);
		        xmlHttp2.onreadystatechange = OnResponse2;
		        xmlHttp2.send(null);



		        function OnResponse2() {

		            if (xmlHttp2.readyState == 4) {
		                var res2 = xmlHttp2.responseText;

		                $('#' + id + '-p').empty();
		                $('#' + id + '-p').append(res2);

		               
		            }
		        }






















		    }

		    //calculate the total number of popups suitable and then populate the toatal_popups variable.
		    function calculate_popups() {
		        var width = window.innerWidth;
		        if (width < 540) {
		            total_popups = 0;
		        }
		        else {
		            width = width - 200;
		            //320 is width of a single popup box
		            total_popups = parseInt(width / 320);
		        }

		        display_popups();

		    }

		    //recalculate when window is loaded and also when window is resized.
		    window.addEventListener("resize", calculate_popups);
		    window.addEventListener("load", calculate_popups);

		</script>

	</head>
	<body class="container">

        <form runat="server">
            <style>
                #cond {
width: 960px; 
position: relative;
margin:0 auto;
line-height: 1.4em;
}

                @media only screen and (max-width: 479px) {
                    #cond {
                        width: 90%;
                    }
                }
            </style>

		<script async type="text/javascript" src="..Scripts/carbond123.js?zoneid=1673&amp;serve=C6AILKT&amp;placement=qnimate" id="_carbonads_js"></script>
        <br />
            <div class="row"><div class="col-lg-10">
                <div class="jumbotron" style="border-radius:5px">
                <h1>Welcome <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></h1>
                <p> <asp:Label ID="Label1" Font-Size="0.5px" runat="server" Text="Label"></asp:Label></p>
            </div></div></div>
               <div hidden="hidden" class="play">Play</div>
            
             <div class="panel-body" id="discussion">
                       
            
                        </div>
		<div class="chat-sidebar " id="pane" runat="server">
   

            



          <script>
              $(function () {
                  // Reference the auto-generated proxy for the hub.
                  var chat = $.connection.chatHub;
              

                  // Create a function that the hub can call back to display messages.
                  chat.client.addNewMessageToPage = function (name1, message, status) {
                      // Add the message to the page.
                      // message=id

                      if (status == 1) {

                          if ($("#" + message + "-i").length != 0) {
                              $("#" + message + "-i").attr("src", "css/g.png");

                          }



                      }
                      else
                          if (status == 2) {


                              if ($("#" + message + "-i").length != 0) {
                                  $("#" + message + "-i").attr("src", "css/d.png");

                              }
                          }

                          else if (status == 3) {
                              var arr = name1.split('}');
                           //  alert(arr[1] + " sent a mesage"+arr[0]);

                              $('#' + arr[0] + '-p').append('<div style="border-radius:5px" class="cond alert alert-dismissible alert-success">' + message + '</div>');


                              //   sound

                              var audioElement = document.createElement('audio');
                              audioElement.setAttribute('src', 'q.mp3');
                              audioElement.setAttribute('autoplay', 'autoplay');
                              //audioElement.load()

                              $.get();

                              audioElement.addEventListener("load", function () {
                                  audioElement.play();
                              }, true);

                              $('.play').click(function () {
                                  audioElement.play();
                              });

        
                            


                            var msg = new SpeechSynthesisUtterance(arr[1] + ' sent a message. Please scroll down');
                            window.speechSynthesis.speak(msg);
                            var msg1 = new SpeechSynthesisUtterance(message);
                            window.speechSynthesis.speak(msg1);

                              register_popup(arr[0], arr[1]);
                          }
                        
                  };

                

                  $.connection.hub.qs = { "id": $('#Label1').text() + "}" + $('#Label2').text() };


                  // Start the connection.

                  //  $('<p>Text</p>').appendTo('#Content');
                  $.connection.hub.start().done(function () {
                    
                     // function myFunction(clicked_id) {

                      $(document).on("click", ".sendmessage", function () {
                     // $('.sendmessage').click(function () {
                         var id = this.id;

                        
                         var arr = id.split('-');
                          var value1 = $('#' + arr[0] + '-t').val();

                          $('#' + arr[0] + '-p').append('<div style="border-radius:5px" class="cond alert alert-dismissible alert-warning">' + value1 + '</div>');
                         
                          // send to server
                          chat.server.send(arr[0], value1, document.getElementById('Label2').innerHTML, document.getElementById('Label1').innerHTML);
                          $('#' + arr[0] + '-t').val('');

                      }
                     
                      );

                

                  });
              });

           

         
    </script>


		</div>
            
      
	</form>
	</body>
      

</html>