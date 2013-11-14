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
	String newidnum = "";
	try {
		OracleDataSource ods = new OracleDataSource();

		ods.setURL("jdbc:oracle:thin:yg2346/vulpix123@//w4111b.cs.columbia.edu:1521/ADB");
		conn = ods.getConnection();
		Statement stmt = conn.createStatement();
		rset = stmt.executeQuery("SELECT MAX(AccountId) AS MaxId FROM Account");
		if (rset != null) rset.next();
		newidnum = (rset.getInt("maxid") + 1) + "";
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
<title>The 4111 Pokedex!</title>
</head>
<body>
	<h2>Welcome to the 4111 Pokedex!</h2>
	<h3>Created by:</h3>
	Yufeng Guo (<a href="mailto:yg2346@columbia.edu">yg2346</a>) / Andrew Goldin (<a href="mailto:adg2160@columbia.edu">adg2160</a>)<br><br>
	For <a href="http://www.cs.columbia.edu/~biliris/4111/index.htm/">COMS W4111, Fall 2013</a><br>
	<h3>Browse for:</h3>
	- <a href="pokemon_all.jsp">Pokemon</a><br>
	- <a href="moves_all.jsp">Moves</a><br>
	- <a href="locations_all.jsp">Locations</a><br>
	<h3>User Accounts</h3>
	<form name="login" action="account.jsp" method="get">
		Log in with your User ID: <input type="text" name="id">
		<input type="submit" value="Log In!">
	</form>
	<br>
	<form name="createaccount" action="account.jsp" method="get">
		Or create a <i><b>new account!</b></i><br>
		<input type="hidden" name="id" value="<%= newidnum %>">
		<input type="hidden" name="action" value="createaccount">
		Display name: <input type="text" name="displayname"><br>
		Experience: <input type="text" name="exp"><br>
		Today's date: <input type="text" name="createdate"><br>
		<input type="submit" value="Make my account!"><br>
	</form>
</body>
</html>