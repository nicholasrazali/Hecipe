<%@include file="../connect.jsp"%>
<%
    Connect con = Connect.getConnection();
    String id2 = request.getParameter("id2");
    String query = String.format("DELETE FROM comment WHERE id = ('%s')",id2);
    con.executeUpdate(query);
    out.println(id2);
    int id = (session.getAttribute("idpage") == null) ? 0 : ((Integer)(session.getAttribute("idpage"))+1);
    String a = "../fooddetail.jsp?id=('%d')";
    out.println(id);
%>



