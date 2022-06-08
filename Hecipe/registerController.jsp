<%@include file="connect.jsp"%>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confpassword = request.getParameter("confpassword");

    String query = String.format("INSERT INTO user (Name, Email, Password) VALUES ('%s', '%s', '%s')",name, email, password);

    st.executeUpdate(query);

    response.sendRedirect("login.jsp");
%>