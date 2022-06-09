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


    <%-- Error login --%>
   <p> <%= session.getAttribute("error") == null ? "" : session.getAttribute("error") %></P>


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

    
    <div class="content container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;   ">Login</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <form action="loginController.jsp">
                    <table  >
                        <tr>
                            <td><label for="email">Email: </label></td>
                            <td><input type="text" name="email" placeholder="E-mail"></td>
                        </tr>
                        <tr>
                            <td><label for="password">Password: </label></td>
                            <td><input type="password" name="password" placeholder="Password"></td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" name="remember" value="remember">Remember me</td>
                        </tr>
                    </table>
                    
                    <div class="form-group text-center">
                        <button type="submit">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="/Hecipe/footer.jsp" %>
</body>
</html>