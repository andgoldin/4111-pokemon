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
	ResultSet moveInfo = null;
	String error_msg = "";
	try {
		OracleDataSource ods = new OracleDataSource();

		ods.setURL("jdbc:oracle:thin:yg2346/vulpix123@//w4111b.cs.columbia.edu:1521/ADB");
		conn = ods.getConnection();
		Statement stmt = conn.createStatement();
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
		        "ON M.TypeId = T.TypeId"
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
<title>All Moves</title>
</head>
<body>
	<H2>ALL MOVES</H2>
	<table style="border-spacing: 15px 2px;">
		<tr>
			<td><b>Move</b></td>
			<td><b>Type</b></td>
			<td><b>Category</b></td>
			<td><b>Power</b></td>
			<td><b>Accuracy</b></td>
			<td><b>Base PP</b></td>
			<td><b>Effect</b></td>
		<tr>
		<%
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
</body>
</html>