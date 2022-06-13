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

    <%
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    
    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM user WHERE id = %d",userId);
    ResultSet rs = con.executeQuery(query);
    if(rs.next()){
        out.println(rs.getString("Name"));
        out.println(rs.getString("Email"));
        out.println(session.getAttribute("role"));
    }
    %>
    <a href="changepassword.jsp?id=<%=userId%>">
        <input type="button" value="Change Password">
    </a>
    
</body>
</html>