<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Stuff Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
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
		String sql = "SELECT productId, productName, productPrice FROM product";
		boolean hasName = name != null && !name.equals(""); // checks for name input
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		// search was empty
		if(!hasName) {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

		} else { // search was not empty
			name = "%" + name + "%";
			sql += " WHERE productName LIKE ?";

			ps = con.prepareStatement(sql);
			ps.setString(1, name);
			rs = ps.executeQuery();
		}

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		out.println("<table border=\"1\"><tr><th></th><th>Product Name</th>" +
			"<th>Product Price</th></tr>");

		// loop to print out table of products
		while(rs.next()) {
			String pid = rs.getString(1);
			String pname = rs.getString(2);
			double price = rs.getDouble(3);

			// compose individual link for each item
			String link = "addcart.jsp?id=" + pid + 
							"&name=" + pname + 
							"&price=" + price;

			out.println("<tr><td><a href=\"" + link + "\">Add to Cart</a></td><td>" + 
						pname + "</td><td>" + currFormat.format(price) + "</td></tr>");

		}
		out.println("</table>");

	}
	// connection closes automatically in try-catch
%>

</body>
</html>