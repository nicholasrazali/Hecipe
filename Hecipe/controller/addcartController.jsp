<%@include file="../connect.jsp"%>

<%
    
    String id = request.getParameter("id");
    String asaladd = request.getParameter("asaladd");
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    int qty = 0;
    int check = 0;
    String status = "true";

    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM cart WHERE foodID = %d AND userID = %d and status = '%s'",Integer.parseInt(id),userId, "true");
    ResultSet rs = con.executeQuery(query);

    if(rs.next()){
        qty = rs.getInt("quantity")+1;
        query = String.format("UPDATE cart SET quantity = %d WHERE cartID = %d",qty,rs.getInt("cartID"));
        con.executeUpdate(query);
    } else{
        qty = 1;
        query = String.format("INSERT INTO cart (foodID, userID, quantity, status) VALUES (%d, %d, %d,'%s')",Integer.parseInt(id),userId, qty,status);
        con.executeUpdate(query);
    }

    if(asaladd.equals("detail")){
        String send = String.format("../fooddetail.jsp?id=%d",Integer.parseInt(id));
        response.sendRedirect(send);
    }else response.sendRedirect("../food.jsp");
    
%>
