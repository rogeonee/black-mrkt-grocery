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

<style>
    input {
    font-family: "Poppins", sans-serif;
    font-size: 16px;
    color: black;
    display: block;
    }
</style>

<form method="get" action="insertProd.jsp">
    <div class="container">
      <h1>Add product</h1>
      <p>Please fill in new product info</p>
      <hr>
  
      <label><b>Name</b></label>
      <br>
      <input type="text" placeholder="Name" name="pname" id="pname" required>
      <br>
  
      <label><b>Price</b></label>
      <br>
      <input type="text" placeholder="Price" name="price" id="price" required>
      <br>
  
      <label><b>Category</b></label>
      <br>
      <input type="text" placeholder="Category" name="category" id="category" required>
      <br>

      <label><b>Description</b></label>
      <br>
      <input type="text" placeholder="Description" name="desc" id="desc" required>
      <hr>
  
      <input type="submit" value="Add">
      <input type="reset" value="Reset">
    </div>
  
  </form>

  <h2 align="left"><a href="admin.jsp">Back</a></h2>

</body>
</html>