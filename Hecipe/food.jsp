<%@include file="connect.jsp"%>
<%        
    Connect con = Connect.getConnection();
    int dataPerPage = 2;
    int totalData = 0;

    String value = "";
    String searchby = "";
    if(request.getParameter("search")!=null){
            value = request.getParameter("search");
            searchby = request.getParameter("searchby");
    }

    String countDataQuery = "SELECT COUNT(*) FROM food";

    if(!value.isEmpty()){
        if(searchby.equals("name"))
            countDataQuery = String.format("SELECT COUNT(*) FROM food WHERE name LIKE '%%%s%%'",value);

            else if(searchby.equals("category"))
            countDataQuery = String.format("SELECT COUNT(*) FROM food WHERE category LIKE '%%%s%%'",value);

            else
            countDataQuery = String.format("SELECT COUNT(*) FROM food WHERE description LIKE '%%%s%%'",value);

    }

    ResultSet countDataRes = con.executeQuery(countDataQuery);

    if(countDataRes.next()){
        totalData = countDataRes.getInt(1);
    }

    int totalPages = (totalData % dataPerPage == 0) ? totalData/dataPerPage : totalData/dataPerPage+1;

    int currentPage = (request.getParameter("page") == null) ? 1 : Integer.parseInt(request.getParameter("page"));

    int startData = (dataPerPage * currentPage) - dataPerPage;

%>

<!DOCTYPE html>
<html lang="en">
<head>
    
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="./public/css/lib/bootstrap.min.css">
    <script src="./public/js/lib/jquery-3.6.0.min.js"></script>
    <script src="./public/js/lib/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/style.css">

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

    <%-- search --%>
    <form action="" method="get">
        <input type="text" name="search" id="">
        <select id="searchby" name="searchby">
                <option value="name">Name</option>
                <option value="category">Category</option>
                <option value="description">Description</option>
        </select>
         <button type="submit">Search</button>
    </form>

    <%-- admin add food --%>
    <%  if(session.getAttribute("role") == "admin"){ %>
        <a href="addfood.jsp"><input type="button" value="Add new food"></a>
    <% } %>

    <%

        String query = String.format("SELECT * FROM food LIMIT %d OFFSET %d", dataPerPage, startData);

        if(!value.isEmpty()){
            if(searchby.equals("name"))
            query = String.format("SELECT * FROM food WHERE name LIKE '%%%s%%' LIMIT %d OFFSET %d",value, dataPerPage, startData);

            else if(searchby.equals("category"))
            query = String.format("SELECT * FROM food WHERE category LIKE '%%%s%%' LIMIT %d OFFSET %d",value, dataPerPage, startData);

            else
            query = String.format("SELECT * FROM food WHERE description LIKE '%%%s%%' LIMIT %d OFFSET %d",value, dataPerPage, startData);
        }

        ResultSet rs = con.executeQuery(query);
    %>
    <br>
    <table>
        <%-- <%  if(session.getAttribute("role") == null){ %> --%>
        <tr>
            <td>Image</td>
            <td>Name</td>
            <td>Category</td>
            <td>Price</td>
            <%  if(session.getAttribute("role") != null){ %>
                <td>Action</td>
            <% } %>
        </tr>
        <% while(rs.next()) { %>
        <tr>
                <td><%= rs.getString("description") %></td>
                <td><a href="fooddetail.jsp?id=<%= rs.getInt("id") %>"><%=rs.getString("name")%><a></td>
                <td><%= rs.getString("category") %></td>
                <td><%= rs.getInt("price") %></td>

                <% if(session.getAttribute("role").equals("admin")){ %>
                    <td>
                        <a href="editfood.jsp?id=<%= rs.getInt("id") %>"><input type="button" value="Edit"></a>
                        <a href="controller/deleteController.jsp?id=<%= rs.getInt("id") %>"><input type="button" value="Delete"></a>
                    </td>
                <% } %>
                <% if(session.getAttribute("role").equals("member")){ %>
                    <td>
                        <a href="cart.jsp"><input type="button" value="Add to cart"></a>
                    </td>
                <% } %>
                

        </tr>
        <% } %>
    </table>

    <%
        for(int i = 1; i <= totalPages; i++){
    %>
        <a href="food.jsp?page=<%= i %>&searchby=<%=searchby%>&search=<%=value%>"> <%= i %> </a>
    <% } %>

    <%@ include file="footer.jsp" %>
    
</body>
</html>