<header class="header">
	<nav>
		<ul>
            <li><a href="index.jsp">Home</a></li>
			<li><a href="listprod.jsp">All Products</a></li>
			<li><a href="showcart.jsp">Shopping Cart</a></li>
		</ul>
		<%
				if(session.getAttribute("authenticatedUser") != null) {
					String name = session.getAttribute("authenticatedUser").toString();
					out.println("<b align='right' style='margin:20px'><a href='customer.jsp'>Signed as: "+name+"</a></b>");
				}
			%>
	</nav>
</header>