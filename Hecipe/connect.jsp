<%@page import="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/hecipe", "root", "");
    // DriverManager.getConnection("jdbc:mysql://localhost/test", "root", "");
    // localhost -> hostnya
    // test -> nama dbnya
    // root -> username
    // "" -> password

    Statement st = con.createStatement(1004, 1008);
%>