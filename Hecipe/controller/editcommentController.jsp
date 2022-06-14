<%@include file="../connect.jsp"%>

<%
    String editcomment = request.getParameter("editcomment");
    String id = request.getParameter("id");
    String id2 = request.getParameter("id2");
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    int checkcomment = 0;
    int check = 0;

    Connect con = Connect.getConnection();


    for(int i=0;i<editcomment.length()-1;i++){
        if(editcomment.charAt(i) == ' ' && editcomment.charAt(i+1) != ' '){
            checkcomment = checkcomment + 1;
        }
    }
    
    if(checkcomment < 4){
        session.setAttribute("erroreditcomment", "Comment should at least 5 words");
        String send = String.format("../editcomment.jsp?id=%d&id2=%d",Integer.parseInt(id,Integer.parseInt(id2)));
        response.sendRedirect(send);
    }
    else{
        
        String query = String.format("UPDATE comment SET comment = '%s' WHERE Id = %s",editcomment, id2);
        con.executeUpdate(query);
        String send = String.format("../fooddetail.jsp?id=%d",Integer.parseInt(id));
        response.sendRedirect(send);
        
    }
%>
