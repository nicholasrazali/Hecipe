<%@include file="../connect.jsp"%>

<%
    String foodname = request.getParameter("foodname");
    String category = request.getParameter("category");
    String desciption = request.getParameter("description");
    String price = request.getParameter("foodprice");
    String qty = request.getParameter("foodqty");
    int checkdesc = 0;
    int check = 0;
    String image = "images/pempek.jpg";
    Connect con = Connect.getConnection();



    for(int i=0;i<desciption.length()-1;i++){
        if(desciption.charAt(i) == ' ' && desciption.charAt(i+1) != ' '){
            checkdesc = checkdesc + 1;
        }
    }
    
    
    if(foodname.equals("") || foodname == null){
        session.setAttribute("errorfood", "Name should not be empty");
        response.sendRedirect("../addfood.jsp");
    }
    else if(foodname.length() < 3 ){
        session.setAttribute("errorfood", "Name must be at least 3 characters");
        response.sendRedirect("../addfood.jsp");
    }
    else if(desciption.equals("") || desciption == null){
        session.setAttribute("errorfood", "Description should not be empty");
        response.sendRedirect("../addfood.jsp");
    }
    else if(checkdesc < 4){
        session.setAttribute("errorfood", "Description should at least be 5 words");
        response.sendRedirect("../addfood.jsp");
    }
    else if(price.equals("") || price == null){
        session.setAttribute("errorfood", "Price should not be empty");
        response.sendRedirect("../addfood.jsp");
    }
    else if(Integer.parseInt(price) < 1){
        session.setAttribute("errorfood", "Price must more than 0");
        response.sendRedirect("../addfood.jsp");
    }
    else if(qty.equals("") || qty == null){
        session.setAttribute("errorfood", "Quantity should not be empty");
        response.sendRedirect("../addfood.jsp");
    }
    else if(Integer.parseInt(qty) < 1){
        session.setAttribute("errorfood", "Quantity must more than 0");
        response.sendRedirect("../addfood.jsp");
    }    
    else{
        
        String query = String.format("INSERT INTO food (name, image, category, description, price, quantity) VALUES ('%s', '%s', '%s', '%s', '%d', '%d')",foodname,image,category, desciption, Integer.parseInt(price), Integer.parseInt(qty));
        con.executeUpdate(query);

        response.sendRedirect("../food.jsp");
    }

%>
