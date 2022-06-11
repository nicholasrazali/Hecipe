<%@include file="connect.jsp"%>
<%        
    String id = request.getParameter("id");
    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM food WHERE id = ('%s')",id);
    ResultSet rs = con.executeQuery(query);
    String foodname = "";
    String description = "";
    String category = "";
    int price = 0;
    int qty = 0;
    if(rs.next()){
        foodname = rs.getString("name");
        description = rs.getString("description");
        category = rs.getString("category");
        price = rs.getInt("price");
        qty = rs.getInt("quantity");
    }
%>
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

    <p> <%= session.getAttribute("errorfood") == null ? "" : session.getAttribute("errorfood") %></P>

    <form action="controller/editfoodController.jsp">
        <input type="hidden" name = "id" value="<%= id %>" >
        <table>
            <tr>
                <td>Name: </td>
                <td><input type="text" name="foodname" id="" value="<%=foodname%>"></td>
            </tr>
            
            <tr>
                <td>Category:</td>
                <% if(category.equals("Meats")){%>
                <td><select id="category" name="category" value="Vegetarian">
                    <option value="Meats" selected>Meats</option>
                    <option value="Vegetarian">Vegetarian</option>
                    <option value="Snack">Snack</option>
                </select></td>
                <% } else if(category.equals("Vegetarian")){%>
                <td><select id="category" name="category" value="Vegetarian">
                    <option value="Meats">Meats</option>
                    <option value="Vegetarian" selected>Vegetarian</option>
                    <option value="Snack">Snack</option>
                </select></td>
                <% } else {%>
                <td><select id="category" name="category" value="Vegetarian">
                    <option value="Meats">Meats</option>
                    <option value="Vegetarian">Vegetarian</option>
                    <option value="Snack" selected>Snack</option>
                </select></td>
                <% } %>
            </tr>
            <tr>
                <td>Description:</td>
                <td><textarea name="description" id="" cols="20" rows="2" ><%=description%></textarea></td>
            </tr>
            <tr>
                <td>Price:</td>
                <td><input type="number" name="foodprice" id="foodprice" value="<%=price%>"></td>
            </tr>
            <tr>
                <td>Quantity:</td>
                <td><input type="number" name="foodqty" id="foodqty" value="<%=qty%>"></td>
            </tr>
            <tr><td><button type="submit">Edit Food</button></td></tr>
        </table>
    </form>

    <br>



    <%@ include file="footer.jsp" %>
    
</body>
</html>