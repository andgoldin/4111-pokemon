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
	
	<%
		if (conn != null) conn.close();
	%>
</body>
</html>