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

    <p> <%= session.getAttribute("error") == null ? "" : session.getAttribute("errorfood") %></P>

    <form action="controller/addfoodController.jsp" method="get">
        <table>
            <tr>
                <td>Name: </td>
                <td><input type="text" name="foodname" id=""></td>
            </tr>
            <tr>
                <td>Category:</td>
                <td><select id="category" name="category">
                    <option value="Meats">Meats</option>
                    <option value="Vegetarian">Vegetarian</option>
                    <option value="Snack">Snack</option>
                </select></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td><textarea name="description" id="" cols="20" rows="2"></textarea></td>
            </tr>
            <tr>
                <td>Price:</td>
                <td><input type="number" name="foodprice" id="foodprice"></td>
            </tr>
            <tr>
                <td>Quantity:</td>
                <td><input type="number" name="foodqty" id="foodqty"></td>
            </tr>
            <tr><td><button type="submit">Add Food</button></td></tr>
        </table>
    </form>

    <br>



    <%@ include file="footer.jsp" %>
    
</body>
</html>