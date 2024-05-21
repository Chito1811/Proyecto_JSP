<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="modules.connectionpool.ConnectionPool"%>
<%@page import="modules.usuarios.UsuarioService"%>
<%@page import="modules.usuarios.Usuario"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/profile.css">
</head>
</head>
<body>


<%
    //Usuario de la base de datos
    String user = "Ignacio";
    //Contraseña de la base de datos
    String password = "1234";
    //Pool de conexiones a la base de datos
    ConnectionPool pool = new ConnectionPool("jdbc:mysql://localhost:3306/Proyecto_jsp_2", user, password);
    UsuarioService userv = new UsuarioService(pool.getConnection());
    ArrayList<Usuario> list = userv.requestAll("");

	String uname = "";
	String username = "";
    
    if (session != null) {
            username = (String) session.getAttribute("user");
			uname = username;
            if (username == null) {
                response.sendRedirect("signIn.jsp");
            } 
        } else {
            response.sendRedirect("signIn.jsp");
        }

	long id = 0;
	String email = "";
	String pass = "";

	for (Usuario usuario: list){
		if (usuario.getUsername().equals(uname)){
			id = usuario.getId();
			email = usuario.getEmail();
			pass = usuario.getPassword();
		}
	}
    
    %>
<header id="nav">
<% if (username.equals("JuanArrow")) {%>
<a id="userListNav" href="usersList.jsp">Users list</a>
<% } else{%>
<a id="userListNav" href="usersListNoAdmin.jsp">Users list</a>
<% } %>
<br>
<a id="signOutBtn" href="closeSession.jsp">Sign Out</a>
<br>
<br>

</header>

<article id="card">
		<header>
		<div class="profile">
        <img src="./assets/img/profile.webp" alt="Profile Picture"></div>

		<%
		out.print(String.format("<h1 class='name'>%s</h1>",uname));
		%>
		<%
		out.print(String.format("<h4 class='email'>%s</h4>", email));
		%>
		<%
		out.print(String.format("<p class='password'>Password: %s</p>", pass));
		%>
		
		</header>

		<% 
		String x = (String) session.getAttribute("user");
		if (!x.equals("AdminUser")){ %>
		<footer>
    	<a class="contact-button" href="modificationView.jsp">Modify Information</a>
		</footer>

		<% } %>
		
</article>




</body>
</html>