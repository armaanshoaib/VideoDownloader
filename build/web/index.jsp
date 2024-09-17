<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Video Downloader</title>
        <link type="image/png" sizes="32x32" rel="icon" href="https://img.icons8.com/bubbles/100/download.png">

        <style>
            body {
                font-family: 'Segoe UI';
                display: flex;
                justify-content:center ;
                align-items: center;
                height: 100vh;
                margin: 30px;
                align-items: flex-start;
                background: linear-gradient(to bottom, #AF8865, #5A2E0E);

            }
            .container {
                background-color: #262333;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 700px;
                width: 100%;
                text-align: center;
                border: 1px solid wheat;
                box-sizing: border-box;
            }
            #title {
                font-size: 40px;
                font-family:'Segoe UI';
                margin:20px;
                color: wheat;
            }
            .options {                
                margin-bottom: 20px;
            }

            .options input[type="radio"] {
                display: none;
                /* hides radio buttons */
            }

            .options label {
                display: inline-block;
                cursor: pointer;
                margin-right: 10px;
                transition: 0.2s;
            }

            .options img {
                vertical-align: middle;
                height: 60px;
                width: 60px;                
                border-radius: 90%;
                transition: border-color 0.2s;
            }

            .options input[type="radio"]:checked + label img {
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1), 0 0 0 4px #b5c9fc;
            }

            .options label:hover {
                transform: scale(1.1);
            }

            #selectOpt {
                font-size: 16px;
                color: #555;
            }

            #urlInput {
                padding: 10px;
                width: 100%;
                max-width: 600px;
                border-radius: 40px;
                margin: 10px 0;
                font-size: 18px;
                box-sizing: border-box;
                background-color: #2D2839;
                border-color: white;
                text-align: center;
                color: white;
            }

            #YTinputForm,#IGinputForm,#FBinputForm{
                display: none;
                animation-name: fade-in;
                animation-duration: 0.5s;
            }

            @keyframes fade-in {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            #downBtn {
                margin-top: 10px;
                padding: 12px 25px;
                font-size: 1.2em;
                color: white;
                background-color: #0072ff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.5s;
            }

            #downBtn:hover {
                background-color: #5568AB;
            }
            #fetching{
                display: none;
                margin-top: 20px;
                font-size: 15px;
                color: yellow;
            }

            #proj,#selectOpt {
                margin-top: 20px;
                font-size: 15px;
                color: yellow;
            }

            #git {
                color: violet;
            }

        </style>
        <script>
            
            function showForm(platform) {
                document.getElementById("YTinputForm").style.display = 'none';
                document.getElementById("IGinputForm").style.display = 'none';
                document.getElementById("FBinputForm").style.display = 'none';

                if (platform == "YouTube") {
                    document.getElementById("YTinputForm").style.display = 'block';
                } else if (platform == "Instagram") {
                    document.getElementById("IGinputForm").style.display = 'block';
                } else if (platform == "Facebook") {
                    document.getElementById("FBinputForm").style.display = 'block';
                }
                document.getElementById("selectOpt").style.display = 'none';
            }
            function fetching() {
                document.getElementById("fetching").style.display = 'block';
            }
        </script>
    </head>
    <body>
        <div class="container">
            <p id="title">Social Media Video Downloader</p>

            <div class="options">
                <input type="radio" id="youtube" name="platform" value="youtube" onclick="showForm('YouTube')">
                <label for="youtube">
                    <img src="yt-logo.png" alt="YouTube">
                </label>
                <input type="radio" id="instagram" name="platform" value="instagram" onclick="showForm('Instagram')">
                <label for="instagram">
                    <img src="ig-logo.png" alt="Instagram">
                </label>
                <input type="radio" id="facebook" name="platform" value="facebook" onclick="showForm('Facebook')">
                <label for="facebook">
                    <img src="fb-logo.png" alt="Facebook">
                </label>
                <p id="selectOpt">Select any option to continue...</p>
            </div>

            <p id="fetching" style='display:none;'> Fetching Results... </p>

            <form id="YTinputForm"  action="saveYTVid.jsp" method="post">
                <input id ="urlInput" name = "ytUrl" placeholder="www.youtube.com/watch?v=XXXXX" required >
                <br>                
                <button id='downBtn' onclick="fetching()" type = 'submit'>Download Youtube Video</button>
                <p id ="proj"> Project by Armaan Shoaib. <a href="https://github.com/armaanshoaib" style="text-decoration: none"><span id = 'git'>GitHub</span></a> </p>
            </form>

            <form id="IGinputForm"  action="saveIGReel.jsp" method="post">
                <input id ="urlInput" name = "igURL"  placeholder="Paste Instagram Reel URL here..." required >
                <br>               
                <button id='downBtn' onclick="fetching()" type = 'submit'>Download Reel</button>
                <p id ="proj"> Project by Armaan Shoaib. <a href="https://github.com/armaanshoaib" style="text-decoration: none"><span id = 'git'>GitHub</span></a> </p>
            </form>

            <form id="FBinputForm"  action="saveFBVid.jsp" method="post">
                <input id ="urlInput" name = "fbVidURL"placeholder="www.facebook.com/share/v/XXXXX" required >
                <br>                
                <button id='downBtn' onclick="fetching()" type = 'submit'>Download Facebook Video</button>
                <p id ="proj"> Project by Armaan Shoaib. <a href="https://github.com/armaanshoaib" style="text-decoration: none"><span id = 'git'>GitHub</span></a> </p>
            </form>

        </div>
    </body>
</html>
