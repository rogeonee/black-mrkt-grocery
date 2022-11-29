<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Date" %>

<h2>In progress</h2>

<%
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT DISTINCT orderDate FROM ordersummary";

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

    /*
    try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {

        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet dates = ps.executeQuery();

        String s = "SELECT orderDate, SUM(totalAmount) FROM ordersummary WHERE orderDate = ? GROUP BY orderDate";
        PreparedStatement ps2 = con.prepareStatement(s);

        while(dates.next()) {
            
            Timestamp d = dates.getTimestamp(1);

            out.println("<h3>TS One: "+d+"</h3>");

            ps2.setTimestamp(1, d);
            ResultSet rs2 = ps2.executeQuery();

            while(rs2.next()) {
                Date date = rs2.getDate();
            }

            while(rs2.next()) {
                d = rs2.getTimestamp(1);
                out.println("<h3> TS Two: " + d + "  </h3><h3>" + rs2.getDouble(2) + "</h3>");
            }
            

        }

    } catch (SQLException e) {
        out.println(e);
    }
    */

%>

</body>
</html>

