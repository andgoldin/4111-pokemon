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
	ResultSet pokemonInfo = null;
	ResultSet typeInfo = null;
	ResultSet evolveFromInfo = null;
	ResultSet evolveIntoInfo = null;
	ResultSet moveInfo = null;
	ResultSet locationInfo = null;
	String error_msg = "";
	String pid = (request.getParameter("id") == null) ? "1" : request.getParameter("id"); // if no request is made, default to 1	
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
	pokemonInfo = stmt.executeQuery(
		"SELECT " +
	        "P.PokemonId, " +
	        "P.Name AS PokemonName, " +
	        "P.SpriteURL, " +
	        "P.Height, " +
	       	"P.Weight " +
		"FROM Pokemon P " +
		"WHERE P.PokemonId = " + pid
	);
	if (pokemonInfo != null) {
		pokemonInfo.next();
	}
%>

<title><%= pokemonInfo.getString("pokemonname") %> - Pokemon Information</title>
</head>
<body>
	<a href="index.jsp">Back to Homepage</a><br>
	<h2>Pokemon: <i><%= pokemonInfo.getString("pokemonname") %></i></h2>
	<%
		if (pokemonInfo != null) {
			out.print("<img src=" + pokemonInfo.getString("spriteurl") + " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.print("National Pokedex #: " + pokemonInfo.getString("pokemonid"));
		}
	%>
	<br>
	<h3>Type(s)</h3>
	<%
		// what type(s) is it?
		typeInfo = stmt.executeQuery(
			"SELECT " +
				"PT.PokemonId, " +
				"T.TypeId AS TypeId, " +
			    "T.Name AS TypeName " +
			"FROM PokemonTypes PT " +
			"JOIN Types T " +
				"ON PT.TypeId = T.TypeId " +
			"WHERE PT.PokemonId = " + pid
		);
		if (typeInfo != null) {
			while (typeInfo.next()) {
				out.print("- <a href=type.jsp?id=" + typeInfo.getString("typeid") + ">" + typeInfo.getString("typename") + "</a><br>");
			}
		}
	%>
	<br>
	<h3>Evolution</h3>
	<table style="border-spacing: 20px 2px;">
		<tr>
			<td><b>Evolves from</b></td>
			<td><b>Evolves into</b></td>
		</tr>
		<tr>
		<%
			// what does it evolve from?
			evolveFromInfo = stmt.executeQuery(
				"SELECT " +
				    "E.BASEPOKEMONID, " +
				    "P.Name AS PokemonName, " +
				    "P.SpriteURL, " +
				    "E.EvolutionLevel " +
				"FROM Evolves E " +
				"JOIN Pokemon P " +
				        "ON E.BASEPOKEMONID = P.PokemonId " +
				"WHERE E.EVOLVEDPOKEMONID = " + pid
			);
		
			if (evolveFromInfo != null) {
				if (evolveFromInfo.next()) {
					out.print("<td>");
					out.print("<img src=" + evolveFromInfo.getString("spriteurl") + " /><br>"
							+ "#" + evolveFromInfo.getString("basepokemonid") + ": "
							+ "<a href=pokemon.jsp?id=" + evolveFromInfo.getString("basepokemonid") + ">" + evolveFromInfo.getString("pokemonname") + "</a><br>"
							+ "At level " + evolveFromInfo.getString("evolutionlevel"));
					out.print("</td>");
				}
				else {
					out.print("<td>None</td>");
				}
			}
			
			// what does it evolve into?
			evolveIntoInfo = stmt.executeQuery(
				"SELECT " +
				    "E.EVOLVEDPOKEMONID, " +
				    "P.Name AS PokemonName, " +
				    "P.SpriteURL, " +
				    "E.EvolutionLevel " +
				"FROM Evolves E " +
				"JOIN Pokemon P " +
				        "ON E.EVOLVEDPOKEMONID = P.PokemonId " +
				"WHERE E.BASEPOKEMONID = " + pid
			);
			if (evolveIntoInfo != null) {
				if (evolveIntoInfo.next()) {
					out.print("<td>");
					out.print("<img src=" + evolveIntoInfo.getString("spriteurl") + " /><br>"
							+ "#" + evolveIntoInfo.getString("evolvedpokemonid") + ": "
							+ "<a href=pokemon.jsp?id=" + evolveIntoInfo.getString("evolvedpokemonid") + ">" + evolveIntoInfo.getString("pokemonname") + "</a><br>"
							+ "At level " + evolveIntoInfo.getString("evolutionlevel"));
					out.print("</td>");
				}
				else {
					out.print("<td>None</td>");
				}
			}
			
		%>
		</tr>
	</table>
	<br>
	<h3>Natural Learnset</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Move</b></td>
			<td><b>Type</b></td>
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
			        "CL.PokemonId, " +
			        "M.Name AS MoveName, " +
			        "M.MoveId AS MoveId, " +
			        "T.TypeId AS TypeId, " +
			        "T.Name AS TypeName, " +
			        "M.Category, " +
			        "M.MovePower, " +
			        "M.Accuracy, " +
			        "M.BasePP, " +
			        "M.Effect " +
				"FROM CanLearn CL " +
				"JOIN Moves M " +
		   	    	"ON CL.MoveId = M.MoveId " +
				"JOIN Types T " +
		        	"ON M.TypeId = T.TypeId " +
				"WHERE CL.PokemonId = " + pid
			);
			if (moveInfo != null) {
				while (moveInfo.next()) {
					out.print("<tr>");
					out.print("<td><a href=move.jsp?id=" + moveInfo.getString("moveid") + "><i>" + moveInfo.getString("movename") + "</i></a></td>");
					out.print("<td><a href=type.jsp?id=" + moveInfo.getString("typeid") + ">" + moveInfo.getString("typename") + "</a></td>");
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
	<br>
	<h3>In-Game Location(s)</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Location</b></td>
			<td><b>Region</b></td>
		</tr>
		<%
			// where can we find this pokemon?
			locationInfo = stmt.executeQuery(
				"SELECT " +
			    	"PFI.PokemonId, " +
			    	"PFI.LocationId, " +
			        "L.Name AS LocationName, " +
			        "R.Name AS RegionName " +
				"FROM PokemonFoundIn PFI " +
				"JOIN Locations L " +
			        "ON L.LocationId = PFI.LocationId " +
				"JOIN Regions R " +
			        "ON R.RegionId = L.RegionId " +
				"WHERE PFI.PokemonId = " + pid
			);
			if (locationInfo != null) {
				boolean hasData = false;
				while (locationInfo.next()) {
					hasData = true;
					out.print("<tr>");
					out.print("<td><a href=location.jsp?id=" + locationInfo.getString("locationid") + ">" + locationInfo.getString("locationname") + "</a></td>");
					out.print("<td>" + locationInfo.getString("regionname") + "</td>");
					out.print("</tr>");
				}
				if (!hasData) {
					out.print("<tr><td>Not found in wild</td><td></td></tr>");
				}
			}
		%>
	</table>
	
	<%
		if (conn != null) conn.close();
	%>
</body>
</html>