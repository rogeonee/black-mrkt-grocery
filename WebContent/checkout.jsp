<!DOCTYPE html>
<html>
<head>
<title>Check Out</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="header.jsp" %>

<h1>Enter The Following Details To Complete The Transaction:</h1>

<h3>Credit Card Number (16 digits): </h3>
<input type="text" name="address" size="50">

<h3>Pin (4 digits): </h3>
<input type="text" name="pin" size="50">

<h3>CVV (3 digits): </h3>
<input type="text" name="cVv" size="50">

<h3>Street Address: </h3>
<input type="text" name="address" size="50">

<h3>City: </h3>
<input type="text" name="city" size="50">

<h3>Country </h3>
<input type="text" name="country" size="50">

<h3>Postal Code: </h3>
<input type="text" name="postal" size="50">

<h3>Customer ID:  </h3>
<form method="get" action="order.jsp">
<input type="text" name="customerId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</body>
</html>


