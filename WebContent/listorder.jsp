<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="styles.css">
	<title>Something Grocery</title>
</head>
<body>

<%@ include file="header.jsp" %>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " + e);
}

// Make connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";
			
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) 
	{
		// Get all order data
		Statement s = con.createStatement();	
		ResultSet rs = s.executeQuery("SELECT * FROM ordersummary");

		// Get customer name
		String sql = "SELECT firstName, lastName FROM customer WHERE customerId = ?";
		PreparedStatement ps = con.prepareStatement(sql);

		// Get product info
		String sql2 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
		PreparedStatement ps2 = con.prepareStatement(sql2);

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
		out.println("<table border=\"1\"><tr><th>Order ID</th><th>Customer ID</th>" +
					"<th>Customer Name</th><th>Total Amount</th></tr>");

		// Order data loop
		while (rs.next()) {
			String orderId = rs.getString("orderId");
			String custId = rs.getString("customerId");
			double total = rs.getDouble("totalAmount");
			String custName = "";

			ps.setString(1, custId);
			ResultSet cname = ps.executeQuery();

			ps2.setString(1, orderId);
			ResultSet prodInfo = ps2.executeQuery();

			// Customer name loop
			while(cname.next())
				custName += cname.getString(1) + " " + cname.getString(2);

			out.println("<tr><td>" + orderId + "</td><td>" + custId + 
						"</td><td>" + custName + "</td><td>" + currFormat.format(total) + "</td></tr>");

			out.println("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">" + 
						"<tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");
			
			// Product info loop
			while(prodInfo.next()) {
				String prodId = prodInfo.getString("productId");
				int quan = prodInfo.getInt("quantity");
				double price = prodInfo.getDouble("price");

				out.println("<tr><td>" + prodId + "</td><td>" + quan +
							"</td><td>" + currFormat.format(price) + "</td></tr>");
			}
			
			out.println("</table></td></tr>");
		}
		out.println("</table>");
	}
	catch (SQLException ex)
	{
		out.println("SQLException: " + ex);
	}

// Close connection
// => Closes automatically in try
%>

</body>
</html>

