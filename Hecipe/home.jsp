<%@include file="connect.jsp"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%        
    Connect con = Connect.getConnection();
    String query = String.format("SELECT COUNT(*) FROM user");
    ResultSet rs = con.executeQuery(query);
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

    <div class="container">
        <div class="row m-2 p-2" style="background-color: #D0C9C0;">
          <div class="col">
            <p>
                <h1>Welcome to Hecipe!</h1>
                <span>The Place to satisfy all your's belly need</span>
                <hr>
                <span>
                    Trying to fill your's belly? You come to the right place! With many foods to choose from, you can 
                    satisfy yourself in whatever the way you want. And so without holding yourself back, why not 
                    see what we have to over by clicking this button?
                </span>
                <form action="food.jsp">
                    <div class="m-3">
                        <button type="submit" class="btn btn-danger">See our's catalog</button>
                    </div>
                </form>
            </p>
          </div>
        </div>
        <div class="row m-2 p-2">
          <div class="col-4">
            <p>
                <h2 style = "text-decoration: underline;">Purchase Foods</h2>
                <span>
                    Hecipe is the place where you can go to if you want to find a wide variety of cuisine around the world. 
                    And so, now is the time if you want to fill your belly with the greatest cuisine from around the world.
                </span>
                <form action="food.jsp">
                    <div class="m-3">
                        <button type="submit" class="btn btn-danger">See what's we have to offer</button>
                    </div>
                </form>

            </p>
          </div>
          <div class="col-5">
            <p>
                <h2 style = "text-decoration: underline;">Search Foods</h2>
                <span>
                    Want to search a specific food in mind? Try using our search engine to find the cuisine that can 
                    fill your belly with our greatest cuisine from around the world.
                </span>
                <form action="food.jsp" method="get">
                     <div class="input-group m-2">
                        <input type="text" name="search" class="form-control" placeholder="Search food by" aria-describedby="btnGroupAddon">
                        <select id="searchby" name="searchby">
                            <option value="name">Name</option>
                            <option value="category">Category</option>
                            <option value="description">Description</option>
                        </select>
                        <button type="submit" class="btn btn-danger">Search</button>
                      </div>
                </form>
            </p>
          </div>
          <div class="col-3">
            <p>
                <h5 style = "text-decoration: underline;">Site Status</h5>
                <span>
                    Current date:
                    <%
                        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                        String date = formatter.format(new java.util.Date());
                        out.println(date);
                    %>
                </span>
                <br>
                <span>
                    Number of user:
                    <%
                        int totalData = 0;
                        if(rs.next()){
                            totalData = rs.getInt(1);
                        }
                        out.println(totalData);

                    %>
                </span>
                <br>
                <span>
                    Logged user:
                    <%  
                        out.println((session.getAttribute("login") == null) ? 0 : session.getAttribute("login"));
                    %>
                </span>

            </p>
          </div>
        </div>
      </div>

    <%@ include file="footer.jsp" %>
    
</body>
</html>