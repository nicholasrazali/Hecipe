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
    
    <%-- Header --%>
    <%  if(session.getAttribute("role") == null){ %>
    <%@     include file="header.jsp" %>
    <%  }else if(session.getAttribute("role") == "admin"){%>
    <%@     include file="adminheader.jsp" %>
    <%  }else {%>
    <%@     include file="memberheader.jsp" %>
    <%  } %>

    <form action="" method="get">
        <input type="text" name="search" id="">
         <button type="submit">Search</button>
    </form>

    <%  if(session.getAttribute("role") == "admin"){ %>
        <a href="addfood.jsp"><input type="button" value="Add new food"></a>
    <% } %>

    <br>
    <table>
        <%  if(session.getAttribute("role") == null){ %>
        <tr>
            <td>Image</td>
            <td>Name</td>
            <td>Category</td>
            <td>Price</td>
        </tr>
        <% } else{ %>
            <tr>
                <td>Image</td>
                <td>Name</td>
                <td>Category</td>
                <td>Price</td>
                <td>Action</td>
            </tr>
        <% } %>
    </table>


    <%@ include file="footer.jsp" %>
    
</body>
</html>