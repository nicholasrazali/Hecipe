<%@include file="connect.jsp"%>
<% 
    Connect con = Connect.getConnection();
    int userId = (session.getAttribute("user")==null) ? 0 : ((Integer)session.getAttribute("user"));
    String query = "SELECT * FROM trheader";

    if(session.getAttribute("role") == "member"){
        query = String.format("SELECT * FROM trheader WHERE userID = '%d'", userId);
    }

    ResultSet rs = con.executeQuery(query);

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <table>
        <%if(rs.next()){%>
        <tr>
            <td>Date</td>
            <td>Processed</td>
            <td>Action</td>
        </tr>
        <%} else out.println("no transaction");%>

        <%
            query = "SELECT * FROM trheader";
            if(session.getAttribute("role") == "member"){
            query = String.format("SELECT * FROM trheader WHERE userID = '%d'", userId);
            }
             rs = con.executeQuery(query);
        %>
        
        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getString("date") %></td>
            <td><%= rs.getString("proses") %></td>
            <td><a href="transactiondetail.jsp?trid=<%=rs.getInt("trID")%> ">See detail</a></td>
        </tr>
        <% } %>
    </table>


    
</body>
</html>