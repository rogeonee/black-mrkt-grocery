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
	<title>Shipment Processing</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="header.jsp" %>

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

		if(rs.next())
			validId = true;

	} catch (SQLException e) {
		out.println("<h1>Invalid Order ID. Please, contact Customer Support.</h1>");
	}
	//session.setAttribute("orderId", null);
%>	
	
<%
if(validId) {

	// TODO: Start a transaction (turn-off auto-commit)
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
		con.setAutoCommit(false);

	// TODO: Retrieve all items in order with given id
	String sql = "SELECT productId, quantity FROM orderproduct WHERE orderId = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setInt(1, id);
	ResultSet rs = ps.executeQuery();

	// TODO: Create a new shipment record.
	String shipSql = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES(?, 1);";
	PreparedStatement shipment = con.prepareStatement(shipSql);
	
	shipment.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
	shipment.executeUpdate();

	// TODO: For each item verify sufficient quantity available in warehouse 1.
	String inventorySql = "SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?";
	String updateInventory = "UPDATE productinventory SET quantity = ? WHERE productId = ?";

	PreparedStatement inv = con.prepareStatement(inventorySql);
	PreparedStatement update = con.prepareStatement(updateInventory);

	ResultSet inventory;
	boolean ok = true;	// for detecting problem product
	int problemId = -1;	// to save problem product id

	rs = ps.executeQuery();	// get product list again

	while(rs.next()) {
		int productId = rs.getInt("productId");
		int orderQT = rs.getInt("quantity");
		
		inv.setInt(1, productId);
		inventory = inv.executeQuery();
		
		if(!inventory.next()) {	// if no records for particular product (which starts from id = 11)
			ok = false;
			problemId = productId;
			break;
		}
		
		int invQT = inventory.getInt(1);

		if(invQT - orderQT < 0) {					// if not enough in stock - record product id and abort transaction
			problemId = productId;
			ok = false;
			break;
		} else {									// else - update inventory
			update.setInt(1, (invQT - orderQT));
			update.setInt(2, productId);
			update.executeUpdate();
			
			out.println("<h1>Ordered Product: " + productId + "<br>  Quantity: " + orderQT + "  " +
						"<br>Previous inventory: " + invQT + "<br>  New inventory: " + (invQT - orderQT) + "</h1>");
		}
	}

	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	// check if everything alright and commit/rollback
	if(!ok) {
		out.println("<h1>Shipment not done. Insufficient inventory for product ID: " + problemId + "</h1>");
		con.rollback();
	} else {
		out.println("<h1>Shipment successfully processed.</h1>");
		con.commit();
	}
	
	// TODO: Auto-commit should be turned back on
	con.setAutoCommit(true);
	} catch (SQLException e) {
		out.println(e);
	}
} else {
	out.println("<h1>Invalid Order ID. Please, contact Customer Support.</h1>");
}
%>

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
