
<%@page import="java.net.http.HttpRequest" %>
<%@page import="java.net.URI" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.net.http.*" %>
<%@page import="org.json.*" %>

        
<%
    // //========================MAIN API LOGIC=========================
   String fbUrl = request.getParameter("fbVidURL");
   String fbVidURL = "https://social-media-video-downloader.p.rapidapi.com/smvd/get/facebook?url="+fbUrl+"&filename=FB_Video_thru_AS";
   HttpRequest req = HttpRequest.newBuilder()
		.uri(URI.create(fbVidURL))
		.header("x-rapidapi-key", "cea11f5bccmshdf4d7b192553da4p16a2d2jsn63aab5fe3783")
		.header("x-rapidapi-host", "social-media-video-downloader.p.rapidapi.com")
		.method("GET", HttpRequest.BodyPublishers.noBody())
		.build();
   HttpResponse<String> resp = HttpClient.newHttpClient().send(req, HttpResponse.BodyHandlers.ofString());
   String respBody = resp.body();
   JSONObject jsonObject = new JSONObject(respBody); 
   //System.out.println(jsonObject);
   String hdVideoLink = "null";
   String sdVideoLink = "null";
   String audioLink = "null";
   if(resp.statusCode() == 200 && jsonObject.has("links")){
        JSONArray linksArray = jsonObject.getJSONArray("links");
        hdVideoLink = linksArray.getJSONObject(1).getString("link");
        sdVideoLink = linksArray.getJSONObject(0).getString("link");
        audioLink = linksArray.getJSONObject(4).getString("link");
   }

%>
<!-- ======================================================================= -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Facebook Video Downloader</title>
        <link rel="icon" href="downLogo.png" type="image/x-icon" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
               font-family: 'Segoe UI';
                background: #07012C;
                display: flex;
                justify-content: center;
                align-items: flex-start; 
                height: 100vh;
                margin: 0;
                animation-name: fade-in;
                animation-duration: 2s;
            }

            @keyframes fade-in {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .container {
                padding: 20px;
                margin-top: 20px; 
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                text-align: center;
                border: 1px solid wheat;
                max-width: 90%;
                box-sizing: border-box;
            }

            #vid {
                width:300px;
                height: 450px;
                overflow: hidden;
                border-radius: 20px;
                margin-bottom: 20px;
                box-shadow: 4px 4px 88px rgba(255, 255, 255, 0.27);
            }

            .btn-download {
                background-color: #4CAF50;
                color: white;
                font-family: Verdana, sans-serif;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s;
                width: 100%;
                box-sizing: border-box;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top : 10px;
                margin-bottom: 10px;
            }


            .btn-download:hover {
                background-color: #5568AB;
            }

            #fbLogo {
                overflow: hidden;
                margin-bottom: 20px;
                mix-blend-mode: color-dodge;
            }

            #error {
                background-color: #07012C;
                padding: 20px;
                margin: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                text-align: center;
                border: 1px solid wheat;
                max-width: 90%;
                box-sizing: border-box;
            }

            #errMsg {
                color: red;
                font-family: Consolas, monospace;
                font-size: 28px;
            }

            #goBack{
                color: greenyellow;
                font-family: Verdana, sans-serif;
                font-size: 28px;
            }
            #nextVid{
                color: yellow;
                font-family: Verdana, sans-serif;
                font-size: 18px;
            }


        </style>
    </head>
    <body>
        <% if(resp.statusCode() == 200 && hdVideoLink != "null" && sdVideoLink != "null"  && audioLink != "null"){ %>
        <div class="container">
            <img id = "fbLogo.png" src="fbLogo.png" height="70px"
                 width = 220px  />
            <br>
            <video controls id="vid">              
                <source src="<%= hdVideoLink %>" type="video/mp4">         
            </video>
            <br>

            <button class="btn-download" >
                <a style="margin: 10px; text-decoration: none;" href="<%= hdVideoLink %>"> Download HD Video </a>                
                <img src="hd.gif" height="40" width="40">
            </button>
            <button class="btn-download" >
                <a style="margin: 10px; text-decoration: none;" href="<%= sdVideoLink %>"> Download Low Quality Video </a>                
                <img src="download-gif.gif" height="40" width="40">
            </button>
            <button class="btn-download" >
                <a style="margin: 10px; text-decoration: none;" href="<%= sdVideoLink %>"> Download Audio Only </a>               
                <img src="music-note.gif" height="40" width="40">
            </button>
                
            <a id="nextVid" href="index.jsp"> Download another video here ... </a>

        </div>
        <% } else{ %>     
        
        <div id="error">
            <p id="errMsg"> Uh Oh! Error occurred! The video is either private or the URL is incorrect!! </p>
            <a href="index.jsp" id="goBack"> Click here to retry. </a>
        </div>       
               
        <% } %>
        
    </body>
</html>



