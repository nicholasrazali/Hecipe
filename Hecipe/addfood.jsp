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
                <h1 style = "text-decoration: underline;">Add Food</h1>
            </div>
        </div>
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 40%;">
                <div class="col-12 border border-secondary rounded">
                    <form action="controller/addfoodController.jsp">
                        <div class="row m-3">
                            <div class="col-3">
                                <label for="foodname">Name: </label>
                            </div>
                            <div class="col-9">
                                <input type="text" name="foodname" placeholder="Name" class="form-control border-secondary">
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="category">Category: </label>
                            </div>
                            <div class="col-9">
                                <select id="category" name="category">
                                    <option value="Meats">Meats</option>
                                    <option value="Vegetarian">Vegetarian</option>
                                    <option value="Snack">Snack</option>
                                </select>
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="description">Description: </label>
                            </div>
                            <div class="col-9">
                                <textarea name="description" id="" cols="20" rows="2"></textarea>
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="foodprice">Price: </label>
                            </div>
                            <div class="col-9">
                                <input type="number" name="foodprice" id="foodprice">
                            </div>
                        </div>

                        <div class="row m-3">
                            <div class="col-3">
                                <label for="foodqty">Quantity: </label>
                            </div>
                            <div class="col-9">
                                <input type="number" name="foodqty" id="foodqty">
                            </div>
                        </div>

                        <div class="form-group text-center m-3">
                            <button type="submit" class="btn btn-success">Add Food</button>
                        </div>
                    </form>
                    <p> <%= session.getAttribute("errorfood") == null ? "" : session.getAttribute("errorfood") %></P>

                </div>
            </div>
        </div>
    </div>


    <%@ include file="footer.jsp" %>
    
</body>
</html>