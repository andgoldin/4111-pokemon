<%@page import="java.util.Formatter"%>
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
	ResultSet apid = null;
	ResultSet detailInfo = null;
	ResultSet pokemonInfo = null;
	ResultSet badgeInfo = null;
	String error_msg = "";
	String aid = (request.getParameter("id") == null) ? "1" : request.getParameter("id"); // if no request is made, default to 1	
	try {
		OracleDataSource ods = new OracleDataSource();
		ods.setURL("jdbc:oracle:thin:yg2346/vulpix123@//w4111b.cs.columbia.edu:1521/ADB");
		conn = ods.getConnection();
		stmt = conn.createStatement();
		if (request.getParameter("action") != null) {
			String action = request.getParameter("action");
			if (action.equals("createaccount")) {
				stmt.executeUpdate(
					"INSERT INTO Account VALUES (" + 
						request.getParameter("id") + ", \'" + request.getParameter("displayname") + "\', " +
						request.getParameter("exp") + ", \'" + request.getParameter("createdate") + "\')"
					);
			}
			else if (action.equals("addpokemon")) {
				apid = stmt.executeQuery("SELECT MAX(AccountPokemonId) AS apid FROM ACCOUNTPOKEMON");
				if (apid != null) apid.next();
				String acctpokid = (apid.getInt("apid") + 1) + "";
				stmt.executeUpdate(
					"INSERT INTO AccountPokemon VALUES (" + 
						acctpokid + ", " + aid + ", " + request.getParameter("pid") +
						", " + request.getParameter("level") + ", \'" + request.getParameter("capdate") +
						"\', \'" + request.getParameter("nickname") + "\')"
				);
			}
			else if (action.equals("removepokemon")) {
				stmt.executeUpdate(
					"DELETE FROM ACCOUNTPOKEMON WHERE AccountPokemonId = " + request.getParameter("actpkid")
				);
			}
			else if (action.equals("addbadge")) {
				stmt.executeUpdate(
					"INSERT INTO Earned VALUES (" + 
						aid + ", " + request.getParameter("bid") + ", \'" + request.getParameter("earndate") + "\')"
				);
			}
			else if (action.equals("removebadge")) {
				stmt.executeUpdate(
					"DELETE FROM Earned WHERE AccountId = " + aid + " AND BadgeId = " + request.getParameter("badid")
				);
			}
		}
	} catch (SQLException e) {
		error_msg = e.getMessage();
		e.printStackTrace();
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
	// get pokemon info before title to include name in title
	detailInfo = stmt.executeQuery(
		"SELECT " +
	    	"ACCOUNTID, " +
	        "DISPLAYNAME, " +
	        "EXPERIENCE, " +
	        "CREATEDATE " +
		"FROM ACCOUNT " +
		"WHERE ACCOUNTID = " + aid
	);
	if (detailInfo != null) {
		detailInfo.next();
	}
%>

<title><%= detailInfo.getString("displayname") %> - Account Information</title>
</head>
<body>
	<a href="index.jsp">Back to Homepage</a><br>
	<h2>Account: <i><%= detailInfo.getString("displayname") %></i></h2>
	<h3>Account Details</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Account No.</b></td>
			<td><b>Display Name</b></td>
			<td><b>Experience</b></td>
			<td><b>Create Date</b></td>
		</tr>
		<%
			if (detailInfo != null) {
				out.print("<tr>");
				out.print("<td>" + String.format("%d", detailInfo.getInt("accountid")) + "</td>");
				out.print("<td>" + detailInfo.getString("displayname") + "</td>");
				out.print("<td>" + detailInfo.getString("experience") + "</td>");
				out.print("<td>" + detailInfo.getString("createdate") + "</td>");
				out.print("<tr>");
			}
		%>
	</table>
	<br>
	<h3>Your Pokemon</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Pokemon</b></td>
			<td><b>Nickname</b></td>
			<td><b>Level</b></td>
			<td><b>Capture Date</b></td>
			<td><b>Remove?</b></td>
		</tr>
		<%
			pokemonInfo = stmt.executeQuery(
				"SELECT " +
			        "P.PokemonId, " +
			        "P.SpriteURL, " +
			        "P.Name AS PokemonName, " +
			        "AP.AccountPokemonId, " +
			        "AP.POKEMONLEVEL, " +
			        "AP.CAPTUREDATE, " +
			        "AP.NICKNAME " +
				"FROM AccountPokemon AP " +
				"JOIN Pokemon P " +
			        "ON P.PokemonId = AP.PokemonId " +
				"WHERE AP.AccountId = " + aid
			);
			if (pokemonInfo != null) {
				boolean hasData = false;
				while (pokemonInfo.next()) {
					hasData = true;
					out.print("<tr>");
					out.print("<td><img src=" + pokemonInfo.getString("spriteurl") + " />&nbsp;"
						+ "#" + pokemonInfo.getString("pokemonid") + ": "
						+ "<a href=pokemon.jsp?id=" + pokemonInfo.getString("pokemonid") + ">"
						+ pokemonInfo.getString("pokemonname") + "</a></td>");
					out.print("<td>" + (pokemonInfo.getString("nickname") == null ? pokemonInfo.getString("pokemonname") : "\"" + pokemonInfo.getString("nickname") + "\"") + "</td>");
					out.print("<td>" + pokemonInfo.getString("pokemonlevel") + "</td>");
					out.print("<td>" + pokemonInfo.getString("capturedate") + "</td>");
					out.print("<td><a href=account.jsp?id=" + aid + "&action=removepokemon&actpkid=" + pokemonInfo.getString("accountpokemonid") + ">Remove</a></td>");
					out.print("</tr>");
				}
				if (!hasData) {
					out.print("<tr><td>None</td><td></td><td></td><td></td><td></td></tr>");
				}
			}
		%>
	</table><br>
	<h3>Add New Pokemon</h3>
	<%
		ResultSet pokemonList = stmt.executeQuery("SELECT pokemonid, name FROM pokemon");
	%>
	<form name="addpokemon" action="account.jsp" method="get">
		<input type="hidden" name="id" value="<%= aid %>">
		<input type="hidden" name="action" value="addpokemon">
		<select name="pid">
			<%
				if (pokemonList != null) {
					while (pokemonList.next()) {
						out.print("<option value=" + pokemonList.getString("pokemonid") + ">"
								+ pokemonList.getString("name") + "</option>");
					}
				}
			
			%>
		</select>
		<input type="text" name="nickname" value="Nickname">
		<input type="text" name="level" size="12" value="Level (1-100)">
		<input type="text" name="capdate" size="15" value="Date Captured">
		<input type="submit" value="Add it!">
	</form>
	<br>
	<h3>Badges Earned</h3>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Badge Name</b></td>
			<td><b>Date Earned</b></td>
			<td><b>Gym Leader</b></td>
			<td><b>Location</b></td>
			<td><b>Remove?</b></td>
		</tr>
		<%
			java.util.ArrayList<String> badgeList = new java.util.ArrayList<String>();
			badgeInfo = stmt.executeQuery(
				"SELECT " +
			        "B.BadgeId, " +
			        "B.Name AS BadgeName, " +
			        "B.GymLeaderName AS GymLeaderName, " +
			       	"L.LocationId, " +
			       	"L.Name AS LocationName, " +
			        "E.DateEarned " +
				"FROM Earned E " +
				"JOIN Badges B " +
			        "ON B.BadgeId = E.BadgeId " +
			    "JOIN Locations L " +
				    "ON B.LocationId = L.LocationId " +
				"WHERE E.AccountId = " + aid + " " +
				"ORDER BY B.BadgeId"
			);
			if (badgeInfo != null) {
				boolean hasData = false;
				while (badgeInfo.next()) {
					badgeList.add(badgeInfo.getString("badgeid"));
					hasData = true;
					out.print("<tr>");
					out.print("<td><a href=badge.jsp?id=" + badgeInfo.getString("badgeid") + ">"
						+ badgeInfo.getString("badgename") + "</a></td>");
					out.print("<td>" + badgeInfo.getString("dateearned") + "</td>");
					out.print("<td>" + badgeInfo.getString("gymleadername") + "</td>");
					out.print("<td><a href=location.jsp?id=" + badgeInfo.getString("locationid") + ">"
						+ badgeInfo.getString("locationname") + "</a></td>");
					out.print("<td><a href=account.jsp?id=" + aid + "&action=removebadge&badid=" + badgeInfo.getString("badgeid") + ">Remove</a></td>");
					out.print("</tr>");
				}
				if (!hasData) {
					out.print("<tr><td>None</td><td></td><td></td><td></td></tr>");
				}
			}
		%>
	</table><br>
	<h3>Add New Badge</h3>
	<%
		ResultSet badgeSet = stmt.executeQuery("SELECT badgeid, name FROM badges");
	%>
	<form name="addbadge" action="account.jsp" method="get">
		<input type="hidden" name="id" value="<%= aid %>">
		<input type="hidden" name="action" value="addbadge">
		<select name="bid">
			<%
				if (badgeSet != null) {
					while (badgeSet.next()) {
						if (!badgeList.contains(badgeSet.getString("badgeid"))) {
							out.print("<option value=" + badgeSet.getString("badgeid") + ">"
									+ badgeSet.getString("name") + "</option>");
						}
					}
				}
			
			%>
		</select>
		<input type="text" name="earndate" size="15" value="Date Earned">
		<input type="submit" value="Add it!">
	</form>
	<%
		if (conn != null) conn.close();
	%>
</body>
</html>
