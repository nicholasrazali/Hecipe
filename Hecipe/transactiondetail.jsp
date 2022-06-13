<%@include file="connect.jsp"%>
<%        
    Connect con = Connect.getConnection();
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    int trId = Integer.parseInt(request.getParameter("trid"));
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

    <%
        
        String query = String.format("SELECT * FROM cart join food on cart.foodID = food.id WHERE userID = %d and status = '%s'",userId,"true" );
        ResultSet rs = con.executeQuery(query);
        
    %>

    <form action="controller/prosesController.jsp">
        <input type="hidden" name = "trid" value="<%= trId %>" >
        <button type="submit">Process</button>
    </form>




    <%@ include file="footer.jsp" %>
    
</body>
</html>

