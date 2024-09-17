<%-- 
    Document   : download
    Created on : 12-Sep-2024, 9:59:19 pm
    Author     : shaik
--%>
<%@page import="java.net.http.HttpRequest" %>
<%@page import="java.net.URI" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.net.http.*" %>
<%@page import="org.json.*" %>


<%  // //========================MAIN API LOGIC=========================
   String igURL = request.getParameter("igURL");
   String reelURL = "https://instagram-scraper-api2.p.rapidapi.com/v1/post_info?code_or_id_or_url="+igURL + "&url_embed_safe=true";
   HttpRequest req = HttpRequest.newBuilder()
                   .uri(URI.create(reelURL))
                   .header("x-rapidapi-key", "cea11f5bccmshdf4d7b192553da4p16a2d2jsn63aab5fe3783")
                   .header("x-rapidapi-host", "instagram-scraper-api2.p.rapidapi.com")
                   .method("GET", HttpRequest.BodyPublishers.noBody())
                   .build();
   HttpResponse<String> resp = HttpClient.newHttpClient().send(req, HttpResponse.BodyHandlers.ofString());
   System.out.println(resp.body());
   String respBody = resp.body();
   JSONObject jsonObject = new JSONObject(respBody); 
   System.out.println(jsonObject);
   String videoUrl = "null";
   if(jsonObject.has("data")){
       videoUrl= jsonObject.getJSONObject("data").getString("video_url");
   }

%>
<!-- ======================================================================= -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reels Downloader</title>
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

            #igLogo {
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

            #goBack {
                color: greenyellow;
                font-family: Verdana, sans-serif;
                font-size: 28px;
            }
            
        </style>
    </head>
    <body>
        <% if(resp.statusCode() == 200 && videoUrl != "null"){ %>
        <div class="container">
            <img id = "igLogo" height="70px"
                 width = 230px src="igLogo.png" />
            <br>
            <video controls id="vid">              
                <source src="<%= videoUrl %>" type="video/mp4">         
            </video>
            <div>
            <button class="btn-download" >
                <a style="margin: 10px; text-decoration: none; font-size: 18px; margin-right: 20px" href="<%= videoUrl %>"> Download Reel </a>               
                <img src="download-gif.gif" height="40" width="40">
            </button>
            </div>
        </div>
        <% } else{ %>
        
        <div id="error">
            <p id="errMsg"> Uh Oh! Error occurred! The video is either private or the URL is incorrect!! </p>
            <a href="index.jsp" id="goBack"> Click here to retry. </a>
        </div>
        <% } %>
        

    </body>
</html>



