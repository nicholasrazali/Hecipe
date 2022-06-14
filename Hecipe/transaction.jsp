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

    <%-- Header --%>
    <%  if(session.getAttribute("role") == null){ %>
    <%@     include file="header.jsp" %>
    <%  }else if(session.getAttribute("role") == "admin"){%>
    <%@     include file="adminheader.jsp" %>
    <%  }else {%>
    <%@     include file="memberheader.jsp" %>
    <%  } %>

    <div class="container-md p-5">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Transactions</h1>
            </div>
        </div>

        <table style="width: 100%; text-align: center; color: darkred;">
            <%if(rs.next()){%>

            <tr style="color:white; background-color: red;padding: 5px;">
                <td style="width: 33%;">Date</td>
                <td style="width: 33%">Processed</td>
                <td style="width: 33%">Action</td>
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
            <tr style="border-bottom: 1px solid black">
                <td><%= rs.getString("date") %></td>
                <td><%= rs.getString("proses") %></td>
                <td><a href="transactiondetail.jsp?trid=<%=rs.getInt("trID")%> ">See detail</a></td>
            </tr>
            <% } %>
        </table>
    </div>

    <%@ include file="footer.jsp" %>

    
</body>
</html>