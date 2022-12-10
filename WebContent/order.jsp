<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="styles.css">
	<title>Order Processing</title>
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Connection info
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
String custName = "";

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

	String s = "SELECT customerId, firstName, lastName FROM customer WHERE customerId = ?";
	PreparedStatement ps = con.prepareStatement(s);
	ps.setInt(1, id);
	ResultSet rs = ps.executeQuery();

	if(rs.next()) {
		hasId = true;
		custName = rs.getString(2) + " " + rs.getString(3);
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
	out.println("<H1>Your customer ID is invalid! Go back and try again.</H1>");
  } else {
	
	int num = Integer.parseInt(custId);
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {

			// Enter order information into database
			String sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";
			PreparedStatement ps;
			int orderId;

			// Retrieve auto-generated key for orderId
			ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, num);
			ps.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
			ps.executeUpdate();

			ResultSet keys = ps.getGeneratedKeys();
			keys.next();
			orderId = keys.getInt(1);

			out.println("<h1>Your Order Summary</h1>");
      	  	out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

        	double total = 0;
        	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
        	while (iterator.hasNext())
        	{ 
        		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
                out.print("<tr><td>" + productId + "</td>");
                out.print("<td>" + product.get(1) + "</td>");
				out.print("<td align=\"center\">" + product.get(3) + "</td>");
                String price = (String) product.get(2);
                double pr = Double.parseDouble(price);
                int qty = ( (Integer) product.get(3)).intValue();
				out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
               	out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td></tr>");
                out.println("</tr>");
                total = total + pr * qty;

				sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
				ps = con.prepareStatement(sql);
				ps.setInt(1, orderId);
				ps.setInt(2, Integer.parseInt(productId));
				ps.setInt(3, qty);
				ps.setString(4, price);
				ps.executeUpdate();				
        	}
        	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                       			+"<td aling=\"right\">" + currFormat.format(total) + "</td></tr>");
        	out.println("</table>");

			// Update order total
			sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
			ps = con.prepareStatement(sql);
			ps.setDouble(1, total);
			ps.setInt(2, orderId);			
			ps.executeUpdate();						

			out.println("<h1>Order completed.  Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is: " + orderId + "</h1>");
			out.println("<h1>Shipping to customer: " + custId + "</h1>" +
						"<h1>Name: " + custName + "</h1>");

			out.println("<h2><a href=\"index.jsp\">Return to shopping</a></h2>");
			out.println("<h2><a href=\"ship.jsp\">Track order</a></h2>");
			
			// Clear session variables (cart)
			session.setAttribute("orderId", Integer.valueOf(orderId));
			session.setAttribute("productList", null);

	} catch (SQLException ex) {
		out.println(ex);
	}

}
%>
</BODY>
</HTML>

