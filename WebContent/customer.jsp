<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<%
// Print Customer information
String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	
	out.println("<h3>Customer Profile</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);	
	ResultSet rst = pstmt.executeQuery();
	
	if (rst.next())
	{
		out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Id</th><td>"+rst.getString(1)+"</td></tr>");	
		out.println("<tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><th>City</th><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr><th>State</th><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr><th>User id</th><td>"+rst.getString(11)+"</td></tr>");		
		out.println("</table>");
	}

	out.println("<h3>Your Orders</h3>");

	String s = "SELECT orderId, orderDate, totalAmount FROM ordersummary WHERE customerId = ?";
	PreparedStatement ps = con.prepareStatement(s);
	ps.setInt(1, rst.getInt(1));
	ResultSet rs = ps.executeQuery();

	out.println("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">" + 
		"<tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");

	while(rs.next()) {
		String prodId = rs.getString(1);
		String date = rs.getString(2);
		double price = rs.getDouble(3);

		out.println("<tr><td>" + prodId + "</td><td>" + date +
			"</td><td>" + currFormat.format(price) + "</td></tr>");
	}
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

