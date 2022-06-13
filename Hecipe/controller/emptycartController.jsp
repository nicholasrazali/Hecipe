<%@include file="../connect.jsp"%>

<%
    String userid = request.getParameter("userID");

    Connect con = Connect.getConnection();

    String query = String.format("DELETE FROM cart WHERE userID = ('%d')",Integer.parseInt(userid));
        
    con.executeUpdate(query);

    response.sendRedirect("../cart.jsp");

%>