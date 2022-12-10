<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

String pname = request.getParameter("pname");
double price = Double.parseDouble(request.getParameter("price"));
int category = Integer.parseInt(request.getParameter("category"));
String desc = request.getParameter("desc");

/*
out.println("<h3>"+pname+"</h3>");
out.println("<h3>"+price+"</h3>");
out.println("<h3>"+category+"</h3>");
out.println("<h3>"+desc+"</h3>");
*/

try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {

    String sql = "INSERT INTO product (productName, productPrice, productDesc, categoryId) " +
                    "VALUES (?, ?, ?, ?)";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, pname);
    ps.setDouble(2, price);
    ps.setString(3, desc);
    ps.setInt(4, category);

    ps.executeUpdate();

    out.println("<h1>Product \""+pname+"\" added successfully!</h1>");
} catch (SQLException ex) {
    out.println("<h1>Something went wrong, product not added!</h1>");
}

%>

<h2 align="left"><a href="admin.jsp">Done</a></h2>

</body>
</html>