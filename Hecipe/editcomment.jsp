<%@include file="connect.jsp"%>
<%        
    String id2 = request.getParameter("id2");
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
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
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
    <% if(session.getAttribute("role").equals("member")){ %>            
        <a href="cart.jsp"><input type="button" value="Add cart"></a>
    <% } %>



    <br>
    <center><label>Comments</label></center><br>
    <%
        String query2 = String.format("SELECT * FROM comment Join user on comment.userID = user.Id WHERE foodID = %d",Integer.parseInt(id));
        ResultSet rs2 = con.executeQuery(query2);
    

        while(rs2.next()) { 
    %>
        <%= rs2.getString("Name") %><br>
        <% if (rs2.getInt("id") == Integer.parseInt(id2)){ %>
            <form action="controller/editcommentController.jsp">
                <input type="hidden" name = "id" value="<%= id %>" >
                <input type="hidden" name = "id2" value="<%= id2 %>" >
                <textarea name="editcomment" id="editcomment" cols="30" rows="10"><%= rs2.getString("comment") %></textarea>
                <button type="submit">Edit Comment</button>
            </form>
        <% } else {%>
        <%= rs2.getString("Name") %><br>
        <%= rs2.getString("comment") %><br>
        <% }}%>


        <p> <%= session.getAttribute("erroreditcomment") == null ? "" : session.getAttribute("erroreditcomment") %></P>

</body>
</html>