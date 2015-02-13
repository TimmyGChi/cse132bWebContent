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
                            "INSERT INTO Faculty VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("FACULTY_ID")));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
                        pstmt.setString(3, request.getParameter("LASTNAME"));
                        pstmt.setString(4, request.getParameter("DEPARTMENT"));
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
                            "UPDATE Class SET FIRSTNAME= ?, " +
                            "LASTNAME = ?, DEPARTMENT = ? WHERE FACULTY = ?");

                        //pstmt.setString(1, request.getParameter("CLASS_ID"));
                        //pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("FACULTY_ID")));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
                        pstmt.setString(3, request.getParameter("LASTNAME"));
                        pstmt.setString(4, request.getParameter("DEPARTMENT"));
                        
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
                            "DELETE FROM Faculty WHERE FACULTY_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("FACULTY_ID")));
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
                        ("SELECT * FROM FACULTY");
            %> <!-- Add an HTML table header row to format the results -->
				<table border="1">
					<tr>
						<th>Faculty ID</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Department</th>
						<!--  <th>Last</th>
						<th>Residency</th>
						<th>Action</th> -->
					</tr>
					<tr>
						<form action="faculties.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="FACULTY_ID" size="10"></th>
							<th><input value="" name="FIRSTNAME" size="15"></th>
							<th><input value="" name="LASTNAME" size="15"></th>
							<th><input value="" name="DEPARTMENT" size="15"></th>
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
						<form action="faculties.jsp" method="get">
							<input type="hidden" value="update" name="action">

							<%-- Get the CLASS_ID, which is a number --%>
							<td><input value="<%= rs.getInt("FACULTY_ID") %>" 
								name="FACULTY_ID" size="10"></td>

							<%-- Get the TITLE --%>
							<td><input value="<%= rs.getString("FIRSTNAME") %>" 
								name=FIRSTNAME size="10"></td>

							<%-- Get the SECTION_ID --%>
							<td><input value="<%= rs.getString("LASTNAME") %>"
								name="LASTNAME" size="15"></td>

							<%-- Get the COURSE_ID --%>
							<td><input value="<%= rs.getString("DEPARTMENT") %>"
								name="DEPARTMENT" size="15"></td>

							<%-- Button --%>
							<td><input type="submit" value="Update"></td>
						</form>
						<form action="faculties.jsp" method="get">
							<input type="hidden" value="delete" name="action"> <input
								type="hidden" value="<%= rs.getInt("FACULTY_ID") %>" name="FACULTY_ID">
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
