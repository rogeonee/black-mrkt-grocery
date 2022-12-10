<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Product Information</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="header.jsp" %>

<h3>This Product Has A Rating Of: </h3>

<button type="button" name="back" onclick="history.back()">Back To Product</button>

<h2 align="center"><a href="listprod.jsp">Back To Shopping</a></h2>

</body>
</html>

