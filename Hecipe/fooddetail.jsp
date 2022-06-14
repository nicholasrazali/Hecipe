<%@include file="connect.jsp"%>
<%        
    String id = request.getParameter("id");
    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM food WHERE id = ('%s')",id);
    ResultSet rs = con.executeQuery(query);
    String foodname = "";
    String description = "";
    String category = "";
    String image = "";
    int price = 0;
    int qty = 0;
    if(rs.next()){
        foodname = rs.getString("name");
        description = rs.getString("description");
        category = rs.getString("category");
        price = rs.getInt("price");
        qty = rs.getInt("quantity");
        image = rs.getString("image");
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
    <%-- Header --%>
    <%  if(session.getAttribute("role") == null){ %>
    <%@     include file="header.jsp" %>
    <%  }else if(session.getAttribute("role") == "admin"){%>
    <%@     include file="adminheader.jsp" %>
    <%  }else {%>
    <%@     include file="memberheader.jsp" %>
    <%  } %>
    <div class="container-md">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;"><%=foodname%></h1>
            </div>
        </div>
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 100%;">
                <div class="col-12 border border-secondary rounded">
                    <div class="row">
                        <div class="col-5">
                            <img src="<%= image %>" >
                        </div>
                        <div class="col-4 m-3">
                            <div>
                                <label for=""><h5>Category</h5></label>
                                <br>
                                <span><%=category%></span>
                            </div>
                            <div>
                                <label for=""><h5>Description</h5></label>
                                <br>
                                <span><%=description%></span>
                            </div>
                            <div>
                                <label for=""><h5>Price</h5></label>
                                <br>
                                <span><%=price%></span>
                            </div>
                            <div>
                                <label for=""><h5>Quantity</h5></label>
                                <br>
                                <span><%=qty%></span>
                            </div>

                        </div>
                    
                        <div class="col-2 align-self-end m-3">
                        <% if(session.getAttribute("role")=="member"){ %>   
                            <form action="controller/addcartController.jsp" >
                            <input type="hidden" name = "id" value="<%= id %>" >
                            <input type="hidden" name = "asaladd" value="detail" >
                            <button type="submit" class="btn btn-danger">Add to cart</button>
                            </form>
                        <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-md">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Comments</h1>
            </div>
        </div>
        
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 100%;">
                <div class="col-12 border border-secondary rounded">
                    <div class="row">
                        <%
                        String query2 = String.format("SELECT * FROM comment Join user on comment.userID = user.Id WHERE foodID = %d",Integer.parseInt(id));
                        ResultSet rs2 = con.executeQuery(query2);
                    
                
                        while(rs2.next()) { 
                        %>
                        <div class="col-9">
                            <label for=""><h5><%= rs2.getString("Name") %></h5></label>
                            <br>
                            <span><%= rs2.getString("comment") %></span>
                        </div>

                        <div class="col-3 align-self-center">
                            <% if(session.getAttribute("role")=="admin"){ %>        
                                <a href="controller/deletecommentController.jsp?id2=<%= rs2.getInt("id")%>"><button class="btn btn-danger">Delete</button></a>   <br>      
                    
                        <% }else if(session.getAttribute("role")=="member"){
                            if(userId == rs2.getInt("userID")){    %>   
                            <a href="editcomment.jsp?id=<%= id %>&id2=<%= rs2.getInt("id") %>"><input type="button" class="btn btn-warning" value="Edit"></a>
                            <a href="controller/deletecommentController.jsp?id2=<%= rs2.getInt("id") %>"><input type="button" class="btn btn-danger" value="Delete"></a><br>
                        <% }} %>

                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
        </div>
        <div class="container-md p-5">
            <div class="row">
                <div class="col-12">
                    <%-- Insert comment --%>
                    <% if(session.getAttribute("role")=="member"){ %>
                        <form action="controller/addcommentController.jsp">
                            <input type="hidden" name = "id" value="<%= id %>" >
                            <textarea name="addcomment" id="" cols="30" rows="10" style="width: 100%;"></textarea>
                            <button style="text-align: right;" type="submit" class="btn btn-danger">Post Comment</button>
                        </form>
                        <p> <%= session.getAttribute("errorcomment") == null ? "" : session.getAttribute("errorcomment") %></P>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>

<style>
    img{
        padding: 20px;
        width: 400px;
        height: 300px;
    }
</style>