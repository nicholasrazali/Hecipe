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

    <div class="container-md">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Edit Food</h1>
            </div>
        </div>
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 40%;">
                <div class="col-12 border border-secondary rounded">
                    <form action="controller/editfoodController.jsp">
                        <input type="hidden" name = "id" value="<%= id %>" >
                        <div class="row m-3">
                            <div class="col-3">
                                <label for="name">Name: </label>
                            </div>
                            <div class="col-9">
                                <input type="text" name="foodname" id="" value="<%=foodname%>" class="form-control border-secondary">
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="category">Category: </label>
                            </div>
                            <div class="col-9">
                                <% if(category.equals("Meats")){%>
                                    <select id="category" name="category" value="Vegetarian">
                                        <option value="Meats" selected>Meats</option>
                                        <option value="Vegetarian">Vegetarian</option>
                                        <option value="Snack">Snack</option>
                                    </select>
                                    <% } else if(category.equals("Vegetarian")){%>
                                    <select id="category" name="category" value="Vegetarian">
                                        <option value="Meats">Meats</option>
                                        <option value="Vegetarian" selected>Vegetarian</option>
                                        <option value="Snack">Snack</option>
                                    </select>
                                    <% } else {%>
                                    <select id="category" name="category" value="Vegetarian">
                                        <option value="Meats">Meats</option>
                                        <option value="Vegetarian">Vegetarian</option>
                                        <option value="Snack" selected>Snack</option>
                                    </select>
                                    <% } %>
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="description">Description: </label>
                            </div>
                            <div class="col-9">
                                <textarea name="description" id="" cols="20" rows="2" ><%=description%></textarea>
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="foodprice">Price: </label>
                            </div>
                            <div class="col-9">
                                <input type="number" name="foodprice" id="foodprice" value="<%=price%>">
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="foodqty">Quantity: </label>
                            </div>
                            <div class="col-9">
                                <input type="number" name="foodqty" id="foodqty" value="<%=qty%>">
                            </div>
                        </div>

                        <div class="form-group text-center m-3">
                            <button type="submit" class="btn btn-success">Edit Food</button>
                        </div>
                    </form>
                    <p> <%= session.getAttribute("erroreditfood") == null ? "" : session.getAttribute("erroreditfood") %></P>

                </div>
            </div>
        </div>
    </div>



    <%@ include file="footer.jsp" %>
    
</body>
</html>