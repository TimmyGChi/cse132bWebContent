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
                            "INSERT INTO Course_Enrollment (FIRSTNAME, LASTNAME, COURSE, QUARTER, SECTION, UNITS)"+
    						" VALUES (?, ?, ?, ?, ?, ?);");
                        
                        //pstmt.setInt(1, Integer.parseInt(request.getParameter("ENROLLMENT_ID")));
                        pstmt.setString(1, request.getParameter("FIRSTNAME"));
                        pstmt.setString(2, request.getParameter("LASTNAME"));
                        pstmt.setString(3, request.getParameter("COURSE"));
                        pstmt.setString(4, request.getParameter("QUARTER"));
                        pstmt.setString(5, request.getParameter("SECTION"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("UNITS")));
                        
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
                            "UPDATE Course_Enrollment SET FIRSTNAME = ?, LASTNAME = ?, " +
                            "COURSE = ?, QUARTER = ?, " +
                            "SECTION = ?, UNITS = ?, " +
                            "WHERE ENROLLMENT_ID = ?");
                        
                        pstmt.setString(1, request.getParameter("FIRSTNAME"));
                        pstmt.setString(2, request.getParameter("LASTNAME"));
                        pstmt.setString(3, request.getParameter("COURSE"));
                        pstmt.setString(4, request.getParameter("QUARTER"));
                        pstmt.setString(5, request.getParameter("SECTION"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("UNITS")));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("ENROLLMENT_ID")));
                        
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
                            "DELETE FROM Course_Enrollment WHERE ENROLLMENT_ID = ?");

                        pstmt.setInt(
                        	1, Integer.parseInt(request.getParameter("ENROLLMENT_ID")));
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
                        ("SELECT * FROM Course_Enrollment");
            %> <!-- Add an HTML table header row to format the results -->
				<table border="1">
					<tr>
						<th>Enrollment ID</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Course</th>
						<th>Quarter</th>
						<th>Section</th>
						<th>Units</th>
					</tr>
					<tr>
						<form action="course_enrollment.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input type="hidden" name="ENROLLMENT_ID" size="10"></th>
							<th><input value="" name="FIRSTNAME" size="15"></th>
							<th><input value="" name="LASTNAME" size="15"></th>
							<th><input value="" name="COURSE" size="15"></th>
							<th><input value="" name="QUARTER" size="15"></th>
							<th><input value="" name="SECTION" size="15"></th>
							<th><input value="" name="UNITS" size="15"></th>
							<th><input type="submit" value="Insert"></th>
						</form>
					</tr>

					<%-- -------- Iteration Code -------- --%>
					<%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
            %>

					<tr>
						<form action="course_enrollment.jsp" method="get">
							<input type="hidden" value="update" name="action">

							<%-- Get the SSN, which is a number --%>
							<td><input value="<%= rs.getInt("ENROLLMENT_ID") %>" name="ENROLLMENT_ID"
								size="10"></td>

							<%-- Get the FIRSTNAME --%>
							<td><input value="<%= rs.getString("FIRSTNAME") %>"
								name="FIRSTNAME" size="15"></td>

							<%-- Get the LASTNAME --%>
							<td><input value="<%= rs.getString("LASTNAME") %>"
								name="LASTNAME" size="15"></td>
								
							<%-- Get the ISCALRES --%>
							<td><input value="<%= rs.getString("COURSE") %>"
								name="COURSE" size="15"></td>
							
							<%-- Get the ISFOREIGN --%>
							<td><input value="<%= rs.getString("QUARTER") %>"
								name="QUARTER" size="15"></td>
								
							<%-- Get the DEPARTMENT --%>
							<td><input value="<%= rs.getString("SECTION") %>"
								name="SECTION" size="15"></td>
									
							<%-- Get the ISENROLLED --%>
							<td><input value="<%= rs.getString("UNITS") %>"
								name="UNITS" size="15"></td>
								
							<%-- Button --%>
							<td><input type="submit" value="Update"></td>
						</form>
						<form action="course_enrollment.jsp" method="get">
							<input type="hidden" value="delete" name="action"> <input
								type="hidden" value="<%= rs.getInt("ENROLLMENT_ID") %>" name="ENROLLMENT_ID">
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
