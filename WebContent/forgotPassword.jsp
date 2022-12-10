<!DOCTYPE html>
<html>
<head>
	<title>Forgot Password</title>
    <%@ include file="header.jsp" %>
	<link rel="stylesheet" href="styles.css">
</head>
<body>


<div style="margin:0 auto;text-align:center;display:inline">

<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<form name="MyForm" method=post action="validateLogin.jsp">
    <table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
        <td><input type="text" name="username"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
        <td><input type="email" name="email" size=10 maxlength="50"></td>
    </tr>
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="Submit">
</form>

<%
String username = request.getParameter("username");
String mail = request.getParameter("email");
//Check if valid user and email
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;databaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

	boolean valid = false;

	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {

		String sql = "SELECT userid,email FROM customer";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, username);
        ps.setString(2, mail);

		ResultSet rst = ps.executeQuery();
        while(rst.next()) {
        if(rst.getString("userid").equals(username))
        if(rst.getString("email").equals(mail)) {
        valid = true;
    }
}
//
        if(valid == true ){
        out.println("<h1>Success! Check resgitered email for password and login.</h1>");
        }
        else {
            out.println("<h1>User entered does not exist. Register for a new account or Login.</h1>");
            out.println("<h2 align='center'><a href='login.jsp'>Login</a></h2>");
            out.println("<h2 align='center'><a href='register.jsp'>Register</a></h2>");
        }
	} catch (SQLException ex) {
        System.out.println(ex.getMessage());
    }
%>	
</body>
</html>