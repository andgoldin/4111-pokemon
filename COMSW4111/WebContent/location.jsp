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
	ResultSet locationInfo = null;
	ResultSet foundInfo = null;
	ResultSet adjacentInfo = null;
	ResultSet adjacentFoundInfo = null;
	String error_msg = "";
	String lid = (request.getParameter("id") == null) ? "1" : request.getParameter("id"); // if no request is made, default to 1	
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
	locationInfo = stmt.executeQuery(
		"SELECT " +
			"L.LocationId, " +
			"L.Name AS LocationName, " +
			"R.Name AS RegionName " +
		"FROM Locations L " +
		"JOIN Regions R " +
			"ON R.RegionId = L.RegionId " +
		"WHERE L.LocationId = " + lid
	);
	if (locationInfo != null) {
		locationInfo.next();
	}
%>

<title><%= locationInfo.getString("locationname") %> - Location Information</title>
</head>
<body>
	<a href="index.jsp">Back to Homepage</a><br>
	<h2>Location: <i><%= locationInfo.getString("locationname") %></i></h2>
	<h3>Region</h3>
	- <%= locationInfo.getString("regionname") %>
	<br>
	<h3>Pokemon Found At This Location</h3>
	<%
		foundInfo = stmt.executeQuery(
			"SELECT " +
		        "P.PokemonId, " +
		        "P.SpriteURL, " +
		        "P.Name AS PokemonName " +
			"FROM Locations L1 " +
			"JOIN PokemonFoundIn PFI " +
		    	"ON PFI.LocationId = L1.LocationId " +
			"JOIN Pokemon P " +
		        "ON P.PokemonId = PFI.PokemonId " +
			"WHERE L1.LocationId = " + lid
		);
		if (foundInfo != null) {
			boolean hasData = false;
			while (foundInfo.next()) {
				hasData = true;
				out.print("<img src=" + foundInfo.getString("spriteurl") + " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				out.print("#" + foundInfo.getString("pokemonid") + ": "
						+ "<a href=pokemon.jsp?id=" + foundInfo.getString("pokemonid") + ">" + foundInfo.getString("pokemonname") + "</a><br>");
			}
			if (!hasData) {
				out.print("None");
			}
		}
	%>
	<br>
	<h3>Neighboring Locations</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Location</b></td>
			<td><b>Region</b></td>
		</tr>
		<%
			java.util.ArrayList<String> adj = new java.util.ArrayList<String>();
			adjacentInfo = stmt.executeQuery(
				"SELECT " +
					"L1.LocationId AS LocationId1, " +
					"L1.Name as LocationName1, " +
					"L2.LocationId AS locationId2, " +
				    "L2.Name as LocationName2, " +
				    "R.Name as RegionName " +
				"FROM Locations L1 " +
				"JOIN ConnectedTo C " +
				    "ON C.StartRouteId = L1.LocationId " +
				"JOIN Locations L2 " +
				    "ON C.LocationId = L2.LocationId " +
				"JOIN Regions R " +
					"ON R.RegionId = L2.RegionId " +
				"WHERE L1.LocationId = " + lid + " OR L2.LocationId = " + lid + " " +
				"ORDER BY L2.LocationId"
			);
			if (adjacentInfo != null) {
				boolean hasData = false;
				while (adjacentInfo.next()) {
					hasData = true;
					if (!adjacentInfo.getString("locationid1").equals(lid)) {
						adj.add(adjacentInfo.getString("locationid1"));
						out.print("<tr>");
						out.print("<td><a href=location.jsp?id=" + adjacentInfo.getString("locationid1") + ">" + adjacentInfo.getString("locationname1") + "</a></td>");
						out.print("<td>" + adjacentInfo.getString("regionname") + "</td>");
						out.print("</tr>");
					}
					else if (!adjacentInfo.getString("locationid2").equals(lid)) {
						adj.add(adjacentInfo.getString("locationid2"));
						out.print("<tr>");
						out.print("<td><a href=location.jsp?id=" + adjacentInfo.getString("locationid2") + ">" + adjacentInfo.getString("locationname2") + "</a></td>");
						out.print("<td>" + adjacentInfo.getString("regionname") + "</td>");
						out.print("</tr>");
					}
				}
				if (!hasData) {
					out.print("<tr><td>None</td><td></td></tr>");
				}
			}
		%>
	</table>
	<br>
	<h3>Pokemon Found In Neighboring Locations</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Location</b></td>
			<td><b>Pokemon</b></td>
		</tr>
		<%
			String locLookup = adj.toString().replace('[', '(').replace(']', ')');
			adjacentFoundInfo = stmt.executeQuery(
				"SELECT " +
			        "P.PokemonId, " +
			        "P.SpriteURL, " +
			        "P.Name AS PokemonName, " +
			       	"L1.LocationId, " +
			        "L1.Name AS LocationName " +
				"FROM Locations L1 " +
				"JOIN PokemonFoundIn PFI " +
			    	"ON PFI.LocationId = L1.LocationId " +
				"JOIN Pokemon P " +
			        "ON P.PokemonId = PFI.PokemonId " +
				"WHERE L1.LocationId IN " + locLookup + " " +
			    "ORDER BY L1.LocationId"
			);
			if (adjacentFoundInfo != null) {
				boolean hasData = false;
				while (adjacentFoundInfo.next()) {
					hasData = true;
					out.print("<tr>");
					out.print("<td><a href=location.jsp?id=" + adjacentFoundInfo.getString("locationid") + ">" + adjacentFoundInfo.getString("locationname") + "</a></td>");
					out.print("<td><img src=" + adjacentFoundInfo.getString("spriteurl") + " />&nbsp;");
					out.print("#" + adjacentFoundInfo.getString("pokemonid") + ": "
							+ "<a href=pokemon.jsp?id=" + adjacentFoundInfo.getString("pokemonid") + ">" + adjacentFoundInfo.getString("pokemonname") + "</a></td>");
					out.print("</tr>");
				}
				if (!hasData) {
					out.print("<tr><td>None</td><td></tr>");
				}
			}
		%>
	</table>
	<%
		if (conn != null) conn.close();
	%>
</body>
</html>