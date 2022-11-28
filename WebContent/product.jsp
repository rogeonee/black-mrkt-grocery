<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
String pname = request.getParameter("productName");
if(pname != null) {
	pname.trim();
}

// TODO: Retrieve and display info for the product
String s1 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
		PreparedStatement ps1 = con.prepareStatement(s1);
		
		ResultSet productInfo = ps1.executeQuery();
		
// String productId = request.getParameter("id");

String sql = "";

// TODO: If there is a productImageURL, display using IMG tag
<img src = "https://cosc304.ok.ubc.ca/rlawrenc/tomcat/lab8/img/1.jpg">

// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
<img src= "displayImage.jsp?id=1">
	
// TODO: Add links to Add to Cart and Continue Shopping
<a href="addcart.jsp?id=1&amp;name=Chai&amp;price=18.0">Add to Cart</a>
<a href="listprod.jsp">Continue Shopping</a> 

%>

</body>
</html>

