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

    <div class="container-md p-3">
        <div class="row">
            <div class="col-12 text-center">
                <h1 style = "text-decoration: underline;">Foods</h1>
            </div>
        </div>
        <%-- search --%>
        <form action="" method="get">
            <div class="row">
                <div class="col m-2">
                    <div class="input-group" style="width: 80%;">
                        <input type="text" name="search" class="form-control" placeholder="Search food by" aria-describedby="btnGroupAddon">
                        <select id="searchby" name="searchby">
                            <option value="name">Name</option>
                            <option value="category">Category</option>
                            <option value="description">Description</option>
                        </select>
                        <button type="submit" class="btn btn-danger">Search</button>
                      </div>
                </div>
                <div class="col m-2" style ="text-align:right">
                    <%-- admin add food --%>
                    <%  if(session.getAttribute("role") == "admin"){ %>
                        <a href="addfood.jsp"><input type="button" class="btn btn-success" value="Add new food"></a>
                    <% } %>
                </div>
            </div>
            
        </form>



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
        <table style="width: 100%; text-align: center;">
            <%-- <%  if(session.getAttribute("role") == null){ %> --%>
            <tr style="color:white; background-color: red;padding: 5px;">
                <td style="width: 40%; padding: 5px;">Image</td>
                <td style="width: 20%">Name</td>
                <td style="width: 10%">Category</td>
                <td style="width: 10%">Price</td>
                <%  if(session.getAttribute("role") != null){ %>
                    <td style="width: 20%">Action</td>
                <% } %>
            </tr>
            <% while(rs.next()) { %>
            <tr style="border-bottom: 1px solid black">
                    <td><a><img src="<%= rs.getString("image") %>" > </a></td>
                    <td><a href="fooddetail.jsp?id=<%= rs.getInt("id") %>"><%=rs.getString("name")%><a></td>
                    <td><%= rs.getString("category") %></td>
                    <td><%= rs.getInt("price") %></td>

                    <% if(session.getAttribute("role")=="admin"){ %>
                        <td>
                            <a href="editfood.jsp?id=<%= rs.getInt("id") %>"><input type="button" class="btn btn-warning" value="Edit"></a>
                            <a href="controller/deleteController.jsp?id=<%= rs.getInt("id") %>"><input type="button" class="btn btn-danger" value="Delete"></a>
                        </td>
                    <% } %>
                    <% if(session.getAttribute("role")=="member"){ %>
                    <td>
                    <form action="controller/addcartController.jsp" >
                        <input type="hidden" name = "id" value="<%= rs.getInt("id") %>" >
                        <input type="hidden" name = "asaladd" value="food" >
                        <button type="submit" class="btn btn-danger">Add cart</button>
                    </form>
                        </td>
                    <% } %>
                    

            </tr>
            <% } %>
        </table>
        <div>
            <nav style="display: flex;justify-content: center;margin: 30px 30px;">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="food.jsp?page=<%= 1 %>&searchby=<%=searchby%>&search=<%=value%>">First</a></li>
                    <li class="page-item"><a class="page-link" href="food.jsp?page=<%= currentPage-1 %>&searchby=<%=searchby%>&search=<%=value%>">Previous</a></li>
        <%
            for(int i = 1; i <= totalPages; i++){
        %>
            <li class="page-item"><a class="page-link" href="food.jsp?page=<%= i %>&searchby=<%=searchby%>&search=<%=value%>"> <%= i %> </a></li>
        <% } %>

                  <li class="page-item"><a class="page-link" href="food.jsp?page=<%= currentPage+1 %>&searchby=<%=searchby%>&search=<%=value%>">Next</a></li>
                  <li class="page-item"><a class="page-link" href="food.jsp?page=<%= totalPages %>&searchby=<%=searchby%>&search=<%=value%>">Last</a></li>
                </ul>
              </nav>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
    
</body>
</html>
<style>
img{
    padding: 20px;
    width: 400px;
    height: 300px;
}
tr td{
    border-bottom: 1px solid black;
}
</style>