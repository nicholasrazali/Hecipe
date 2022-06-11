<%@include file="../connect.jsp"%>

<%
    String id = request.getParameter("id");
    String foodname = request.getParameter("foodname");
    String category = request.getParameter("category");
    String desciption = request.getParameter("description");
    String price = request.getParameter("foodprice");
    String qty = request.getParameter("foodqty");
    int checkdesc = 0;
    int check = 0;

    Connect con = Connect.getConnection();



    for(int i=0;i<desciption.length()-1;i++){
        if(desciption.charAt(i) == ' ' && desciption.charAt(i+1) != ' '){
            checkdesc = checkdesc + 1;
        }
    }
    
    
    if(foodname.equals("") || foodname == null){
        session.setAttribute("erroreditfood", "Name should not be empty");
        response.sendRedirect("../editfood.jsp");
    }
    else if(foodname.length() < 3 ){
        session.setAttribute("erroreditfood", "Name must be at least 3 characters");
        response.sendRedirect("../editfood.jsp");
    }
    else if(desciption.equals("") || desciption == null){
        session.setAttribute("erroreditfood", "Description should not be empty");
        response.sendRedirect("../editfood.jsp");
    }
    else if(checkdesc < 4){
        session.setAttribute("erroreditfood", "Description should at least 5 words");
        response.sendRedirect("../editfood.jsp");
    }
    else if(price.equals("") || price == null){
        session.setAttribute("erroreditfood", "Price should not be empty");
        response.sendRedirect("../editfood.jsp");
    }
    else if(Integer.parseInt(price) < 1){
        session.setAttribute("erroreditfood", "Price must more than 0");
        response.sendRedirect("../editfood.jsp");
    }
    else if(qty.equals("") || qty == null){
        session.setAttribute("erroreditfood", "Quantity should not be empty");
        response.sendRedirect("../editfood.jsp");
    }
    else if(Integer.parseInt(qty) < 1){
        session.setAttribute("erroreditfood", "Quantity must more than 0");
        response.sendRedirect("../editfood.jsp");
    }    
    else{
        
        String query = String.format("UPDATE food SET name = ('%s'), category = ('%s'), description = ('%s'), price = ('%d'), quantity = ('%d') WHERE id = ('%s')",foodname,category, desciption, Integer.parseInt(price), Integer.parseInt(qty),id);
        con.executeUpdate(query);

        response.sendRedirect("../food.jsp");
    }

%>
