<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%@ include file="./Guest/header.jsp" %>
    
    <div class="content container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;   ">Login</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <form action="">
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
                            <td><input type="checkbox" placeholder="E-mail">
                            <label for="checkbox">Remember me </label></td>
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