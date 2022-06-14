<%@include file="../connect.jsp"%>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String remember[] = request.getParameterValues("remember");
    int checkemail = 0;
    int check = 0;

    if(remember != null){
        Cookie rememberme = new Cookie("email", email);
        rememberme.setMaxAge(24 * 60 * 60);
        response.addCookie(rememberme);
    }
    

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
    
    
    if(email.equals("") || email == null){
        session.setAttribute("errorLogin", "Email should not be empty");
        response.sendRedirect("../login.jsp");
    }
    else if(!email.contains("@") || !email.contains(".")){
        session.setAttribute("errorLogin", "Email should contain at(@) and dot(.) symbol");
        response.sendRedirect("../login.jsp");
    }
    else if(checkemail > 1){
        session.setAttribute("errorLogin", "Email should contain only one at(@) symbol");
        response.sendRedirect("../login.jsp");
    }
    else 
    if(check > 0){
        session.setAttribute("errorLogin", "Email should at (@) and dot(.) symbol must not be side by side");
        response.sendRedirect("../login.jsp");
    }
    else if(!rs.next()){
        session.setAttribute("errorLogin", "Wrong Email");
        response.sendRedirect("../login.jsp");
    }
    else if(password =="" || password==null){
        session.setAttribute("errorLogin", "Password should not be empty");
        response.sendRedirect("../login.jsp");
    }
    else if(password.length() < 6){
        session.setAttribute("errorLogin", "Password must be at least 6 characters");
        response.sendRedirect("../login.jsp");
    }
    else{
    query = String.format("SELECT * FROM user WHERE email = '%s' AND password = '%s'", email, password);
    rs = con.executeQuery(query);
        if(rs.next()){
            if(email.equals("admin@gmail.com")){
                session.setAttribute("role", "admin");
            }
            else{
                session.setAttribute("role", "member");
                session.setAttribute("user_name",rs.getString("Name"));
            }
            session.setAttribute("user",rs.getInt("Id"));
            session.setAttribute("login", (session.getAttribute("login") == null) ? 1 : ((Integer)(session.getAttribute("login"))+1));
            response.sendRedirect("../home.jsp");
        }
        else{
            session.setAttribute("errorLogin", "Wrong Password");
            response.sendRedirect("../login.jsp");
        }
    
    }



%>