<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Order Processing</title>
</head>
<body>

<%
// Connection info
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
// Determine if valid customer id was entered
if(custId != null)
    custId = custId.trim(); // trim empty spaces
// Determine if there are products in the shopping cart
if (productList != null);

boolean hasId = false;

// If either are not true, display an error message
// Look up customer ID in database
try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
	int id = Integer.parseInt(custId);

	String s = "SELECT customerId FROM customer WHERE customerId = ?";
	PreparedStatement ps = con.prepareStatement(s);
	ps.setInt(1, id);
	ResultSet rs = ps.executeQuery();

	if(rs.next()) {
		hasId = true;
	}

	// Valid ID
  } catch (NumberFormatException e) {
	//out.println("<H1>Your customer ID is invalid ! Go back and try again.</H1>");
	hasId = false;
  } catch (SQLException ex) {
	  out.println("SQLException: " + ex);
  }
%>

<%
  if (productList == null)
  {	out.println("<H1>Your shopping cart is empty!</H1>");
	//productList = new HashMap<String, ArrayList<Object>>();
  } else if(!hasId) {
	out.println("<H1>Your customer ID is invalid ! Go back and try again.</H1>");
  } else {

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	double total = 0.0;
	
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
		out.println("<H1>Order Summary</H1>");
		
		out.println("<table><tr><th>Product Id</th><th>Product Name</th>" +
					"<th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext()) { 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();

			String productId = (String) product.get(0);
			String pname = (String) product.get(1);
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer) product.get(3)).intValue();
			total += pr * qty;

			out.println("<tr><td>" + productId + "</td><td>" + 
				pname + "</td><td>" + qty + "</td><td>" + currFormat.format(pr) + "</td><td>" + 
				currFormat.format(pr * qty) + "</td></tr>");
		}
		out.println("<tr><td colspan=\"4\" align=\"right\"><b>Total</b></td><td align=\"right\">" + 
					currFormat.format(total) + "</td></tr>");
		out.println("</table>");

	}

}
// Save order information to database
	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/
// Insert each item into OrderProduct table using OrderId from previous INSERT
// Update total amount for order record
// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/
// Print out order summary
// Clear cart if order placed successfully
%>
</BODY>
</HTML>

