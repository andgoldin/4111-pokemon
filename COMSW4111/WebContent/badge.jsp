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
	ResultSet badgeInfo = null;
	String error_msg = "";
	String bid = (request.getParameter("id") == null) ? "1" : request.getParameter("id"); // if no request is made, default to 1	
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
	badgeInfo = stmt.executeQuery(
		"SELECT " +
       		"B.BadgeId, " +
        	"B.Name as BadgeName, " +
        	"B.Gymleadername, " +
        	"L.LocationId, " +
        	"L.Name as LocationName, " +
        	"COUNT(E.AccountId) AS TotalAccountsWhoEarned " +
		"FROM Badges B " +
		"JOIN Locations L " +
        	"ON B.LocationId = L.LocationId " +
		"JOIN Earned E " +
        	"ON B.BadgeId = E.BadgeId " +
		"WHERE B.BadgeId = " + bid +
		"GROUP BY B.BadgeId, " +
        	"B.Name, " +
        	"B.Gymleadername, " +
        	"L.LocationId, " +
        	"L.Name "
	);
	if (badgeInfo != null) badgeInfo.next();
%>

<title><%= badgeInfo.getString("badgename") %> - Badge Information</title>
</head>
<body>
	<a href="index.jsp">Back to Homepage</a><br>
	<h2>Badge: <i><%= badgeInfo.getString("badgename") %></i></h2>
	<h3>Obtained From</h3>
	<b>Gym leader: <i><%= badgeInfo.getString("gymleadername") %></i></b><br>
	<a href=location.jsp?id=<%= badgeInfo.getString("locationid") %>><%= badgeInfo.getString("locationname") %></a> Gym<br>
	<br>
	<h3><i><%= badgeInfo.getString("totalaccountswhoearned") %></i> Users Have Earned This Badge</h3>
	<%
		if (conn != null) conn.close();
	%>
</body>
</html>