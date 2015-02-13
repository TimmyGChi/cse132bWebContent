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
                            "INSERT INTO ClassesTaken VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("COURSE_ID")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(4, request.getParameter("QUARTER"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setString(6, request.getParameter("GRADE"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("SECTION_ID")));
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
                            "UPDATE ClassesTaken SET SSN = ?, COURSE_ID = ?, " +
                            "CLASS_ID = ?, QUARTER = ? , " +
                            "YEAR = ?, GRADE = ?, SECTION_ID = ?");
                        

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("COURSE_ID")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(4, request.getParameter("QUARTER"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setString(6, request.getParameter("GRADE"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("SECTION_ID")));
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
                            "DELETE FROM ClassesTaken WHERE SSN = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %> <%-- -------- SELECT Statement Code -------- --%> <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM ClassesTaken");
            %> <!-- Add an HTML table header row to format the results -->
				<table border="1">
					<tr>
						<th>SSN</th>
						<th>Course ID</th>
						<th>Class ID</th>
						<th>Quarter</th>
						<th>Year</th>
						<th>Grade</th>
						<th>Section ID</th>
					</tr>
					<tr>
						<form action="classestaken.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="SSN" size="10"></th>
							<th><input value="" name="COURSE_ID" size="10"></th>
							<th><input value="" name="CLASS_ID" size="15"></th>
							<th><input value="" name="QUARTER" size="15"></th>
							<th><input value="" name="YEAR" size="15"></th>
							<th><input value="" name="GRADE" size="15"></th>
							<th><input value="" name="SECTION_ID" size="15"></th>
							<th><input type="submit" value="Insert"></th>
						</form>
					</tr>

					<%-- -------- Iteration Code -------- --%>
					<%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

					<tr>
						<form action="classestaken.jsp" method="get">
							<input type="hidden" value="update" name="action">

							<%-- Get the SSN, which is a number --%>
							<td><input value="<%= rs.getInt("SSN") %>" name="SSN"
								size="10"></td>

							<%-- Get the ID --%>
							<td><input value="<%= rs.getInt("COURSE_ID") %>" name="COURSE_ID"
								size="10"></td>

							<%-- Get the FIRSTNAME --%>
							<td><input value="<%= rs.getInt("CLASS_ID") %>"
								name="CLASS_ID" size="15"></td>

							<%-- Get the LASTNAME --%>
							<td><input value="<%= rs.getString("QUARTER") %>"
								name="QUARTER" size="15"></td>

							<%-- Get the RESIDENCY --%>
							<td><input value="<%= rs.getInt("YEAR") %>"
								name="YEAR" size="15"></td>
							
							<%-- Get the DEPARTMENT --%>
							<td><input value="<%= rs.getString("GRADE") %>"
								name="GRADE" size="15"></td>
								
							<%-- Get the ISFOREIGN --%>
							<td><input value="<%= rs.getInt("SECTION_ID") %>"
								name="SECTION_ID" size="15"></td>
								
							<%-- Button --%>
							<td><input type="submit" value="Update"></td>
						</form>
						<form action="classestaken.jsp" method="get">
							<input type="hidden" value="delete" name="action"> <input
								type="hidden" value="<%= rs.getInt("SSN") %>" name="SSN">
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
