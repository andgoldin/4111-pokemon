<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">

<!-- This import is necessary for JDBC -->
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<!-- Database lookup -->
<%
	Connection conn = null;
	ResultSet rset = null;
	String error_msg = "";
	try {
		OracleDataSource ods = new OracleDataSource();

		ods.setURL("jdbc:oracle:thin:yg2346/vulpix123@//w4111b.cs.columbia.edu:1521/ADB");
		conn = ods.getConnection();
		Statement stmt = conn.createStatement();
		rset = stmt.executeQuery("SELECT * FROM pokemon ORDER BY pokemonid");
	} catch (SQLException e) {
		error_msg = e.getMessage();
		if (conn != null) {
			conn.close();
		}
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Pokemon</title>
</head>
<body>
	<a href="index.jsp">Back to Homepage</a><br>
	<H2>ALL POKEMON</H2>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Pokedex #</b></td>
			<td><b>Image</b></td>
			<td><b>Name</b></td>
			<td><b>Height</b></td>
			<td><b>Weight</b></td>
		<tr>
		<%
			if (rset != null) {
				while (rset.next()) {
					out.print("<tr>");
					out.print("<td>" + rset.getInt("pokemonid") + "</td>"
							+ "<td><img src=" + rset.getString("spriteurl") + " /></td>"
							+ "<td><a href=pokemon.jsp?id=" + rset.getInt("pokemonid") + ">" + rset.getString("name") + "</a></td>" + "<td>"
							+ rset.getDouble("height") + " m</td>" + "<td>"
							+ rset.getDouble("weight") + " kg</td>");
					out.print("</tr>");
				}
			} else {
				out.print(error_msg);
			}
			if (conn != null) {
				conn.close();
			}
		%>
	</table>
</body>
</html>