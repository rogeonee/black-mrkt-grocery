<%@ page import="java.sql.*,java.net.URLEncoder" %>
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

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
	<select id="dropDown" name="dropDown" size="1" name="category">
		<option>All</option>
		<option>Beverages</option>
		<option>Condiments</option>
		<option>Confections</option>
		<option>Dairy Products</option>
		<option>Grains/Cereals</option>
		<option>Meat/Poultry</option>
		<option>Produce</option>
		<option>Seafood</option>
	</select>
	<input type="text" name="productName" size="50">
	<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

<h3>All Products</h3>

<%
String category = request.getParameter("dropDown");

// Get product name to search for
String name = request.getParameter("productName");
if(name != null)
	name = name.trim(); // to handle empty input like spaces
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " + e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";
			
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {

		Statement s = con.createStatement();
		String sql = "SELECT productId, productName, categoryName, productPrice " +
						"FROM product JOIN category " +
						"ON product.categoryId = category.categoryId ";
		boolean hasName = name != null && !name.equals(""); // checks for name input
		boolean hasCategory = category != null && !category.equals("All");
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		int option = 0;

		// search was empty
		if(!hasName && !hasCategory) {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

		} else if(hasCategory && !hasName) {
			sql += " WHERE categoryName = ?";
			option = 1;

		} else if(hasName && !hasCategory) {
			name = "%" + name + "%";
			sql += " WHERE productName LIKE ?";
			option = 2;

		} else {
			name = "%" + name + "%";
			sql += " WHERE categoryName = ? AND productName LIKE ?";
			option = 3;

		}

		ps = con.prepareStatement(sql);

		switch (option) {
			case 1: ps.setString(1, category); break;
			case 2: ps.setString(1, name); break;
			case 3: ps.setString(1, category);
					ps.setString(2, name);
					break;
			default: break;
		}

		rs = ps.executeQuery();

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		out.println("<table id=\"prodT\" border=\"1\"><tr><th></th><th>Product Name</th>" +
			"<th>Category</th><th>Product Price</th></tr>");

		// loop to print out table of products
		while(rs.next()) {
			int pid = rs.getInt(1);
			String pname = rs.getString(2);
			String cname = rs.getString(3);
			double price = rs.getDouble(4);

			// compose individual links for each item
			String linkCart = "addcart.jsp?id=" + pid + 
							"&name=" + pname + 
							"&price=" + price;

			String link = "product.jsp?id=" + pid;

			out.println("<tr><td><a href=\"" + linkCart + "\">Add to Cart</a></td><td>" + 
						"<a href=\"" + link + "\">"+pname+"</a></td><td>" + cname + "</td><td>" + 
						currFormat.format(price) + "</td></tr>");

		}
		out.println("</table>");

	}
	// connection closes automatically in try-catch
%>

</body>
</html>