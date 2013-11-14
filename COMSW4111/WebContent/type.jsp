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
	ResultSet typeInfo = null;
	ResultSet attackInfo = null;
	ResultSet defendInfo = null;
	ResultSet pokemonInfo = null;
	ResultSet moveInfo = null;
	String error_msg = "";
	String tid = (request.getParameter("id") == null) ? "1" : request.getParameter("id"); // if no request is made, default to 1	
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
	typeInfo = stmt.executeQuery(
		"SELECT " +
	        "T.TypeId, " +
	        "T.Name AS TypeName " +
		"FROM Types T " +
		"WHERE T.TypeId = " + tid
	);
	if (typeInfo != null) {
		typeInfo.next();
	}
%>

<title><%= typeInfo.getString("typename") %> - Type Information</title>
</head>
<body>
	<a href="index.jsp">Back to Homepage</a><br>
	<h2>Type: <i><%= typeInfo.getString("typename") %></i></h2>
	<h3>Type Effectiveness: Attacking</h3>
	<table style="border-spacing: 20px 2px;">
		<tr>
			<td><b>Defending Type</b></td>
			<td><b>Effectiveness</b></td>
		</tr>
		<%
			attackInfo = stmt.executeQuery(
				"SELECT " +
			        "E.AttackerId AS AttackerTypeId, " +
			        "T.Name AS AttackerTypeName, " +
			        "E.ReceiverId AS ReceiverTypeId, " +
			        "T2.Name AS ReceiverTypeName, " +
			        "E.Effectiveness " +
				"FROM TYPES T " +
				"JOIN Effectiveness E " +
			        "ON T.TypeId = E.AttackerId " +
				"JOIN Types T2 " +
			        "ON T2.TypeId = E.ReceiverId " +
				"WHERE T.TypeId = " + tid
			);
			if (attackInfo != null) {
				while (attackInfo.next()) {
					out.print("<tr><td>");
					out.print("<a href=type.jsp?id=" + attackInfo.getString("receivertypeid") + ">" + attackInfo.getString("receivertypename") + "</a>");
					out.print("</td>");
					out.print("<td>");
					String comment = attackInfo.getString("effectiveness").equals("0.5") ? "(not very effective)" : "(super effective)";
					out.print(attackInfo.getString("effectiveness").equals("0") ? "No effect" : attackInfo.getString("effectiveness") + "x " + comment);
					out.print("</td></tr>");
				}
			}
		
		%>
	</table>
	<br>1x effectiveness on all other defending types.<br>
	<br>
	<h3>Type Effectiveness: Defending</h3>
	<table style="border-spacing: 20px 2px;">
		<tr>
			<td><b>Attacking Type</b></td>
			<td><b>Effectiveness</b></td>
		</tr>
		<%
			defendInfo = stmt.executeQuery(
				"SELECT " +
			        "E.AttackerId AS AttackerTypeId, " +
			        "T2.Name AS AttackerTypeName, " +
			        "E.ReceiverId AS ReceiverTypeId, " +
			        "T.Name AS ReceiverTypeName, " +
			        "E.Effectiveness " +
				"FROM TYPES T " +
				"JOIN Effectiveness E " +
			        "ON T.TypeId = E.ReceiverId " +
				"JOIN Types T2 " +
			        "ON T2.TypeId = E.AttackerId " +
				"WHERE T.TypeId = " + tid
			);
			if (defendInfo != null) {
				while (defendInfo.next()) {
					out.print("<tr><td>");
					out.print("<a href=type.jsp?id=" + defendInfo.getString("attackertypeid") + ">" + defendInfo.getString("attackertypename") + "</a>");
					out.print("</td>");
					out.print("<td>");
					String comment = defendInfo.getString("effectiveness").equals("0.5") ? "(not very effective)" : "(super effective)";
					out.print(defendInfo.getString("effectiveness").equals("0") ? "No effect" : defendInfo.getString("effectiveness") + "x " + comment);
					out.print("</td></tr>");
				}
			}
		
		%>
	</table>
	<br>1x effectiveness from all other attacking types.<br>
	<br>
	<h3>Pokemon With This Type</h3>
	<%
		pokemonInfo = stmt.executeQuery(
			"SELECT " +
		        "P.PokemonId, " +
		        "P.Name AS PokemonName, " +
		        "P.SpriteURL, " +
		        "P.Height, " +
		        "P.Weight " +
			"FROM Pokemon P " +
			"JOIN PokemonTypes PT " +
		        "ON P.PokemonId = PT.PokemonId " +
			"JOIN Types T " +
		        "ON PT.TypeId = T.TypeId " +
			"WHERE T.TypeId = " + tid
		);
		if (pokemonInfo != null) {
			while (pokemonInfo.next()) {
				out.print("<img src=" + pokemonInfo.getString("spriteurl") + " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				out.print("#" + pokemonInfo.getString("pokemonid") + ": "
						+ "<a href=pokemon.jsp?id=" + pokemonInfo.getString("pokemonid") + ">" + pokemonInfo.getString("pokemonname") + "</a><br>");
			}
		}
	%>
	<br>
	<h3>Moves Of This Type</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Move</b></td>
			<td><b>Category</b></td>
			<td><b>Power</b></td>
			<td><b>Accuracy</b></td>
			<td><b>Base PP</b></td>
			<td><b>Effect</b></td>
		</tr>
		<%
			// what moves can it learn? with details!
			moveInfo = stmt.executeQuery(
				"SELECT " +
			        "M.Name AS MoveName, " +
			        "M.MoveId AS MoveId, " +
			        "M.Category, " +
			        "M.MovePower, " +
			        "M.Accuracy, " +
			        "M.BasePP, " +
			        "M.Effect " +
				"FROM Moves M " +
				"JOIN Types T " +
		        	"ON M.TypeId = T.TypeId " +
				"WHERE T.TypeId = " + tid
			);
			if (moveInfo != null) {
				while (moveInfo.next()) {
					out.print("<tr>");
					out.print("<td><a href=move.jsp?id=" + moveInfo.getString("moveid") + "><i>" + moveInfo.getString("movename") + "</i></a></td>");
					out.print("<td>" + moveInfo.getString("category") + "</td>");
					out.print("<td>" + (moveInfo.getString("movepower") == null ? "-" : moveInfo.getString("movepower")) + "</td>");
					out.print("<td>" + (moveInfo.getString("accuracy") == null ? "-" : moveInfo.getString("accuracy")) + "</td>");
					out.print("<td>" + moveInfo.getString("basepp") + "</td>");
					out.print("<td>" + (moveInfo.getString("effect") == null ? "-" : moveInfo.getString("effect")) + "</td>");
					out.print("<tr>");
				}
			}
		%>
	</table>
	
	<%
		if (conn != null) conn.close();
	%>
</body>
</html>