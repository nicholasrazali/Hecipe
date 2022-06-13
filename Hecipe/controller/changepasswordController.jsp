<%@include file="../connect.jsp"%>

<%
    String id = request.getParameter("id");
    String oldpassword = request.getParameter("oldpassword");
    String newpassword = request.getParameter("newpassword");
    String confpassword = request.getParameter("confpassword");
    int checkemail = 0;
    int check = 0;

    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM user WHERE id = '%s'", id);
    ResultSet rs = con.executeQuery(query);
    String password = "";
    if(rs.next()){
        password = rs.getString("Password");
    }
    
    if(oldpassword =="" || oldpassword==null || newpassword =="" || newpassword==null){
        session.setAttribute("errorpass", "Password should not be empty");
        response.sendRedirect("../changepassword.jsp");
    }
    else if(!oldpassword.equals(password)){
        session.setAttribute("errorpass", "Old password must match with current password");
        response.sendRedirect("../changepassword.jsp");
    }
    else if(newpassword.length() < 6){
        session.setAttribute("errorpass", "New password must be at least 6 characters");
        response.sendRedirect("../changepassword.jsp");
    }
    else if(!newpassword.matches(".*[A-Za-z].*") || !newpassword.matches(".*[0-9].*")){
        session.setAttribute("errorpass", "New password must contains at least one alphabet and one number");
        response.sendRedirect("../changepassword.jsp");
    }
    else if(!confpassword.equals(newpassword)){
        session.setAttribute("errorpass", "Confirm password must match with new password");
        response.sendRedirect("../changepassword.jsp");
    }
    else{
    query = String.format("UPDATE user SET Password = '%s' WHERE id = ('%s')", newpassword, id);
    session.setAttribute("errorpass", "Success change password");
    con.executeUpdate(query);
    String send = String.format("../changepassword.jsp?id=%d",Integer.parseInt(id));
    response.sendRedirect(send);
    }

%>