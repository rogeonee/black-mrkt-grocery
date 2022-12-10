<!DOCTYPE html>
<html>
<head>
<title>Warehouse List</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
// Print out warehouse inv
String sql = "select warehouseId, warehouseName from warehouse";
String sql1 = "select * from productInventory where warehouseId = ?";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
try 
{		
	out.println("<h3>Inventory</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");
	ResultSet rst = con.createStatement().executeQuery(sql);

	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Warehouse ID</th><th>Warehouse Name</th>");	
	while (rst.next())
	{
		out.println("<tr><td>"+rst.getInt(1)+"-"+rst.getString(2)+"</td></tr>");
	}
	out.println("</table>");

	PreparedStatement ps0 = con.prepareStatement(sql);
	ResultSet r = ps0.executeQuery();

	PreparedStatement ps = con.prepareStatement(sql1);
    ResultSet rst1;

out.println("<h3>"+r.getInt(1)+"</h3>");

	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Product ID</th><th>Quantity</th><th>Price</th>");	
	while (r.next())
	{
		ps.setInt(1, r.getInt(1));
		rst1 = ps.executeQuery();
		out.println("<tr><td>"+rst1.getInt(1)+"-"+rst1.getInt(2)+"</td><td>"+currFormat.format(rst1.getDouble(3))+"</td></tr>");
	}
	out.println("</table>");

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