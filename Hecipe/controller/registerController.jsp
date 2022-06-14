<%@include file="../connect.jsp"%>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confpassword = request.getParameter("confpassword");
    int checkemail = 0;
    int check = 0;

    for(int i = 0; i < email.length(); i++){
        if(email.charAt(i)=='@')               
        checkemail = checkemail + 1;  
    }

    for(int i = 0; i < email.length()-1; i++){
        if(email.charAt(i)=='@' && email.charAt(i+1)=='.' || email.charAt(i)=='.' && email.charAt(i+1)=='@')
            check = check + 1;     
    }

    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM user WHERE email = '%s'", email);
    ResultSet rs = con.executeQuery(query);
    
    
    if(name.equals("") || name == null){
        session.setAttribute("errorRegister", "Name should not be empty");
        response.sendRedirect("../register.jsp");
    }
    else if(name.length() < 3 ){
        session.setAttribute("errorRegister", "Name must be at least 3 characters");
        response.sendRedirect("../register.jsp");
    }
    else if(email.equals("") || email == null){
        session.setAttribute("errorRegister", "Email should not be empty");
        response.sendRedirect("../register.jsp");
    }
    else if(!email.contains("@") || !email.contains(".")){
        session.setAttribute("errorRegister", "Email should contain at(@) and dot(.) symbol");
        response.sendRedirect("../register.jsp");
    }
    else if(checkemail > 1){
        session.setAttribute("errorRegister", "Email should contain only one at(@) symbol");
        response.sendRedirect("../register.jsp");
    }
    else if(check > 0){
        session.setAttribute("errorRegister", "Email should at (@) and dot(.) symbol must not be side by side");
        response.sendRedirect("../register.jsp");
    }
    else if(rs.next()){
        session.setAttribute("errorRegister", "Email must be unique");
        response.sendRedirect("../register.jsp");
    }
    else if(password =="" || password==null){
        session.setAttribute("errorRegister", "Password should not be empty");
        response.sendRedirect("../register.jsp");
    }
    else if(password.length() < 6){
        session.setAttribute("errorRegister", "Password must be at least 6 characters");
        response.sendRedirect("../register.jsp");
    }
    else if(!password.matches(".*[A-Za-z].*") || !password.matches(".*[0-9].*")){
        session.setAttribute("errorRegister", "Password must contains at least one alphabet and one number");
        response.sendRedirect("../register.jsp");
    }
    else if(!confpassword.equals(password)){
        session.setAttribute("errorRegister", "Confirm password must match with password");
        response.sendRedirect("../register.jsp");
    }
    else{
    query = String.format("INSERT INTO user (Name, Email, Password) VALUES ('%s', '%s', '%s')",name, email, password);

    con.executeUpdate(query);

    response.sendRedirect("../home.jsp");
    }

%>