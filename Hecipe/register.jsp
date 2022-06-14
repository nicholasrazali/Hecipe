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
    <div class="container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Register</h1>
            </div>
        </div>
        <div class="container-md p-5 d-flex justify-content-center">
            <div class="row" style="width: 30%;">
                <div class="col-12 border border-secondary rounded">
                    <form action="controller/registerController.jsp" method="post">
                        <div class="m-3">
                            <label for="name">Name: </label>
                            <input type="text" name="name" placeholder="Name" class="form-control border-danger">
                        </div>
                        <div class="m-3">
                            <label for="email">Email: </label>
                            <input type="text" name="email" placeholder="E-mail" class="form-control border-danger">
                        </div>
                        <div class="m-3">
                            <label for="password">Password: </label>
                            <input type="password" name="password" placeholder="Password" class="form-control border-danger">
                        </div>
                        <div class="m-3">
                            <label for="confpassword">Email: </label>
                            <input type="password" name="confpassword" placeholder="Confirm Password" class="form-control border-danger">
                        </div>
                        
                        <div class="form-group text-center m-3">
                            <button type="submit" class="btn btn-danger" value="Register">Register</button>
                        </div>
                    </form>
                    <p> <%= session.getAttribute("errorRegister") == null ? "" : session.getAttribute("errorRegister") %></P>
                </div>
            </div>

        </div>

    </div>
    
    <%@ include file="footer.jsp" %>

    
</body>
</html>