<%-- 
    Document   : tampilanAwal
    Created on : 19 Nov 2024, 19.59.23
    Author     : putri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome to Our School App</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f8f9fc;
            }
            .container {
                text-align: center;
                padding: 20px;
                max-width: 360px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                font-size: 24px;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            .icon {
                display: inline-block;
                width: 80px;
                height: 80px;
                margin: 20px auto;
                position: relative;
                background-color: #d1f7ff;
                border-radius: 50%;
            }
            .icon::before {
                content: '';
                display: block;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 40px;
                height: 40px;
                background: url('checkmark.png') center/contain no-repeat;
            }
            .headline {
                font-size: 16px;
                color: #666;
                margin: 10px 0;
            }
            .button {
                display: inline-block;
                padding: 10px 20px;
                background-color: #b3e5fc;
                color: #fff;
                font-size: 14px;
                text-align: center;
                text-decoration: none;
                border-radius: 5px;
                margin-top: 20px;
                cursor: pointer;
            }
            .button:hover {
                background-color: #81d4fa;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Welcome to Our School App</h1>
            <div class="icon"></div>
            <p class="headline">Headline goes here. Brief description of the app.</p>
            <!-- Sign in -->
            <a href="SignIn.jsp" class="button">Get Started</a>
        </div>
    </body>
</html>
