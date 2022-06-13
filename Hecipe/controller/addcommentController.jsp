<%@include file="../connect.jsp"%>

<%
    String addcomment = request.getParameter("addcomment");
    String id = request.getParameter("id");
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    int checkcomment = 0;
    int check = 0;

    Connect con = Connect.getConnection();


    for(int i=0;i<addcomment.length()-1;i++){
        if(addcomment.charAt(i) == ' ' && addcomment.charAt(i+1) != ' '){
            checkcomment = checkcomment + 1;
        }
    }
    
    if(checkcomment < 4){
        session.setAttribute("errorcomment", "Comment should at least 5 words");
        String send = String.format("../fooddetail.jsp?id=%d",Integer.parseInt(id));
        response.sendRedirect(send);
    }
    else{
        
        String query = String.format("INSERT INTO comment (foodID, userID, comment) VALUES ('%s', '%d', '%s')",id,userId, addcomment);
        con.executeUpdate(query);
        String send = String.format("../fooddetail.jsp?id=%d",Integer.parseInt(id));
        response.sendRedirect(send);
        
    }
%>
