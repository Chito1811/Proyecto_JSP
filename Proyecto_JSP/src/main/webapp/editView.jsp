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
<link rel="stylesheet" href="assets/css/modificationView.css">
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
    
    if (session != null) {
            String username = (String) session.getAttribute("user");
			uname = username;
            if (username == null) {
                response.sendRedirect("signIn.jsp");
            } 
        } else {
            response.sendRedirect("signIn.jsp");
        }

	String dato = request.getParameter("dato");
    long id = Long.parseLong(dato);

	String nameuser = "";
	String email = "";
	String pass = "";

	for (Usuario usuario: list){
		if (usuario.getId() == id){
            nameuser = usuario.getUsername();
			email = usuario.getEmail();
			pass = usuario.getPassword();
		}
	}
    
    %>
<header id="nav">
<a id="userListNav" href="usersList.jsp">Users list</a><br><br><br>
</header>

<article id="card">
		<header>
		<div class="profile">
        <img src="./assets/img/profile.webp" alt="Profile Picture"></div>

		<form id="miFormulario" action="doEditView.jsp">
		<div class="input-field">
                    <input onchange="checkField('email','emailhelp')" id="email" type="text" name="email" placeholder="Email" value="<%= email %>"  />
                </div>
                <div id="emailhelp" style="visibility: hidden; color: red;">Invalid email.</div> 
                <div class="input-field">
                    <input style="flex-grow: 1;padding-right: 30px;" onchange="checkField('password','passwordHelp')" id="password" type="password" name="password" placeholder="Password" value="<%= pass %>" /> 
                    <span style="cursor: pointer;" class="toggle-button" onclick="togglePassword()">🙈</span>
                </div>
                <div id="passwordHelp" style="visibility: hidden; color: red;">Invalid password. <br>
                </div> 
                <div class="input-field">
                    <input readonly onchange="checkField('username','usernamehelp')" type="text" name="username" id="username" placeholder="Username" value="<%= nameuser %>" />
                </div>
                <div id="usernamehelp" style="visibility: hidden; color: red;">Invalid username. <br>
                </div>
				<button class="contact-button">Accept changes</button>
		</form>
		
		</header>

</article>

<script>
document.getElementById("miFormulario").addEventListener("submit", function(event) {
    var usernameInput = document.getElementById("username");
    var usernameHelp = document.getElementById("usernamehelp");
    var username = usernameInput.value.trim();

    if (username === '' || username.length < 8 || username.length > 12) {
        usernameInput.style.borderColor="red";
        usernameHelp.style.visibility = "visible";
        event.preventDefault();
        alert("- Usename length: 8-12 characters.");
    } else {
        usernameInput.style.borderColor="#ccc";
        usernameHelp.style.visibility = "hidden";
    }
});

document.getElementById("miFormulario").addEventListener("submit", function(event) {
    var passwordInput = document.getElementById("password");
    var passwordHelp = document.getElementById("passwordHelp");
    var password = passwordInput.value.trim();

    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$/;

    if (!regex.test(password)) {
        document.getElementById('password').style.borderColor="red"
        passwordHelp.style.visibility = "visible";
        event.preventDefault();
        alert("- Password length: 8-15 characters \n- Must contain one number.\n- Must contain one upper and lower case letter.");
    } else {
        document.getElementById('password').style.borderColor="#ccc"
        passwordHelp.style.visibility = "hidden";
    }
});

document.getElementById("miFormulario").addEventListener("submit", function(event) {
    var emailInput = document.getElementById("email");
    var emailHelp = document.getElementById("emailhelp");
    var email = emailInput.value.trim();
    var emailRegex = /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;

    if (!emailRegex.test(email)) {
        document.getElementById('email').style.borderColor="red"
        emailHelp.style.visibility = "visible";
        event.preventDefault();
    } else {
        emailHelp.style.visibility = "hidden";
        document.getElementById('email').style.borderColor="white"
    }
});

function checkField(inputId, helpId) {
    var input = document.getElementById(inputId);
    var help = document.getElementById(helpId);

    if (input.value === "") {
        help.style.visibility = "visible";
        input.style.borderColor = "red"
    } else {
        help.style.visibility = "hidden";
        input.style.borderColor = "white"
    }
}

function togglePassword() {
            var passwordField = document.getElementById('password');
            var toggleButton = document.querySelector('.toggle-button');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleButton.textContent = '👁️'; // Cambia el icono al de "ocultar"
            } else {
                passwordField.type = 'password';
                toggleButton.textContent = '🙈'; // Cambia el icono al de "mostrar"
            }
        }

</script>


</body>
</html>