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
                            "INSERT INTO Student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                        String s = request.getParameter("SSN");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        s = request.getParameter("ID");
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ID")));
                        s = request.getParameter("FIRSTNAME");
                        pstmt.setString(3, request.getParameter("FIRSTNAME"));
                        s = request.getParameter("LASTNAME");
                        pstmt.setString(4, request.getParameter("LASTNAME"));
                        s = request.getParameter("ISCALRES");
                        pstmt.setBoolean(5, Boolean.parseBoolean(request.getParameter("ISCALRES")));
                        s = request.getParameter("ISFOREIGN");
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("ISFOREIGN")));
                        s = request.getParameter("DEPARTMENT");
                        pstmt.setString(7, request.getParameter("DEPARTMENT"));
                        s = request.getParameter("ISENROLLED");
                        pstmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("ISENROLLED")));
                        s = request.getParameter("PROGRAM");
                        pstmt.setString(9, request.getParameter("PROGRAM"));
                        
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
                            "UPDATE Student SET ID = ?, FIRSTNAME = ?, " +
                            "LASTNAME = ?, ISCALRES = ?, " +
                            "ISFOREIGN = ?, DEPARTMENT = ?, " +
                            "ISENROLLED = ?, PROGRAM = ? WHERE SSN = ?");
                        

                        String s = request.getParameter("ID");
                        pstmt.setString(1, request.getParameter("ID"));
                        s = request.getParameter("FIRSTNAME");
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
                        s = request.getParameter("LASTNAME");
                        pstmt.setString(3, request.getParameter("LASTNAME"));
                        s = request.getParameter("ISCALRES");
                        pstmt.setString(4, request.getParameter("ISCALRES"));
                        s = request.getParameter("ISFOREIGN");
                        pstmt.setString(5, request.getParameter("ISFOREIGN"));
                        s = request.getParameter("DEPARTMENT");
                        pstmt.setString(6, request.getParameter("DEPARTMENT"));
                        s = request.getParameter("ISENROLLED");
                        pstmt.setString(7, request.getParameter("ISENROLLED"));
                        s = request.getParameter("PROGRAM");
                        pstmt.setString(8, request.getParameter("PROGRAM"));
                        s = request.getParameter("SSN");
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("SSN")));
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
                            "DELETE FROM Student WHERE SSN = ?");

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
                        ("SELECT * FROM Student");
            %> <!-- Add an HTML table header row to format the results -->
				<table border="1">
					<tr>
						<th>SSN</th>
						<th>ID</th>
						<th>First</th>
						<th>Last</th>
						<th>California Residents</th>
						<th>Foreign Student</th>
						<th>Department</th>
						<th>Enrolled</th>
						<th>Program</th>
						<!--  <th>Action</th>-->
					</tr>
					<tr>
						<form action="students.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="SSN" size="10"></th>
							<th><input value="" name="ID" size="10"></th>
							<th><input value="" name="FIRSTNAME" size="15"></th>
							<th><input value="" name="LASTNAME" size="15"></th>
							<th><input value="" name="ISCALRES" size="15"></th>
							<th><input value="" name="ISFOREIGN" size="15"></th>
							<th><input value="" name="DEPARTMENT" size="15"></th>
							<th><input value="" name="ISENROLLED" size="15"></th>
							<th><input value="" name="PROGRAM" size="15"></th>
							<th><input type="submit" value="Insert"></th>
						</form>
					</tr>

					<%-- -------- Iteration Code -------- --%>
					<%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

					<tr>
						<form action="students.jsp" method="get">
							<input type="hidden" value="update" name="action">

							<%-- Get the SSN, which is a number --%>
							<td><input value="<%= rs.getInt("SSN") %>" name="SSN"
								size="10"></td>

							<%-- Get the ID --%>
							<td><input value="<%= rs.getString("ID") %>" name="ID"
								size="10"></td>

							<%-- Get the FIRSTNAME --%>
							<td><input value="<%= rs.getString("FIRSTNAME") %>"
								name="FIRSTNAME" size="15"></td>

							<%-- Get the LASTNAME --%>
							<td><input value="<%= rs.getString("LASTNAME") %>"
								name="LASTNAME" size="15"></td>
								
							<%-- Get the ISCALRES --%>
							<td><input value="<%= rs.getString("ISCALRES") %>"
								name="ISCALRES" size="15"></td>
							
							<%-- Get the ISFOREIGN --%>
							<td><input value="<%= rs.getString("ISFOREIGN") %>"
								name="ISFOREIGN" size="15"></td>
								
							<%-- Get the DEPARTMENT --%>
							<td><input value="<%= rs.getString("DEPARTMENT") %>"
								name="DEPARTMENT" size="15"></td>
									
							<%-- Get the ISENROLLED --%>
							<td><input value="<%= rs.getString("ISENROLLED") %>"
								name="ISENROLLED" size="15"></td>
								
							<%-- Get the PROGRAM --%>
							<td><input value="<%= rs.getString("PROGRAM") %>"
								name="PROGRAM" size="15"></td>
								
							<%-- Button --%>
							<td><input type="submit" value="Update"></td>
						</form>
						<form action="students.jsp" method="get">
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
