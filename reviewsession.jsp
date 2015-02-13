<html>

<body>
	<table border="1">
		<tr>
			<td valign="top">
				<%-- -------- Include menu HTML code -------- --%> <jsp:include
					page="menu.html" />
			</td>
			<td>
				<%-- Set the scripting language to Java and --%> <%-- Import the java.sql package --%>
				<%@ page language="java" import="java.sql.*"%>

				<%-- -------- Open Connection Code -------- --%> <%
                try {
                    // Load Oracle Driver class file
                    Class.forName("org.postgresql.Driver");
					Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cs132b", "postgres", "880210");

            %> <%-- -------- INSERT Code -------- --%> <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO ReviewSession VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("WEEK_NUM")));
                        pstmt.setString(3,request.getParameter("DAY_OF_WEEK"));
                        pstmt.setString(4, request.getParameter("BUILDING_NAME"));
                        pstmt.setInt(5,Integer.parseInt(request.getParameter("ROOM_NUM")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %> <%-- -------- UPDATE Code -------- --%> <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE ReviewSession SET CLASS_ID = ?, WEEK_NUM= ?, " +
                            "DAY_OF_WEEK = ?, BUILDING_NAME = ?, ROOM_NUM = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("WEEK_NUM")));
                        pstmt.setString(3,request.getParameter("DAY_OF_WEEK"));
                        pstmt.setString(4, request.getParameter("BUILDING_NAME"));
                        pstmt.setInt(5,Integer.parseInt(request.getParameter("ROOM_NUM")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %> <%-- -------- DELETE Code -------- --%> <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM ReviewSession WHERE CLASS_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %> <%-- -------- SELECT Statement Code -------- --%> <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Class table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM ReviewSession");
            %> <!-- Add an HTML table header row to format the results -->
				<table border="1">
					<tr>
						<th>Class ID</th>
						<th>Week Number</th>
						<th>Day of Week</th>
						<th>Building</th>
						<th>Room Number</th>
						<!--  <th>Last</th>
						<th>Residency</th>
						<th>Action</th> -->
					</tr>
					<tr>
						<form action="reviewsession.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="CLASS_ID" size="10"></th>
							<th><input value="" name="WEEK_NUM" size="15"></th>
							<th><input value="" name="DAY_OF_WEEK" size="10"></th>
							<th><input value="" name="BUILDING_NAME" size="10"></th>
							<th><input value="" name="ROOM_NUM" size="10"></th>
							<!--  <th><input value="" name="LASTNAME" size="15"></th>
							<th><input value="" name="RESIDENCY" size="15"></th> -->
							<th><input type="submit" value="Insert"></th>
						</form>
					</tr>

					<%-- -------- Iteration Code -------- --%>
					<%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

					<tr>
						<form action="reviewsession.jsp" method="get">
							<input type="hidden" value="update" name="action">

							<%-- Get the CLASS_ID, which is a number --%>
							<td><input value="<%= rs.getInt("CLASS_ID") %>" name="CLASS_ID"
								size="10"></td>

							<%-- Get the TITLE --%>
							<td><input value="<%= rs.getInt("WEEK_NUM") %>" name="WEEK_NUM"
								size="10"></td>

							<%-- Get the MEMBER1_NAME --%>
							<td><input value="<%= rs.getString("DAY_OF_WEEK") %>"
								name="DAY_OF_WEEK" size="15"></td>

							<%-- Get the MEMBER2_NAME --%>
							<td><input value="<%= rs.getString("BUILDING_NAME") %>"
								name="BUILDING_NAME" size="15"></td>

							<%-- Get the MEMBER3_NAME --%>
							<td><input value="<%= rs.getInt("ROOM_NUM") %>"
								name="ROOM_NUM" size="15"></td>

							<%-- Button --%>
							<td><input type="submit" value="Update"></td>
						</form>
						<form action="reviewsession.jsp" method="get">
							<input type="hidden" value="delete" name="action"> <input
								type="hidden" value="<%= rs.getInt("CLASS_ID") %>" name="CLASS_ID">
							<%-- Button --%>
							<td><input type="submit" value="Delete"></td>
						</form>
					</tr>
					<%
                    }
            %>

					<%-- -------- Close Connection Code -------- --%>
					<%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
				</table>
			</td>
		</tr>
	</table>
</body>

</html>
