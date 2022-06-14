<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
  
    <%@ include file="header.jsp" %>

    <%-- Error login --%>


    <%-- Remember me --%>
    <%
        Cookie[] cookies = request.getCookies();
        String email = null;

        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("email")){
                    email = cookie.getValue();
                }
            }
        }
        if(email != null){
            response.sendRedirect("home.jsp");
        }
    %>

    <div class="container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Login</h1>
            </div>
        </div>
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 30%;">
                <div class="col-12 border border-secondary rounded">
                    <form action="controller/loginController.jsp">
                        <div class="m-3">
                            <label for="email">Email: </label>
                            <input type="text" name="email" placeholder="E-mail" class="form-control border-danger">
                        </div>
                        <div class="m-3">
                            <label for="password">Password: </label>
                            <input type="password" name="password" placeholder="Password" class="form-control border-danger">
                        </div>
                        <div class="m-3">
                            <input type="checkbox" name="remember" value="remember">  Remember me
                        </div>
                        
                        <div class="form-group text-center m-3">
                            <button type="submit" class="btn btn-danger">Login</button>
                        </div>
                    </form>
                    <p> <%= session.getAttribute("errorLogin") == null ? "" : session.getAttribute("errorLogin") %></P>

                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
