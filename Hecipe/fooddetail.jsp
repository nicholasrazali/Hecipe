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
</head>
<body>
    <center><label><%=foodname%></label></center><br>
    <label>Categoty</label><br>
    <label><%=category%></label><br>
    <label>Description</label><br>
    <label><%=description%></label><br>
    <label>Price</label><br>
    <label><%=price%></label><br>
    <label>Quantity</label><br>
    <label><%=qty%></label><br>



    <br>
    <center><label>Comments</label></center><br>
    <%
        String query2 = "SELECT * FROM comment";
        ResultSet rs2 = con.executeQuery(query2);
        while(rs2.next()) { 
    %>
        <%= rs2.getString("name") %><br>
        <%= rs2.getString("comment") %><br>
        <% if(session.getAttribute("role").equals("admin")){ %>   
            <%session.setAttribute("idpage",id); %>       
            <a href="controller/deletecommentController.jsp?id2=<%= rs2.getInt("id") %>"><button>Delete</button></a>   <br>      
        <% } %>
    <% } %>
    <% if(session.getAttribute("role").equals("member")){ %>            
        <a href="editfood.jsp?id=<%= rs.getInt("id") %>"><input type="button" value="Edit"></a>
        <a href="controller/deletecommentController.jsp?id=<%= rs.getInt("id") %>"><input type="button" value="Delete"></a>         
    <% } %>

</body>
</html>