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
    <% String id = request.getParameter("id"); %>

    <form action="controller/changepasswordController.jsp" method="post" >
        <input type="hidden" name = "id" value="<%= id %>" >
        <table>
            <tr>
                <td>Old Password:</td>
                <td><input type="password" name="oldpassword" id=""></td>
            </tr>
            <tr>
                <td>New Password:</td>
                <td><input type="password" name="newpassword" id=""></td>
            </tr>
            <tr>
                <td>Confirm Password:</td>
                <td><input type="password" name="confpassword" id=""></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Change Password"></td>
            </tr>
        </table>
        <p> <%= session.getAttribute("errorpass") == null ? "" : session.getAttribute("errorpass") %></P>
    </form>
    
    <%@ include file="footer.jsp" %>

    
</body>
</html>