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
    <% if(session.getAttribute("role")=="member"){ %>   
        <form action="controller/addcartController.jsp" >
        <input type="hidden" name = "id" value="<%= id %>" >
        <input type="hidden" name = "asaladd" value="detail" >
        <button type="submit">Add cart</button>
        </form>
    <% } %>



    <br>
    <center><label>Comments</label></center><br>
    <%
        String query2 = String.format("SELECT * FROM comment Join user on comment.userID = user.Id WHERE foodID = %d",Integer.parseInt(id));
        ResultSet rs2 = con.executeQuery(query2);
    

        while(rs2.next()) { 
    %>
        <%= rs2.getString("Name") %><br>
        <%= rs2.getString("comment") %><br>
    <% if(session.getAttribute("role")=="admin"){ %>        
            <a href="controller/deletecommentController.jsp?id2=<%= rs2.getInt("id")%>"><button>Delete</button></a>   <br>      

    <% }else if(session.getAttribute("role")=="member"){
        if(userId == rs2.getInt("userID")){    %>   
        <a href="editcomment.jsp?id=<%= id %>&id2=<%= rs2.getInt("id") %>"><input type="button" value="Edit"></a>
        <a href="controller/deletecommentController.jsp?id2=<%= rs2.getInt("id") %>"><input type="button" value="Delete"></a><br>
    <% }} %>
    <% } %>

    <%-- Insert comment --%>
    <% if(session.getAttribute("role")=="member"){ %>
        <form action="controller/addcommentController.jsp">
            <input type="hidden" name = "id" value="<%= id %>" >
            <textarea name="addcomment" id="" cols="30" rows="10"></textarea>
            <button type="submit">Post Comment</button>
        </form>
        <p> <%= session.getAttribute("errorcomment") == null ? "" : session.getAttribute("errorcomment") %></P>
    <% } %>

</body>
</html>