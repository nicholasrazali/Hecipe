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

    <form action="registerController.jsp" method="post" >
        <table>
            <tr>
                <td>Name: </td>
                <td><input type="text" name="name" id=""></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="text" name="email" id=""></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" id=""></td>
            </tr>
            <tr>
                <td>Confirm Password:</td>
                <td><input type="password" name="confpassword" id=""></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Register"></td>
            </tr>
        </table>
        <p> <%= session.getAttribute("error") == null ? "" : session.getAttribute("error") %></P>
    </form>
    
    <%@ include file="footer.jsp" %>

    
</body>
</html>