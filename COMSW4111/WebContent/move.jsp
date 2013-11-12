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
	Statement stmt = null;
	ResultSet moveInfo = null;
	ResultSet learnInfo = null;
	String error_msg = "";
	String mid = (request.getParameter("id") == null) ? "1" : request.getParameter("id"); // if no request is made, default to 1	
	try {
		OracleDataSource ods = new OracleDataSource();
		ods.setURL("jdbc:oracle:thin:yg2346/vulpix123@//w4111b.cs.columbia.edu:1521/ADB");
		conn = ods.getConnection();
	} catch (SQLException e) {
		error_msg = e.getMessage();
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
	stmt = conn.createStatement();

	// get pokemon info before title to include name in title
	moveInfo = stmt.executeQuery(
			"SELECT " +
		        "M.Name AS MoveName, " +
		        "M.MoveId AS MoveId, " +
				"T.TypeId AS TypeId, " +
		        "T.Name AS TypeName, " +
		        "M.Category, " +
		        "M.MovePower, " +
		        "M.Accuracy, " +
		        "M.BasePP, " +
		        "M.Effect " +
			"FROM Moves M " +
			"JOIN Types T " +
		        "ON M.TypeId = T.TypeId " +
			"WHERE M.MoveId = " + mid
		);
	if (moveInfo != null) {
		moveInfo.next();
	}
%>

<title><%= moveInfo.getString("movename") %> - Move Information</title>
</head>
<body>
	<h2>Move: <i><%= moveInfo.getString("movename") %></i></h2>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Type</b></td>
			<td><b>Category</b></td>
			<td><b>Power</b></td>
			<td><b>Accuracy</b></td>
			<td><b>Base PP</b></td>
			<td><b>Effect</b></td>
		<tr>
		<%
			if (moveInfo != null) {
				out.print("<tr>");
				out.print("<td><a href=type.jsp?id=" + moveInfo.getString("typeid") + ">" + moveInfo.getString("typename") + "</a></td>");
				out.print("<td>" + moveInfo.getString("category") + "</td>");
				out.print("<td>" + (moveInfo.getString("movepower") == null ? "-" : moveInfo.getString("movepower")) + "</td>");
				out.print("<td>" + (moveInfo.getString("accuracy") == null ? "-" : moveInfo.getString("accuracy")) + "</td>");
				out.print("<td>" + moveInfo.getString("basepp") + "</td>");
				out.print("<td>" + (moveInfo.getString("effect") == null ? "-" : moveInfo.getString("effect")) + "</td>");
				out.print("<tr>");
			}
		%>
	</table>
	<br>
	<h3>Pokemon Who Can Learn This Move Naturally</h3>
	<%
		learnInfo = stmt.executeQuery(
			"SELECT " +
		        "CL.PokemonId, " +
		        "P.Name as PokemonName, " +
		        "P.SpriteURL, " +
		        "M.Name AS MoveName " +       
			"FROM CanLearn CL " +
			"JOIN Moves M " +
		        "ON CL.MoveId = M.MoveId " +
			"JOIN Pokemon P " +
		        "ON P.PokemonId = CL.PokemonId " +
			"WHERE M.MoveId = " + mid +
			"ORDER BY CL.PokemonId"
		);
		if (learnInfo != null) {
			boolean hasData = false;
			while (learnInfo.next()) {
				hasData = true;
				out.print("<img src=" + learnInfo.getString("spriteurl") + " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				out.print("#" + learnInfo.getString("pokemonid") + ": "
						+ "<a href=pokemon.jsp?id=" + learnInfo.getString("pokemonid") + ">" + learnInfo.getString("pokemonname") + "</a><br>");
			}
			if (!hasData) {
				out.print("None");
			}
		}
	%>
	
	<%
		if (conn != null) conn.close();
	%>
</body>
</html>