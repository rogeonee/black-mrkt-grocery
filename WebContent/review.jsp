<!DOCTYPE html>
<html lang="en">

<%@ include file="header.jsp" %>

<h3>Rate This Product From 1-5: </h3>


<html>
<head>
<title>Product Information</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
    <head>
        <title>Star rating demo</title>
        <link rel="stylesheet" href="jquery.rating.css">
        <script src="jquery.js"></script>
        <script src="jquery.rating.js"></script>
    </head>
    <body>
        <form>
            <input type="radio" name="rating1" value="1" class="star">
            <input type="radio" name="rating2" value="2" class="star">
            <input type="radio" name="rating3" value="3" class="star">
            <input type="radio" name="rating4" value="4" class="star">
            <input type="radio" name="rating5" value="5" class="star">
        </form>

        <button type="button" name="Back To Product" onclick="history.back()">Back To Product</button>

        <h2 align="center"><a href="listprod.jsp">Back To Shopping</a></h2>
</body>
</html>