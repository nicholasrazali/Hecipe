<%@include file="../connect.jsp"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%
    String userid = request.getParameter("userID");

    Connect con = Connect.getConnection();

    String query = String.format("UPDATE cart SET status = ('%s') WHERE userID = ('%d')","false",Integer.parseInt(userid));
    con.executeUpdate(query);


    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String date = formatter.format(new java.util.Date());
    out.println(date);

    query = String.format("INSERT INTO trheader (date, userID, proses) VALUES ('%s','%d','%s')",date,Integer.parseInt(userid),"false");
    con.executeUpdate(query);

    response.sendRedirect("../cart.jsp");

%>

