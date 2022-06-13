<%@include file="../connect.jsp"%>

<%
    String cartid = request.getParameter("cartID");
    String cartqty = request.getParameter("cartqty");
    int qtyfood = 0;
    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM food join cart on cart.foodID = food.id WHERE cartID = ('%d')", Integer.parseInt(cartid));
    ResultSet rs = con.executeQuery(query);
    if(rs.next()){
        qtyfood = rs.getInt("quantity");
    }
    
    if(qtyfood < Integer.parseInt(cartqty)){
        session.setAttribute("errorqty", "Stock makanan kurang");
    }
    else{
        if( Integer.parseInt(cartqty)>0){
            query = String.format("UPDATE cart SET quantity = ('%d') WHERE cartID = ('%d')", Integer.parseInt(cartqty), Integer.parseInt(cartid));
        }
        else{
            query = String.format("DELETE FROM cart WHERE cartID = ('%d')",Integer.parseInt(cartid));
        }
        con.executeUpdate(query);
    }
    
    response.sendRedirect("../cart.jsp");

%>