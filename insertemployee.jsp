<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Employee Management System</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	<link rel="stylesheet" href="CSS/homeStyle.css">
	
	<!-- <script src="jQuery/jQuery.js"></script> -->
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
	<script>
        function updateDateTime() {
            var now = new Date();
            var options = { day: 'numeric', month: 'short',year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
            var formattedDateTime = now.toLocaleDateString('en-US', options);
            document.getElementById("currentDateTime").innerHTML = formattedDateTime;
        }

        // Update the time every second
        setInterval(updateDateTime, 1000);
 	</script>
</head>
<body onLoad="lod()">
	<div id="preloder"></div>
	
	<%
    // Get form data
    String clientEmail = request.getParameter("email");
    String clientName = request.getParameter("firstName"); // Assuming you have a client name field
	String departmentName = request.getParameter("deptName");
	String designation = request.getParameter("desig");
	int eSalary = Integer.parseInt(request.getParameter("salary"));
   
	String clientemail2="seedproject24@gmail.com";
	
    // SMTP server details
    String smtpServer = "smtp.gmail.com";
    int port = 587;
    final String username = "rangnegaurav06@gmail.com";
    final String password = "thlm svdf sjha vfwd";

    // Message content
    String subject = "From Gaurav! Testing Purpose!";
    String body = "Dear " + clientName + ",\n\nYour Info:\nName: "+clientName+"\nDepartment: "+departmentName+"\nDesignation: "+designation+"\nSalary: "+eSalary+"\n\nThis Mail From Gaurav,\nThis mail is a part of my SMTP based Employee Management System Project.\nThank You";

    try {
        // Create a new session
        Properties props = new Properties();
        props.put("mail.smtp.host", smtpServer);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        Session session1 = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        // Create a new message
        MimeMessage message = new MimeMessage(session1);
        message.setFrom(new InternetAddress(clientEmail)); // sender email
        InternetAddress[] recipents=new InternetAddress[2];
        recipents[0]=new InternetAddress(clientEmail);
        recipents[1]=new InternetAddress(clientemail2);
        
        message.addRecipients(Message.RecipientType.TO, recipents);
        
      //  message.addRecipient(Message.RecipientType.TO, new InternetAddress(clientEmail));
        message.setSubject(subject);
        message.setContent(body, "text/plain");

        // Send the message
        Transport.send(message);
%>

	<nav class="navbar navbar-expand-lg bg-body-tertiary bg-primary" data-bs-theme="dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="home.html">Home</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="employeeList.jsp">Employee List</a>
					</li>
 					<li class="nav-item">
          				<a class="nav-link active" aria-current="page" href="home.html">Add New Employee</a>
        			</li>
      			</ul>
      			<form class="d-flex" role="search">
        			<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        			<button class="btn btn-outline-success" type="submit">Search</button>
      			</form>
    		</div>
  		</div>
	</nav>

	<div class="d-flex bg">
		<div class="p-2 flex-grow-1"><span style="font-size:25px; padding-left: 15px;">&#x1F468;&#x200D;&#x1F4BC;</span>Employee Management System</div>
		<div class="p-2"><p id="currentDateTime" style="color: darkmagenta; padding-right: 15px;"></p></div>
	</div><br>
	     		
	<div class="container">
		<h1>Create Employee</h1>
  		<form action="insertemployee.jsp" method="get">
			<div class="form-group">
				<label for="firstName">First Name:</label>
      			<input type="text" id="firstName" name="firstName" class="form-control" placeholder="Enter First Name">
    		</div>
    		<div class="form-group">
				<label for="lastName">Last Name:</label>
      			<input type="text" id="lastName" name="lastName" class="form-control" placeholder="Enter Last Name">
    		</div>
			<div class="form-group">
				<label for="email">Email:</label>
            	<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email id" required>
          	</div>
          	<div class="form-group">
 	    		<label for="deptName">Department Name:</label>
      			<input type="text" name="deptName" class="form-control" placeholder="Enter Department Name" id="deptName">
			</div>
			<div class="form-group">
 	    		<label for="deptId">Department Id:</label>
      			<input type="number" id="deptId" name="deptId" class="form-control" placeholder="Enter Department Id">
			</div>
			<div class="form-group">
 	    		<label for="desig">Designation:</label>
      			<input type="text" name="desig" class="form-control" placeholder="Enter Designation" id="desig">
			</div>
			<div class="form-group">
 	    		<label for="salary">Salary:</label>
      		<input type="number" name="salary" class="form-control" placeholder="Enter Salary" id="salary">
			</div>
			<div class="form-group">
 	    		<label for="address">Address:</label>
      			<input type="text" name="address" class="form-control" placeholder="Enter Address" id="address">
			</div>
			<div class="form-group">
    			<button type="submit" class="btn3 form-control" value="Submit">Submit</button>
    		</div>
    		
    		<%
    		// Display a success message to the user
    	    	out.println("Hii "+clientName+",");
    		} catch (Exception e) {
        		out.println("Error sending email: " + e.getMessage());
        		// Handle the exception appropriately
    		}
			%>
    		
    		<div class="form-group">
    			<p style="text-align: center;">Verify Employee List After Pressing the Submit Button</p>
    		</div>
  		</form>
  	</div>
  	
	<%
		try{
			
			String fName = request.getParameter("firstName");
			String lName = request.getParameter("lastName");
			String eName = request.getParameter("email");
			String dName = request.getParameter("deptName");
			int dId = Integer.parseInt(request.getParameter("deptId"));
			String desig = request.getParameter("desig");
			int salary = Integer.parseInt(request.getParameter("salary"));
			String address = request.getParameter("address");
			
	
			Class.forName(application.getInitParameter("dbDriver"));

			Connection con = DriverManager.getConnection(application.getInitParameter("dbUrl"), application.getInitParameter("dbUser"), application.getInitParameter("dbPass"));
		
			String q = "insert into employeelist values((select max(employeeid)+1 from employeelist),?,?,?,?,?,?,?,?)";
		
			PreparedStatement ps = con.prepareStatement(q);
		
			ps.setString(1, fName );
			ps.setString(2, lName );
			ps.setString(3, eName );
			ps.setString(4, dName );
			ps.setInt(5, dId);
			ps.setString(6, desig);
			ps.setInt(7, salary);
			ps.setString(8, address);

			ps.executeUpdate();
			
			con.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		%>
		
		<script>
			var loader = document.getElementById('preloder');
			var nm = clientName.val();
			var d = new Date();
			var time = d.getHours();
			
			function lod(){
				loader.style.display = 'none';
				
			/* $(document).ready(function(){
					if (time>= 4 && time <= 11){
						alert("Hii!\nGood Morning "+nm+" !");
					}else if (time<=12 && time<16){
						alert("Hii!\nGood Afternoon "+nm+" !");
					}else if (time<=16 && time<21){
						alert("Hii!\nGood Evening "+nm+" !");
					}else{
						alert("Hii!\nGood Night "+nm+" !")
					}
				}); 
			*/		
			}
		</script>
</body>
</html>