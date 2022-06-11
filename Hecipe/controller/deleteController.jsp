<%@include file="../connect.jsp"%>
<%
    Connect con = Connect.getConnection();
    String id = request.getParameter("id");
    String query = String.format("DELETE FROM food WHERE id = ('%s')",id);
    con.executeUpdate(query);
    response.sendRedirect("../food.jsp");
%>