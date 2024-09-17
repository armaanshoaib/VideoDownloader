<%-- 
    Document   : saveYTVid
    Created on : 16-Sep-2024, 8:56:23 pm
    Author     : shaik
--%>
<%@page import="java.net.http.HttpRequest" %>
<%@page import="java.net.URI" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.net.http.*" %>
<%@page import="org.json.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>YouTube Video Downloader</title>
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


            @keyframes fade-in {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            #vid {
                width: 100%; 
                height: 100%;
                object-fit: cover;
                overflow: hidden;
                border-radius: 20px;
                margin-top: 20px;
                margin-bottom: 20px;
                box-shadow: 4px 4px 88px rgba(255, 255, 255, 0.27);
            }
            #vidName{
                font-family: 'Segoe UI';
                font-size : 15px;
                color: gray;
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
                margin-top: 20px;
                color: yellow;
                font-family: Verdana, sans-serif;
                font-size: 18px;
            }


        </style>
    </head>
    <%
        // //========================MAIN API LOGIC=========================
                //fetching video ID-----
        String ytUrl = request.getParameter("ytUrl");
        String vidUrl = "https://yt-api.p.rapidapi.com/resolve?url="+ ytUrl;     
        HttpRequest urlResolve = HttpRequest.newBuilder()
		.uri(URI.create(vidUrl))
		.header("x-rapidapi-key", "cea11f5bccmshdf4d7b192553da4p16a2d2jsn63aab5fe3783")
		.header("x-rapidapi-host", "yt-api.p.rapidapi.com")
		.method("GET", HttpRequest.BodyPublishers.noBody())
		.build();
        System.out.println("Video URL: " + vidUrl);

        HttpResponse<String> idResp = HttpClient.newHttpClient().send(urlResolve, HttpResponse.BodyHandlers.ofString());
        String idRespBody = idResp.body();
        JSONObject jsonObject = new JSONObject(idRespBody);
        String vidId = "null";
        if(idResp.statusCode() == 200 && jsonObject.has("videoId")){
            vidId = jsonObject.getString("videoId");
        } 
        System.out.println(idResp.statusCode());
        System.out.println(jsonObject.has("videoId"));
        System.out.println(vidId);
        // ---------- fetching VIDEO DATA--------------
        String videoLink = "null";
        String vidName = "null";
        if(vidId != "null"){
            vidId = "https://yt-api.p.rapidapi.com/dl?id=" + vidId;
            HttpRequest req = HttpRequest.newBuilder()
                    .uri(URI.create(vidId))
                    .header("x-rapidapi-key", "cea11f5bccmshdf4d7b192553da4p16a2d2jsn63aab5fe3783")
                    .header("x-rapidapi-host", "yt-api.p.rapidapi.com")
                    .method("GET", HttpRequest.BodyPublishers.noBody())
                    .build();
            HttpResponse<String> resp = HttpClient.newHttpClient().send(req, HttpResponse.BodyHandlers.ofString());
            String respBody = resp.body();           
            if(resp.statusCode() == 200){          
                JSONObject jsonObject2 = new JSONObject(respBody);
                JSONArray formatArray = jsonObject2.getJSONArray("formats");
                videoLink = formatArray.getJSONObject(0).getString("url");
                vidName = jsonObject2.getString("title");
            }            
        }      

        //=============================================================================

    %>
    <body>
        <% if( videoLink != "null" ){ %>
        <div class="container">
            <img id = "ytLogo" src="ytLogo.png" height="80px"
                 width = "160"  />
            <br>
            <video controls id="vid">              
                <source src="<%= videoLink %>" type="video/mp4">         
            </video>
                <p id="vidName"> <%= vidName %> </p>
            <br>            
            <button class="btn-download" >
                <a style="margin: 10px; text-decoration: none;" href="<%= videoLink %>"> Download Video (360p only) </a>                
                <img src="download-gif.gif" height="40" width="40">
            </button>
            <!--
            <button class="btn-download" >
                <a style="margin: 10px; text-decoration: none;" href="<% //= sdVideoLink %>"> Download Low Quality Video </a>                
                <img src="download-gif.gif" height="40" width="40">
            </button>
            <button class="btn-download" >
                <a style="margin: 10px; text-decoration: none;" href="<% //= sdVideoLink %>"> Download Audio Only </a>               
                <img src="music-note.gif" height="40" width="40">
            </button>
            -->

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
