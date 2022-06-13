<%@include file="../connect.jsp"%>

<%
    String cartid = request.getParameter("cartID");

    Connect con = Connect.getConnection();

    String query = String.format("DELETE FROM cart WHERE cartID = ('%d')",Integer.parseInt(cartid));
        
    con.executeUpdate(query);

    response.sendRedirect("../cart.jsp");

%>