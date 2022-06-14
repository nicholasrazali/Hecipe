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
    <% String id = request.getParameter("id"); %>

    <div class="container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Change Password</h1>
            </div>
        </div>
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 50%;">
                <div class="col-12 border border-secondary rounded">
                    <form action="controller/changepasswordController.jsp" method="post">
                        <input type="hidden" name = "id" value="<%= id %>" >
                        <div class="row m-3">
                            <div class="col-4">
                                <label for="oldpassword">Old Password: </label>
                            </div>
                            <div class="col-8">
                                <input type="password" name="oldpassword" placeholder="Old Password" class="form-control border-secondary">
                            </div>
                        </div>
                        <div class="row m-3">
                            <div class="col-4">
                                <label for="newpassword">New Password: </label>
                            </div>
                            <div class="col-8">
                                <input type="password" name="newpassword" placeholder="New Password" class="form-control border-secondary">
                            </div>
                        </div>
                        <div class="row m-3">
                            <div class="col-4">
                                <label for="confpassword">Confirm Password: </label>
                            </div>
                            <div class="col-8">
                                <input type="password" name="confpassword" placeholder="Confirm Password" class="form-control border-secondary">
                            </div>
                        </div>
                        <div class="form-group text-center m-3">
                            <button type="submit" class="btn btn-danger">Change Password</button>
                        </div>
                    </form>
                    <p> <%= session.getAttribute("errorpass") == null ? "" : session.getAttribute("errorpass") %></P>

                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="footer.jsp" %>

    
</body>
</html>