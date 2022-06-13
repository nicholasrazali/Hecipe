<%@include file="../connect.jsp"%>

<%
    String trId = request.getParameter("trid");

    Connect con = Connect.getConnection();

    String query = String.format("UPDATE trheader SET proses = ('%s') WHERE trID = ('%d')","true",Integer.parseInt(trId));
    con.executeUpdate(query);

    String send = String.format("../transactiondetail.jsp?trid=%d",Integer.parseInt(trId));
    response.sendRedirect(send);


%>

