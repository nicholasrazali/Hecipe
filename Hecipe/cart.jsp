<%@include file="connect.jsp"%>
<%        
    Connect con = Connect.getConnection();
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
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

    <div class="container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Cart</h1>
            </div>
        </div>
        <%
            
            String query = String.format("SELECT * FROM cart join food on cart.foodID = food.id WHERE userID = %d and status = '%s'",userId,"true" );
            ResultSet rs = con.executeQuery(query);
            
        %>

        <table style="width: 100%; text-align: center;">
            <%-- <%  if(session.getAttribute("role") == null){ %> --%>
                <%if(!rs.next()) {out.println("Cart is empty");%>
                <% } else{  %>
            <tr style="color:white; background-color: red;padding: 5px;">
                <td style="width: 30%; padding: 5px;">Image</td>
                <td style="width: 20%">Name</td>
                <td style="width: 10%">Quantity</td>
                <td style="width: 10%">Price</td>
                <td style="width: 10%">Subtotal</td>
                <td style="width: 20%">Action</td>
            </tr>
            <% } %>


            <%
            query = String.format("SELECT * FROM cart join food on cart.foodID = food.id WHERE userID = %d and status = '%s'",userId,"true" );
            rs = con.executeQuery(query);
            int total = 0;
            %>
            <p> <%= session.getAttribute("errorqty") == null ? "" : session.getAttribute("errorqty") %></P>


            <% while(rs.next()) { %>
            <tr style="border-bottom: 1px solid black">
                    <td><a><img src="<%= rs.getString("image") %>" > </a></td>
                    <td><a href="fooddetail.jsp?id=<%= rs.getInt("id") %>"><%=rs.getString("name")%><a></td>

                    <td>
                        <form action = "controller/quantityController.jsp">
                            <input type="hidden" name = "cartID" value="<%= rs.getInt("cartID") %>" >
                            <input style="width: 50%;" type="number" name="cartqty" id="cartqty" value="<%= rs.getInt("quantity") %>">
                            <button type="submit" class="btn btn-warning">Save</button>
                        </form>
                    </td>
                    <td><%= rs.getInt("price") %></td>
                    <td><%= rs.getInt("price") * rs.getInt("quantity")%></td>
                    <% total = total + rs.getInt("price") * rs.getInt("quantity"); %>
                    <td>
                        <form action="controller/deletecartController.jsp" >
                            <input type="hidden" name = "cartID" value="<%= rs.getInt("cartID") %>" >
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </td>

            </tr>
            <% } %>
        </table>

        <% if(total!=0){ %>

        <div class="row" style="text-align: right;">
            <div class="col-12">
                <span>Total: <%=total%></span>
            </div>
        </div>
        <div class="row" style="text-align: right;">
            <div class="col-10">
                <form action="controller/emptycartController.jsp" >
                    <input type="hidden" name = "userID" value="<%= userId %>" >
                    <button type="submit" class="btn btn-danger">Empty cart</button>
                </form>
            </div>
            <div class="col-2">
                <form action="controller/checkoutController.jsp" >
                    <input type="hidden" name = "userID" value="<%=userId %>" >
                    <button type="submit" class="btn btn-success">Check out</button>
                </form>
            </div>
        </div>

        <% } %>

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