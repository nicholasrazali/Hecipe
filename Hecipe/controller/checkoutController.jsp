<%@include file="../connect.jsp"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>

<%
    String userid = request.getParameter("userID");
    int totaltr = 0;
    Connect con = Connect.getConnection();

    String counttr = String.format("SELECT COUNT(*) FROM trheader");
    ResultSet countrs = con.executeQuery(counttr);
    if(countrs.next()){
        totaltr = countrs.getInt(1);
    }
    totaltr = totaltr + 1;
    int banyak = 0;
    int cart[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    String query = String.format("SELECT COUNT(*) FROM cart WHERE status = ('%s') AND userID = ('%d')","true",Integer.parseInt(userid));
    ResultSet rs = con.executeQuery(query);
    if(rs.next()){
     banyak = rs.getInt(1);
    }

    query = String.format("SELECT * FROM cart WHERE status = ('%s') AND userID = ('%d')","true",Integer.parseInt(userid));
    rs = con.executeQuery(query);
    int tes = 0;
    

    while(rs.next()){
        cart[tes] = rs.getInt("cartID");
        query = String.format("INSERT INTO trdetail (trID, cartID) VALUES ('%d','%d')",totaltr,cart[tes]);
        tes = tes + 1;
    }
    for(int i = 0;i<banyak;i++){
        query = String.format("INSERT INTO trdetail (trID, cartID) VALUES (%d,%d)",totaltr,cart[i]);
        con.executeUpdate(query);
    }

    query = String.format("UPDATE cart SET status = ('%s') WHERE userID = ('%d')","false",Integer.parseInt(userid));
    con.executeUpdate(query);


    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String date = formatter.format(new java.util.Date());

    query = String.format("INSERT INTO trheader (trID, date, userID, proses) VALUES ('%d','%s','%d','%s')",totaltr,date,Integer.parseInt(userid),"false");
    con.executeUpdate(query);

    response.sendRedirect("../cart.jsp");

%>

