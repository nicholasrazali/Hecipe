<%@include file="connect.jsp"%>
<%        
    Connect con = Connect.getConnection();
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    int trId = Integer.parseInt(request.getParameter("trid"));
    String proses = "";
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
                <h1 style = "text-decoration: underline;">Detail Transactions</h1>
            </div>
        </div>
        <%
        
            String query = String.format("SELECT * FROM cart join food on cart.foodID = food.id join trdetail on cart.cartID = trdetail.cartID WHERE trdetail.trID = %d ",trId );
            ResultSet rs = con.executeQuery(query);
            rs = con.executeQuery(query);
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
                        <td style="width: 20%">Subtotal</td>
                    </tr>
                <% } %>
                
                <%
                query = String.format("SELECT * FROM cart join food on cart.foodID = food.id join trdetail on cart.cartID = trdetail.cartID WHERE trdetail.trID = %d ",trId );
                rs = con.executeQuery(query);
                int total = 0;
                %>
                <p> <%= session.getAttribute("errorqty") == null ? "" : session.getAttribute("errorqty") %></P>
                <% while(rs.next()) { %>
                    <tr style="border-bottom: 1px solid black">
                        <td><a><img src="<%= rs.getString("image") %>" > </a></td>
                        <td><a href="fooddetail.jsp?id=<%= rs.getInt("id") %>"><%=rs.getString("name")%><a></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td><%= rs.getInt("price") %></td>
                        <td><%= rs.getInt("price") * rs.getInt("quantity")%></td>
                        <% total = total + rs.getInt("price") * rs.getInt("quantity"); %>    
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
                <div class="col-12">
                    <% query = String.format("SELECT * FROM trheader WHERE trID = '%d'",trId);
                    rs = con.executeQuery(query);
                    if(rs.next()) proses = rs.getString("proses");
                    %>
                    <% if(session.getAttribute("role") == "admin" & proses.equals("false")) {%>
                    <form action="controller/prosesController.jsp">
                        <input type="hidden" name = "trid" value="<%= trId %>" >
                        <button type="submit" class="btn btn-success">Process</button>
                    </form>
                    <% } %>
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

