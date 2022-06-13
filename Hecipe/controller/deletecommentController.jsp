<%@include file="../connect.jsp"%>
<%
    Connect con = Connect.getConnection();
    String id2 = request.getParameter("id2");
    String query2 = String.format("SELECT * FROM comment WHERE id = '%s'",id2);
    ResultSet rs2 = con.executeQuery(query2);
    String id = "";
    if(rs2.next()){
        id = rs2.getString("foodID");
    }
    String query = String.format("DELETE FROM comment WHERE id = ('%s')",id2);
    con.executeUpdate(query);
    String send = String.format("../fooddetail.jsp?id=%d",Integer.parseInt(id));
    response.sendRedirect(send);
%>



