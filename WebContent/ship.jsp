<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
	<title>OUR NAME Grocery Shipment Processing</title>
</head>
<body>

<%
	// TODO: Get order id
	int id = (Integer) session.getAttribute("orderId");
	out.println("<h1>Order ID: " + id + "</h1>");

	// TODO: Check if valid order id
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

	boolean validId = false;

	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {

		String sql = "SELECT orderId FROM ordersummary WHERE orderId = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		
		ResultSet rs = ps.executeQuery();

		if(rs.next()) {
			validId = true;
			out.println("<h1>valid</h1>");
		} else {
			out.println("<h1>not valid</h1>");
		}

	} catch (SQLException e) {
		out.println(e);
	}
	
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
