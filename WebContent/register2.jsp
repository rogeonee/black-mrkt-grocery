<!DOCTYPE html>
<html>
<head>
	<title>Registration Successful</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	
<%@ include file="header.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">


	<%@ page language="java" import="java.io.*,java.sql.*"%>
	<%@ include file="jdbc.jsp" %>
	<%


	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	if(username.length() > 0 && password.length() > 0 && email.length() > 0) {
		// both fields have been inputted

		// adding inputs to customer database		
		try  {

			getConnection();

			Statement st = con.createStatement();
			st.executeUpdate ("INSERT INTO Customer (userId, password, email) VALUES (username1, password1,email1)");

		} catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

		%> 
		// 
		<h3>Registration Succesful!</h3>
		<br>
		<form name="form2" method=post action="login.jsp">
		<table style="display:inline">

		</table>
		<br/>
		<input class="submit" type="submit" name="Submit2" value="Go To Login Page">
		</form>
		
		<%
	} else {
		%> <h3>Registration Failed, Empty Inputs</h3> 
		
		<br>
		<form name="form3" method=post action="register.jsp">
		<table style="display:inline">

		</table>
		<br/>
		<input class="submit" type="submit" name="Submit2" value="Back To Registration">
		</form>
		
		<%
	}
%>



</div>

</body>
</html>