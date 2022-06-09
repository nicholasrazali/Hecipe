<!DOCTYPE html>
<html lang="en">
<head>
    
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="./public/css/lib/bootstrap.min.css">
    <script src="./public/js/lib/jquery-3.6.0.min.js"></script>
    <script src="./public/js/lib/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/style.css">

</head>
<body>
    <%@ include file="header.jsp" %>
    

    <%
        out.println("Hallo, " + session.getAttribute("role"));
    %>

    <%@ include file="footer.jsp" %>
    
</body>
</html>