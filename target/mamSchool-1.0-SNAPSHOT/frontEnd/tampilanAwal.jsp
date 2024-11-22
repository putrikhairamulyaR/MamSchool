<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome to Mam School App</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f5fa 
            }
            .container {
                text-align: center;
                background: #ffffff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                width: 90%;
                max-width: 400px;
            }
            .icon {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 120px; /* Perbesar lingkaran */
                height: 120px;
                background-color: #d1f7ff; 
                border-radius: 50%;
                margin: 20px auto;
                overflow: hidden; 
            }
            .icon img {
                width: 100%; 
                height: 100%; 
                object-fit: cover; 
            }
            h1 {
                font-size: 22px;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            .headline {
                font-size: 10px;
                color: #666;
                margin-bottom: 20px;
            }
            .button {
                display: inline-block;
                width: 100%;
                padding: 12px 0;
                background-color: #4682b4; 
                color: #fff;
                font-size: 16px;
                font-weight: bold;
                text-align: center;
                text-decoration: none;
                border-radius: 8px;
                transition: background-color 0.3s ease;
            }
            .button:hover {
                background-color: #5ba9cd; 
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Welcome to Our School App</h1>
            <div class="icon">
                <img src="/mamSchool/Image/logo.jpeg" alt="logo">
            </div>
            <p class="headline">Langkah kecil hari ini, adalah awal dari masa depan yang besar.</p>
            <!-- Sign in-->
            <a href="SignIn.jsp" class="button">Get Started</a>
        </div>
    </body>
</html>
