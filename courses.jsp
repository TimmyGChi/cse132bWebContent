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
                            "INSERT INTO Course VALUES (?, ?, ?, ?, ?, ?, ? )");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("COURSE_ID")));
                        pstmt.setString(2, request.getParameter("TITLE"));
                        pstmt.setString(3, request.getParameter("GRADE_OPT"));
                        pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("HAS_LAB")));
                        pstmt.setBoolean(5, Boolean.parseBoolean(request.getParameter("NEED_PROF_CONS")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("UNITS")));
                        pstmt.setString(7, request.getParameter("PREREQS"));
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
                            "UPDATE Course SET TITLE= ?, " +
                            "GRADE_OPT = ?, HAS_LAB = ?, NEED_PROF_CONS = ?, UNITS = ?, "+
                            "PREREQS = ? WHERE COURSE_ID = ?");

                        //pstmt.setInt(1, Integer.parseInt(request.getParameter("COURSE_ID")));
                        //pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(1, request.getParameter("TITLE"));
                        pstmt.setString(2, request.getParameter("GRADE_OPT"));
                        pstmt.setBoolean(3, Boolean.parseBoolean(request.getParameter("HAS_LAB")));
                        pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("NEED_PROF_CONS")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("UNITS")));
                        pstmt.setString(6, request.getParameter("PREREQS"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("COURSE_ID")));
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
                            "DELETE FROM Course WHERE COURSE_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("COURSE_ID")));
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
                        ("SELECT * FROM Course");
            %> <!-- Add an HTML table header row to format the results -->
				<table border="1">
					<tr>
						<th>Course_ID</th>
						<th>Title</th>
						<th>Grade Option</th>
						<th>Lab</th>
						<th>Professor's Consent</th>
						<th>Units</th>
						<th>Pre-requisites</th>
						<!--  <th>Last</th>
						<th>Residency</th>
						<th>Action</th> -->
					</tr>
					<tr>
						<form action="courses.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="COURSE_ID" size="10"></th>
							<th><input value="" name="TITLE" size="15"></th>
							<th><input value="" name="GRADE_OPT" size="10"></th>
							<th><input value="" name="HAS_LAB" size="10"></th>
							<th><input value="" name="NEED_PROF_CONS" size="10"></th>
							<th><input value="" name="UNITS" size="10"></th>
							<th><input value="" name="PREREQS" size="15"></th>
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
						<form action="courses.jsp" method="get">
							<input type="hidden" value="update" name="action">
							
							<%-- Get the CLASS_ID, which is a number --%>
							<td><input value="<%= rs.getInt("COURSE_ID") %>" name="COURSE_ID"
								size="10"></td>

							<%-- Get the TITLE --%>
							<td><input value="<%= rs.getString("TITLE") %>" name="TITLE"
								size="10"></td>

							<%-- Get the SECTION_ID --%>
							<td><input value="<%= rs.getString("GRADE_OPT") %>"
								name="GRADE_OPT" size="15"></td>

							<%-- Get the COURSE_ID --%>
							<td><input value="<%= rs.getString("HAS_LAB") %>"
								name="HAS_LAB" size="15"></td>

							<%-- Get the LASTNAME --%>
							<td><input value="<%= rs.getString("NEED_PROF_CONS") %>"
								name="NEED_PROF_CONS" size="15"></td>

							<%-- Get the COLLEGE --%>
							<td><input value="<%= rs.getString("UNITS") %>"
								name="UNITS" size="15"></td> 
					
							<%-- Get the PREREQS --%>
							<td><input value="<%= rs.getString("PREREQS") %>" name="PREREQS"
								size="10"></td>
								
							<%-- Button --%>
							<td><input type="submit" value="Update"></td>
						</form>
						<form action="courses.jsp" method="get">
							<input type="hidden" value="delete" name="action"> <input
								type="hidden" value="<%= rs.getInt("COURSE_ID") %>" name="COURSE_ID">
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
