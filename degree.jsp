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
                            "INSERT INTO Degree VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("DEGREE_ID")));
                        pstmt.setString(2, request.getParameter("DEGREE_NAME"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("TOT_UNITS")));
                        pstmt.setString(4, request.getParameter("MAJOR_NAME"));
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
                            "UPDATE Degree SET DEGREE_ID = ?, DEGREE_NAME= ?, " +
                            "TOT_UNITS = ?, MAJOR_NAME = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("DEGREE_ID")));
                        pstmt.setString(2, request.getParameter("DEGREE_NAME"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("TOT_UNITS")));
                        pstmt.setString(4, request.getParameter("MAJOR_NAME"));
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
                            "DELETE FROM Degree WHERE DEGREE_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("DEGREE_ID")));
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
                        ("SELECT * FROM Degree");
            %> <!-- Add an HTML table header row to format the results -->
				<table border="1">
					<tr>
						<th>Degree ID</th>
						<th>Degree Name</th>
						<th>Total Units</th>
						<th>Major</th>
						<!--  <th>Last</th>
						<th>Residency</th>
						<th>Action</th> -->
					</tr>
					<tr>
						<form action="degree.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="DEGREE_ID" size="10"></th>
							<th><input value="" name="DEGREE_NAME" size="15"></th>
							<th><input value="" name="TOT_UNITS" size="10"></th>
							<th><input value="" name="MAJOR_NAME" size="10"></th>
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
						<form action="degree.jsp" method="get">
							<input type="hidden" value="update" name="action">

							<%-- Get the CLASS_ID, which is a number --%>
							<td><input value="<%= rs.getInt("DEGREE_ID") %>" name="DEGREE_ID"
								size="10"></td>

							<%-- Get the TITLE --%>
							<td><input value="<%= rs.getString("DEGREE_NAME") %>" name="DEGREE_NAME"
								size="10"></td>

							<%-- Get the MEMBER1_NAME --%>
							<td><input value="<%= rs.getInt("TOT_UNITS") %>"
								name="TOT_UNITS" size="15"></td>

							<%-- Get the MEMBER2_NAME --%>
							<td><input value="<%= rs.getString("MAJOR_NAME") %>"
								name="MAJOR_NAME" size="15"></td>

							<%-- Button --%>
							<td><input type="submit" value="Update"></td>
						</form>
						<form action="degree.jsp" method="get">
							<input type="hidden" value="delete" name="action"> <input
								type="hidden" value="<%= rs.getInt("DEGREE_ID") %>" name="DEGREE_ID">
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
