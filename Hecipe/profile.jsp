<%@include file="connect.jsp"%>
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


    <%
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    
    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM user WHERE id = %d",userId);
    ResultSet rs = con.executeQuery(query);

    %>

    <div class="container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Profile</h1>
            </div>
        </div>
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 40%;">
                <div class="col-12 border border-secondary rounded">
                    <% if(rs.next()){%>
                    <div class="row m-3">
                        <div class="col-3">
                            <label for="name"><b>Name: </b></label>
                        </div>
                        <div class="col-9">
                            <span><%= rs.getString("Name")%></span>
                        </div>
                    </div>
                    <div class="row m-3">
                        <div class="col-3">
                            <label for="email"><b>Email: </b></label>
                        </div>
                        <div class="col-9">
                            <span><%= rs.getString("Email")%></span>
                        </div>
                    </div>
                    <div class="row m-3">
                        <div class="col-3">
                            <label for="role"><b>Role: </b></label>
                        </div>
                        <div class="col-9">
                            <span><%= session.getAttribute("role")%></span>
                        </div>
                    </div>
                    <form action="changepassword.jsp?id=<%=userId%>" method="post">
                        <div class="form-group text-center m-3">
                            <button type="submit" class="btn btn-danger">Change Password</button>
                        </div>
                    </form>
                    <% }%>

                </div>
            </div>
        </div>
    </div>


    
    <%@ include file="footer.jsp" %>

</body>
</html>