<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<h1 align="center">Administrator Page</h1>

<h2 align="center"><a href="adminSaleList.jsp">Sale List</a></h2>

<h2 align="center"><a href="adminCustList.jsp">All Customers</a></h2>

<h2 align="center"><a href="listorder.jsp">All Orders</a></h2>

<h2 align="center"><a href="adminAddProd.jsp">Add product</a></h2>

<h2 align="center"><a href="adminWarehouse.jsp">Warehouse</a></h2>

<h2 align="center"><a href="index.jsp">Back to home</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
/*
String userName = (String) session.getAttribute("authenticatedUser");
if (userName != null)
        out.println("<h3 algin =\"center\"> Signed in as: "+userName+"</h3>");
*/
%>

</body>
</html>

