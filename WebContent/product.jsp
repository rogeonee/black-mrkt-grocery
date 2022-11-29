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
// Connection info
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
	
	// Get product name to search for
	String pname = request.getParameter("productName");
	
	if(pname != null) {
	pname = pname.trim(); // removing whitespace
	}

	// TODO: Retrieve and display info for the product
	String s1 = "SELECT * FROM product WHERE productName = pname";
	PreparedStatement p1 = con.prepareStatement(s1);	
	ResultSet productInfo = p1.executeQuery();
	
	// TODO: If there is a productImageURL, display using IMG tag
	String url1 = request.getParameter("productImageURL");
	if (url1 != null) {
	>%
		// display using IMG tag
		<img src="data:image/jpg;product,[url1]" />
	<%
	}
		
  } catch (SQLException e) {
	  out.println("SQLException: " + e);
  }
  
%>

// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
<img src="displayImage.jsp?id=1_a">
	
 // TODO: Add links to Add to Cart and Continue Shopping
 <h2> <a href="addcart.jsp">Add to Cart</a></h2>
 <h2> <a href="listprod.jsp">Continue Shopping</a></h2>

</body>
</html>

