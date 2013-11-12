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
		rset = stmt.executeQuery(
			"SELECT " +
				"L.LocationId, " +
				"L.Name AS LocationName, " +
				"R.Name AS RegionName " +
			"FROM Locations L " +
			"JOIN Regions R " +
				"ON R.RegionId = L.RegionId"
		);
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
<title>All Locations</title>
</head>
<body>
	<H2>ALL LOCATIONS</H2>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Location</b></td>
			<td><b>Region</b></td>
		<tr>
		<%
			if (rset != null) {
				while (rset.next()) {
					out.print("<tr>");
					out.print("<td><a href=location.jsp?id=" + rset.getString("locationid") + ">" + rset.getString("locationname") + "</a></td>");
					out.print("<td>" + rset.getString("regionname") + "</td>");
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